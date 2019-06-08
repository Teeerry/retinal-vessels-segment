% =========================================================================
% 输入一张图片进行简单测试
% =========================================================================
close all; clc;
%% 预处理
im_rgb = im2double(imread('.\data\Images\DRIVE\test\images\01_test.tif'));

% 掩模生成
im_mask = im_rgb(:,:,2) > (20/255);    % For DRIVE
% im_mask = im_rgb(:,:,2) > (35/255);  % For STARE
im_mask = double(imerode(im_mask, strel('disk',3)));

figure
subplot(2,2,1),imshow(im_rgb),title('原图');
subplot(2,2,2),imshow(im_mask),title('掩模');

% 提取新的绿色通道
im_green = im_rgb(:,:,2);
subplot(2,2,3),imshow(im_green),title('处理后绿色通道')

% 对比度增强 CLAHE
im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);
subplot(2,2,4),imshow(im_enh),title('对比度增强')

%% 处理一
% 替换黑色背景
[im_enh1] = replace_black_ring2(im_enh,im_mask);
im_gray = imcomplement(im_enh1); 
figure
subplot(2,2,1),imshow(im_gray),title('灰度图像')

% 顶帽变换
se = strel('disk',10);
im_top = imtophat(im_gray,se);  
subplot(2,2,2),imshow(im_top),title('形态学处理')

% OTSU 阈值处理
level = graythresh(im_top);
im_thre = imbinarize(im_top,level) & im_mask;
subplot(2,2,3), imshow(im_thre),title('Otsu 阈值化')

% 删除小面积对象
im_rmpix = bwareaopen(im_thre,100,8);
subplot(2,2,4), imshow(im_rmpix),title('去除小像素')
% 根据绿色通道增强与之处理的结果，去除部分非血管像素
[im_sel] = vessel_point_selected(im_gray,im_rmpix,im_green);
figure
subplot(1,3,1),imshow(im_sel),title('粗血管提取')
%% 处理二
im_thin_vess = MatchFilterWithGaussDerivative(im_enh, 1, 4, 12, im_mask, 2.3, 30);
subplot(1,3,2), imshow(im_thin_vess),title('细血管提取')

%% 后处理
% 合并处理一处理二结果
[im_final] = combine_thin_vessel(im_thin_vess,im_sel);
subplot(1,3,3),imshow(im_final),title('分割结果')
%% 算法效果测量
g_truth = imread('.\data\Images\DRIVE\test\1st_manual\01_manual1.gif');

[Se, Sp, Ppv, Npv, Acc] = performance_measure(im_final,g_truth);
% dice 系数
g_truth = imbinarize(g_truth);
dice = 2*sum(sum((im_final) .* g_truth))/(sum(sum(im_final))+ sum(sum(g_truth)));
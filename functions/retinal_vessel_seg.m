function [Se, Sp, Ppv, Npv, Acc, Dice] = retinal_vessel_seg(image,manual)
%视网膜血管提取函数
%   血管提取主要分为四部分：预处理、粗血管提取、细血管提取、后处理；
%   输入：
%           image： 测试图像
%           manual：参考图像
%   输入：
%           Se  = Sensitivity
%           Sp  = Specificity
%           Ppv = Positive predictive value
%           Npv = Negative predictive value
%           Acc = Accuracy
%           Dice = Dice loss

%% 预处理
im_rgb = im2double(image);
% 掩模生成
im_mask = im_rgb(:,:,2) > (20/255);    % For DRIVE
% im_mask = im_rgb(:,:,2) > (35/255);  % For STARE
im_mask = double(imerode(im_mask, strel('disk',3)));
% 提取新的绿色通道
im_green = im_rgb(:,:,2);
% 对比度增强 CLAHE
im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);

%% 处理一
% 替换黑色背景
[im_enh1, mean_val] = replace_black_ring2(im_enh,im_mask);
im_gray = imcomplement(im_enh1); 
% 顶帽变换
se = strel('disk',10);
im_top = imtophat(im_gray,se);  
% OTSU 阈值处理
level = graythresh(im_top);
im_thre = imbinarize(im_top,level) & im_mask;
% 删除小面积对象
im_rmpix = bwareaopen(im_thre,100,8);
% 根据绿色通道增强与阈值处理的结果，去除部分非血管像素
[im_sel] = vessel_point_selected(im_gray,im_rmpix,mean_val);
%% 处理二
im_thin_vess = MatchFilterWithGaussDerivative(im_enh, 1, 4, 12, im_mask, 2.3, 30);

%% 后处理
% 合并处理一处理二结果
[im_final] = combine_thin_vessel(im_thin_vess,im_sel);
figure,imshow(im_final),title('血管分割结果')
%% 算法效果测量
[Se, Sp, Ppv, Npv, Acc] = performance_measure(im_final,manual);
manual = imbinarize(manual);
Dice = 2*sum(sum((im_final) .* manual))/(sum(sum(im_final))+ sum(sum(manual)));

end


% =========================================================================
% ����һ��ͼƬ���м򵥲���
% =========================================================================
close all; clc;
%% Ԥ����
im_rgb = im2double(imread('.\data\Images\DRIVE\test\images\01_test.tif'));

% ��ģ����
im_mask = im_rgb(:,:,2) > (20/255);    % For DRIVE
% im_mask = im_rgb(:,:,2) > (35/255);  % For STARE
im_mask = double(imerode(im_mask, strel('disk',3)));

figure
subplot(2,2,1),imshow(im_rgb),title('ԭͼ');
subplot(2,2,2),imshow(im_mask),title('��ģ');

% ��ȡ�µ���ɫͨ��
im_green = im_rgb(:,:,2);
subplot(2,2,3),imshow(im_green),title('�������ɫͨ��')

% �Աȶ���ǿ CLAHE
im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);
subplot(2,2,4),imshow(im_enh),title('�Աȶ���ǿ')

%% ����һ
% �滻��ɫ����
[im_enh1] = replace_black_ring2(im_enh,im_mask);
im_gray = imcomplement(im_enh1); 
figure
subplot(2,2,1),imshow(im_gray),title('�Ҷ�ͼ��')

% ��ñ�任
se = strel('disk',10);
im_top = imtophat(im_gray,se);  
subplot(2,2,2),imshow(im_top),title('��̬ѧ����')

% OTSU ��ֵ����
level = graythresh(im_top);
im_thre = imbinarize(im_top,level) & im_mask;
subplot(2,2,3), imshow(im_thre),title('Otsu ��ֵ��')

% ɾ��С�������
im_rmpix = bwareaopen(im_thre,100,8);
subplot(2,2,4), imshow(im_rmpix),title('ȥ��С����')
% ������ɫͨ����ǿ��֮����Ľ����ȥ�����ַ�Ѫ������
[im_sel] = vessel_point_selected(im_gray,im_rmpix,im_green);
figure
subplot(1,3,1),imshow(im_sel),title('��Ѫ����ȡ')
%% �����
im_thin_vess = MatchFilterWithGaussDerivative(im_enh, 1, 4, 12, im_mask, 2.3, 30);
subplot(1,3,2), imshow(im_thin_vess),title('ϸѪ����ȡ')

%% ����
% �ϲ�����һ��������
[im_final] = combine_thin_vessel(im_thin_vess,im_sel);
subplot(1,3,3),imshow(im_final),title('�ָ���')
%% �㷨Ч������
g_truth = imread('.\data\Images\DRIVE\test\1st_manual\01_manual1.gif');

[Se, Sp, Ppv, Npv, Acc] = performance_measure(im_final,g_truth);
% dice ϵ��
g_truth = imbinarize(g_truth);
dice = 2*sum(sum((im_final) .* g_truth))/(sum(sum(im_final))+ sum(sum(g_truth)));
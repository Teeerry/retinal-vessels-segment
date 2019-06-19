function [Se, Sp, Ppv, Npv, Acc, Dice] = retinal_vessel_seg(image,manual)
%����ĤѪ����ȡ����
%   Ѫ����ȡ��Ҫ��Ϊ�Ĳ��֣�Ԥ������Ѫ����ȡ��ϸѪ����ȡ������
%   ���룺
%           image�� ����ͼ��
%           manual���ο�ͼ��
%   ���룺
%           Se  = Sensitivity
%           Sp  = Specificity
%           Ppv = Positive predictive value
%           Npv = Negative predictive value
%           Acc = Accuracy
%           Dice = Dice loss

%% Ԥ����
im_rgb = im2double(image);
% ��ģ����
im_mask = im_rgb(:,:,2) > (20/255);    % For DRIVE
% im_mask = im_rgb(:,:,2) > (35/255);  % For STARE
im_mask = double(imerode(im_mask, strel('disk',3)));
% ��ȡ�µ���ɫͨ��
im_green = im_rgb(:,:,2);
% �Աȶ���ǿ CLAHE
im_enh = adapthisteq(im_green,'numTiles',[8 8],'nBins',128);

%% ����һ
% �滻��ɫ����
[im_enh1, mean_val] = replace_black_ring2(im_enh,im_mask);
im_gray = imcomplement(im_enh1); 
% ��ñ�任
se = strel('disk',10);
im_top = imtophat(im_gray,se);  
% OTSU ��ֵ����
level = graythresh(im_top);
im_thre = imbinarize(im_top,level) & im_mask;
% ɾ��С�������
im_rmpix = bwareaopen(im_thre,100,8);
% ������ɫͨ����ǿ����ֵ����Ľ����ȥ�����ַ�Ѫ������
[im_sel] = vessel_point_selected(im_gray,im_rmpix,mean_val);
%% �����
im_thin_vess = MatchFilterWithGaussDerivative(im_enh, 1, 4, 12, im_mask, 2.3, 30);

%% ����
% �ϲ�����һ��������
[im_final] = combine_thin_vessel(im_thin_vess,im_sel);
figure,imshow(im_final),title('Ѫ�ָܷ���')
%% �㷨Ч������
[Se, Sp, Ppv, Npv, Acc] = performance_measure(im_final,manual);
manual = imbinarize(manual);
Dice = 2*sum(sum((im_final) .* manual))/(sum(sum(im_final))+ sum(sum(manual)));

end


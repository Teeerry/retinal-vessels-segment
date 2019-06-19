function [im_new, mean_val] = replace_black_ring2(im_enh,im_mask)
%���۵�ͼ��ĺ�ɫ���������ѡȡ��3��(50,50,30)��������ľ�ֵ���
%   ���룺
%           im_enh ���Աȶ���ǿ��ͼ��
%           im_mask����ģ
%   ���룺
%           im_new ���滻���ͼ��
%           mean_val����ֵ


[row, col] = size(im_mask);
area_sum  = zeros(50,50);     

posit = ceil((rand(3,2)+1)* 1/3*min(row,col));
% figure
for i = 1:3
    x = posit(i,1);y = posit(i,2);
    area_rand= im_enh(x-25:x+24,y-25:y+24); % ��ѡȡ����
    area_sum = area_sum + area_rand;
%     subplot(2,2,i)
%     imshow(area_rand)
end

area_sum = area_sum.*1/3;
% subplot(2,2,4), imshow( area_sum)

mean_val = mean(mean(area_sum));    % ����ÿһά�ľ�ֵ
mean_mask = ~im_mask.*mean_val;     % �����±���
im_new = mean_mask + im_enh.*im_mask;       % ���ӱ���

end


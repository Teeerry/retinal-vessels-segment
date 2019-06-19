function [im_sel] = vessel_point_selected(im_gray,im_thre,mean_val)
%���ݻҶ�ͼ������ֵ�����ͼ��Ľ�һ���Ż�
%   �Է� 0 ����λ�ö�Ӧ�ĻҶ�ͼ���Լ���ֵ���������ص�ľ���
%  ������ֵ�뱳������Ѫ�����صĲ����һ������Ѫ��
%   ���룺
%           im_gray ���Ҷ�ͼ��
%           im_thre ����ֵ����ͼ��
%           mean_val��������ֵ
%   ���룺
%           im_sel  ���Ż�ͼ��

[row, col] = size(im_gray);
im_sel = zeros(row, col);

p_max = max(max(im_gray));
p_min = mean_val;

for i = 1:row
    for j = 1:col
        if(im_thre(i,j) ~= 0)
            if(abs(im_gray(i,j)-p_max) < abs(im_gray(i,j)-p_min))
                % vessel pixel
                im_sel(i,j) = 1;
            end            
        end   
    end
end

% figure, imshow(im_sel),title('im pixel selected');
im_med = medfilt2(im_thre,[3,3]); 
im_sel = im_sel| im_med;
% figure, imshow(im_sel),title('im pixel selected');

end


function [im_final] = combine_thin_vessel(im_thin_vess,im_sel)
%��ϸСѪ��ͼƬ��im_thin_vess��Ϊ��������϶�ñ��ֵ�����Ķ�ֵͼ��im_sel��
%   im_sel�е� 1 ��im_thin_vess��Ӧλ�õ� 8 ������1��������Ϊ0����Ϊ1
%   ���룺
%           im_sel ��     ��Ѫ�ܴ�����
%           im_thin_vess��ϸѪ�ܴ�����
%   ���룺
%           im_final  �����շָ���

[row, col] = size(im_thin_vess);

kernel = [1, 1, 1;
          1, 0, 1;
          1, 1, 1];    
im_final = im_thin_vess;

% �����Ӧλ�� 8 ������ 1 ������
for i = 2:row - 1
    for j = 2:col - 1
        if(im_sel(i,j) ~= 0 && sum(sum((im_thin_vess(i-1:i+1,j-1:j+1).*kernel)))> 0)
            im_final(i,j) = im_sel(i,j);
        end   
    end
end

end


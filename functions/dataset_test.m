function [data_result] = dataset_test(file_path_im,file_path_manual,im_postfix,ma_postfix)
%�����ݼ��ڵĴ������ݽ��в���,�����ɲ������
%   ���룺
%           file_path_im������ͼ��·��
%           file_path_manual���ο�ͼ��·��
%           im_postfix������ͼ���׺
%           ma_postfix���ο�ͼ���׺
%   ���룺
%           date_result��������ݽṹ��


% ��ȡ�ļ���������ͼ��
img_path_list_im = dir(strcat(file_path_im,im_postfix)); 
img_path_list_manual = dir(strcat(file_path_manual,ma_postfix)); 

img_num = length(img_path_list_im); % ��ȡͼ��������
data_result = struct([]);            % ��ʼ�����Խ��

if img_num > 0 % ������������ͼ��
        for i = 1:img_num % ��һ��ȡͼ��
            image_name = img_path_list_im(i).name;      % ����ͼ��
            manual_name = img_path_list_manual(i).name; % �ο�ͼ��
            image =  imread(strcat(file_path_im,image_name));
            manual =  imread(strcat(file_path_manual,manual_name));
            
            % ��ʾ���ڴ����ͼ����
            fprintf('%d %s\n',i,strcat(file_path_im,image_name));
            
            %ͼ������� 
            data_result(i).image = image_name;
            data_result(i).manual = manual_name;
            
            [Se, Sp, ~, ~, Acc, Dice] = retinal_vessel_seg(image,manual);
            data_result(i).Accuracy = Acc;
            data_result(i).Sensitivity = Se;
            data_result(i).Specificity = Sp;
            data_result(i).Dice = Dice;
        end
end

end


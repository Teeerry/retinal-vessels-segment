function [data_result] = dataset_test(file_path_im,file_path_manual,im_postfix,ma_postfix)
%对数据集内的大量数据进行测试,并生成测量结果
%   输入：
%           file_path_im：测试图像路径
%           file_path_manual：参考图像路径
%           im_postfix：测试图像后缀
%           ma_postfix：参考图像后缀
%   输入：
%           date_result：结果数据结构体


% 获取文件夹中所有图像
img_path_list_im = dir(strcat(file_path_im,im_postfix)); 
img_path_list_manual = dir(strcat(file_path_manual,ma_postfix)); 

img_num = length(img_path_list_im); % 获取图像总数量
data_result = struct([]);            % 初始化测试结果

if img_num > 0 % 有满足条件的图像
        for i = 1:img_num % 逐一读取图像
            image_name = img_path_list_im(i).name;      % 测试图像
            manual_name = img_path_list_manual(i).name; % 参考图像
            image =  imread(strcat(file_path_im,image_name));
            manual =  imread(strcat(file_path_manual,manual_name));
            
            % 显示正在处理的图像名
            fprintf('%d %s\n',i,strcat(file_path_im,image_name));
            
            %图像处理过程 
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


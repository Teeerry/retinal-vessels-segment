% =========================================================================
% title: 眼底血管分割
% author： 罗天林、郑圳坚
% email：16tlluo@stu.edu.cn
% date: 2019-06-04
% =========================================================================

close all; clc;
%% 添加路径
addpath(genpath('./data'));
addpath(genpath('./functions'));
tic;
%% 简单测试
% a_test_demo

%% 数据集测试
% =========================================================================
% 测试一 DRIVE
% =========================================================================
file_path_im = './data/Images/DRIVE/test/images/';         % 测试图像路径
file_path_manual = './data/Images/DRIVE/test/1st_manual/'; % 参考图像路径
im_postfix = '*.tif';     % 测试图像后缀
ma_postfix = '*.gif';     % 参考图像后缀
[result_drive] = dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);
save('result_drive.mat','result_drive') % 保存测试结果

% =========================================================================
% 测试二 STARE
% =========================================================================
% file_path_im = './data/Images/STARE/STARE_Images/';             % 测试图像路径
% file_path_manual = './data/Images/STARE/groundtruth_STARE_ah/'; % 参考图像路径
% im_postfix = '*.ppm';     % 测试图像后缀
% ma_postfix = '*.ppm';     % 参考图像后缀
% [result_stare] = dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);
% save('result_stare.mat','result_stare') % 保存测试结果

% =========================================================================
% 测试三 CHASEDB1
% =========================================================================
% file_path_im = './data/Images/CHASEDB1/CHASEDB1_Images/';           % 测试图像路径
% file_path_manual = './data/Images/CHASEDB1/groundtruth1_CHASEDB1/'; % 参考图像路径  
% im_postfix = '*.jpg';     % 测试图像后缀
% ma_postfix = '*.png';     % 参考图像后缀
% [result_CHASEDB1] = dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);
% save('result_CHASEDB1.mat','result_CHASEDB1') % 保存测试结果

%% 结束计时
toc;
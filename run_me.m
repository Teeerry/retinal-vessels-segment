% =========================================================================
% title: �۵�Ѫ�ָܷ�
% author�� �����֡�֣�ڼ�
% email��16tlluo@stu.edu.cn
% date: 2019-06-04
% =========================================================================

close all; clc;
%% ���·��
addpath(genpath('./data'));
addpath(genpath('./functions'));
tic;
%% �򵥲���
% a_test_demo

%% ���ݼ�����
% =========================================================================
% ����һ DRIVE
% =========================================================================
file_path_im = './data/Images/DRIVE/test/images/';         % ����ͼ��·��
file_path_manual = './data/Images/DRIVE/test/1st_manual/'; % �ο�ͼ��·��
im_postfix = '*.tif';     % ����ͼ���׺
ma_postfix = '*.gif';     % �ο�ͼ���׺
[result_drive] = dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);
save('result_drive.mat','result_drive') % ������Խ��

% =========================================================================
% ���Զ� STARE
% =========================================================================
% file_path_im = './data/Images/STARE/STARE_Images/';             % ����ͼ��·��
% file_path_manual = './data/Images/STARE/groundtruth_STARE_ah/'; % �ο�ͼ��·��
% im_postfix = '*.ppm';     % ����ͼ���׺
% ma_postfix = '*.ppm';     % �ο�ͼ���׺
% [result_stare] = dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);
% save('result_stare.mat','result_stare') % ������Խ��

% =========================================================================
% ������ CHASEDB1
% =========================================================================
% file_path_im = './data/Images/CHASEDB1/CHASEDB1_Images/';           % ����ͼ��·��
% file_path_manual = './data/Images/CHASEDB1/groundtruth1_CHASEDB1/'; % �ο�ͼ��·��  
% im_postfix = '*.jpg';     % ����ͼ���׺
% ma_postfix = '*.png';     % �ο�ͼ���׺
% [result_CHASEDB1] = dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);
% save('result_CHASEDB1.mat','result_CHASEDB1') % ������Խ��

%% ������ʱ
toc;
close all
clear all
clc

[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick an Image File');
Img = imread([pathname,filename]);
Img = imresize(Img,[256,256]);
I = imadjust(Img,stretchlim(Img));
figure, imshow(I);title('Contrast Enhanced');

% Extract Features from query image
[Feature_Vector] = Extract_FeaturesofSoil(I);
whos Feature_Vector

% Load Training Features
load('TrainFeat_Soil.mat')

test = Feature_Vector;
result = multisvm(TrainFeat,Train_Label,test);
disp(result);

if result == 1
    helpdlg(' Clay ');
    disp(' Clay ');
elseif result == 2
    helpdlg(' Clayey Peat ');
    disp('Clayey Peat');
elseif result == 3
    helpdlg(' Clayey Sand ');
    disp(' Clayey Sand ');
elseif result == 4
    helpdlg(' Humus Clay ');
    disp(' Humus Clay ');
elseif result == 5
    helpdlg(' Peat ');
    disp(' Peat ');
elseif result == 6
    helpdlg(' Sandy Clay ');
    disp('Sandy Clay');
elseif result == 7
    helpdlg(' Silty Sand ');
    disp(' Silty Sand ');
end

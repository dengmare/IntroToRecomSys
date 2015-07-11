clear;clc; 

[num,txt,raw] = xlsread('Assignment 6.xlsx','Items');
ItemFeature1 = num(4:end, 3);

movieID = num(4:end, 1);

%% Part I: Top movies for feature 1
[sortedFeature, sortedFeatureIndex] = sort(ItemFeature1,'descend');

movieID(sortedFeatureIndex(1:5));

%% Part III: Top movies for user 4469
weights = num(2,3:17);
itemFeatures = num(4:end, 3:end);
userFeatures = xlsread('Assignment 6.xlsx', 'Users', 'B2:P26');

predictScores = itemFeatures .* userFeatures 
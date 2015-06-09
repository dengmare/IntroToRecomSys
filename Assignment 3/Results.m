clc;

%% Get the movies IDs
[num,txt,raw] = xlsread('Assignment 3.xls','movie-row');
token = strtok(raw(:,1), ':');
movieID = zeros(size(token,1),1);
iIdC = 1;
iTokenC = 1;
while iTokenC <= size(token,1)
    if ~isnan(token{iTokenC}) & str2double(token(iTokenC))~=0
        movieID(iIdC) = str2double(token{iTokenC});
        iIdC=iIdC + 1; 
    end
    iTokenC=iTokenC + 1;
end
movieID = movieID(movieID~=0);

%% Get the user ID numbers
token = strtok(raw(1,:), ':');
userID = zeros(size(token,2),1);
iIdC = 1;
iTokenC = 1;
while iTokenC <= size(token,2)
    if ~isnan(token{iTokenC}) 
        userID(iIdC) = token{iTokenC};
        iIdC=iIdC + 1; 
    end
    iTokenC=iTokenC + 1;
end
userID = userID(userID~=0);

%% Complete the user-by-user correlations matrix.
% To check your math, note that the correlation between users 1648 and 5136 is 0.40298
% and the correlation between users 918 and 2824 is -0.31706. 
% All correlations should be between -1 and 1, and the diagonal should be all 1's (since they are self-correlations).

% corr([num(2:end, num(1,:)==1648), num(2:end, num(1,:)==5136)], 'rows', 'complete')

corAll = corrcoef(num(2:end,:), 'rows', 'pairwise');

%% Identify the top 5 neighbors (the users with the 5 largest, positive correlations) for users 3867 and 89

sortedCorAll = corAll;
sortedCorAll(logical(eye(size(sortedCorAll))))=-2;
[sortedCorAll, sortedCorIndex] = sort(sortedCorAll,'descend');

%% Get all means
meansUser = nanmean( num(2:end,:) );

%% Get User 3712's predicted rating without
idNum = 3525;
withoutnormalization;

%% Get User 3867's predicted rating without
idNum = 3867;
withoutnormalization;

%% Get User 89's predicted rating without
idNum = 89;
withoutnormalization;



%% Get User 3712's predicted rating with 
idNum = 3525;
normalization;

%% Get User 3867's predicted rating with 
idNum = 3867;
normalization;

%% Get User 89's predicted rating with 
idNum = 89;
normalization;
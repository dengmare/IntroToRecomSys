clear;
clc;

%% Get the movies IDs
[num,txt,raw] = xlsread('Assignment 5.xlsx','Ratings');
token = strtok(raw(1,:), ':');
movieID = zeros(size(token,2),1);

iIdC = 1;
iTokenC = 1;
while iTokenC <= size(token,2)
    if ~isnan(str2double(token{iTokenC}))
        movieID(iIdC) = str2double(token{iTokenC});
        iIdC=iIdC + 1; 
    end
    iTokenC=iTokenC + 1;
end

movieID = movieID(movieID~=0);

%% Get the user ID numbers
userID = num(1:20,1);

%% Get rating matrix
rating = num(1:20,2:21);

%% Check : Similarity between Toy Story and Star Wars, raw: 0.645
toyStory = rating(:,movieID==1);
toyStory(isnan(toyStory))=0;

starWars = rating(:,movieID==1210);
starWars(isnan(starWars))=0;

corTS = starWars' * toyStory / ( norm(starWars) * norm(toyStory) );

%% Part I: Top 5 for toy story raw 
cosToy = ones(size(rating,2),1);
for i = 1: size(rating,2)
    obj = rating(:, i);
    obj(isnan(obj))=0;
    
    cosToy(i) = toyStory' * obj / ( norm(obj) * norm(toyStory) );
end

cosToy(cosToy<0) = 0;
cosToy(movieID==1) = -2;

[sortedCosToy, sortedCosToyIndex ]= sort(cosToy,'descend');

movieID(sortedCosToyIndex(1:5));

%% Similarity between all, raw
cosAllItems = ones(size(rating,2),size(rating,2));
for i = 1: size(rating,2)
    obji = rating(:, i);
    obji(isnan(obji))=0;
    
    for j = 1:size(rating,2)
        if i==j
            cosAllItems(i,j) = 1;
            continue;
        end
        
        if i > j
            cosAllItems(i,j) = cosAllItems(j,i);
            continue;
        end
        
        objj = rating(:, j);
        objj(isnan(objj))=0;
        
        cosAllItems(i,j) = obji' * objj / ( norm(obji) * norm(objj) );
    end
end

% cosAllItems(movieID==1210,movieID==1);
cosAllItems(cosAllItems<0) = 0;

%% Part II: Top recommended movie for user 5277
uID = 5277;
rating5277 = rating(userID==uID,:);
rating5277(isnan(rating5277)) = 0;

commonMultiply = zeros(size(cosAllItems));
for i=1:size(rating5277,2)
    commonMultiply(:,i) = and(rating5277', cosAllItems(:,i));
end

denominator = sum(commonMultiply .* cosAllItems); 

predict5277 = rating5277 * cosAllItems ./ denominator;

[sortedRating5277,sortedInRatingIndex5277] = sort(predict5277, 'descend');

movieID(sortedInRatingIndex5277(1:5))
sortedRating5277;

%% Similarity between Toy Story and Star Wars, normalized: -0.378
% Get all normalized ratings
num =  xlsread('Assignment 5.xlsx','NormRatings');
normRating = num(1:20,2:21);

toyStory = normRating(:,movieID==1);
toyStory(isnan(toyStory))=0;

starWars = normRating(:,movieID==1210);
starWars(isnan(starWars))=0;

corTS = starWars' * toyStory / ( norm(starWars) * norm(toyStory) );

%% Get all correlations with normalizations
cosNormAllItems = ones(size(normRating,2),size(normRating,2));
for i = 1: size(normRating,2)
    obji = normRating(:, i);
    obji(isnan(obji))=0;
    
    for j = 1:size(normRating,2)
        if i==j
            cosNormAllItems(i,j) = 1;
            continue;
        end
        
        if i > j
            cosNormAllItems(i,j) = cosNormAllItems(j,i);
            continue;
        end
        
        objj = normRating(:, j);
        objj(isnan(objj))=0;
        
        cosNormAllItems(i,j) = obji' * objj / ( norm(obji) * norm(objj) );
    end
end

%% Part III:  get top 5 for toyXX
uID = 1;
cosToy = cosNormAllItems(movieID==uID,:);
cosToy(uID) = -2;

[sortedNormCosToy, sortedNormCosToyIndex ]= sort(cosToy,'descend');

movieID(sortedNormCosToyIndex(1:5));
% sortedNormCosToy(1:5)

%% Part IV: normalized recommendation for 5277
cosNormAllItems(cosNormAllItems<0)=0;
uID = 5277;
normRating5277 = normRating(userID==5277,:);



% Get the denominator
commonMultiply = zeros(size(cosNormAllItems));
for i=1:size(normRating,2)
    commonMultiply(:,i) = and(normRating5277', cosNormAllItems(:,i));
end

denominator = sum(commonMultiply .* cosNormAllItems); 

predictNorm5277 = normRating5277 * cosNormAllItems ./ denominator;
[sortedNormRating, sortedNormRatingIndex] = sort(predictNorm5277,'descend');
movieID(sortedNormRatingIndex(1:5));
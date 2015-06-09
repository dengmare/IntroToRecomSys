FiveNeighbourID = sortedCorIndex(1:5,userID==idNum);

% with normalization
predictRaw = repmat(sortedCorAll(1:5,userID==idNum)', size(num, 1)-1, 1) .* ...
    (  num(2:end,FiveNeighbourID) -  repmat(meansUser(FiveNeighbourID), size(num, 1)-1,1) );

predictRaw(isnan(predictRaw))=0;

rowWeight = repmat(sortedCorAll(1:5,userID==idNum)', size(num, 1)-1, 1).*(predictRaw~=0);

%with mormalization
predict = repmat(meansUser(userID==idNum),size(num, 1)-1,1) + sum(predictRaw,2) ./ sum(rowWeight,2);

predict(isnan(predict)) = -10;
[sortedRate, sortedMovie] = sort(predict,1,'descend');

fprintf('top 3 rates for %d with normalization',idNum);
sortedRate(1:3)
fprintf('top 3 movies for %d with normalization',idNum);
movieID(sortedMovie(1:3))
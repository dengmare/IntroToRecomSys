FiveNeighbourID = sortedCorIndex(1:5,userID==idNum);

% without normalization
predictRaw = repmat(sortedCorAll(1:5,userID==idNum)', size(num, 1)-1, 1) .* num(2:end,FiveNeighbourID);

predictRaw(isnan(predictRaw))=0;

rowWeight = repmat(sortedCorAll(1:5,userID==idNum)', size(num, 1)-1, 1).*(predictRaw~=0);

%without normalization
predict = sum(predictRaw,2) ./ sum(rowWeight,2);

predict(isnan(predict)) = -10;
[sortedRate, sortedMovie] = sort(predict,1,'descend');

fprintf('top 3 rates for %d without normalization',idNum);
sortedRate(1:3)
fprintf('top 3 movies for %d without normalization',idNum);
movieID(sortedMovie(1:3))
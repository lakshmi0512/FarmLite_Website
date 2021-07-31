function relativeDeviation(numOfReturnedImages, queryImageFeatureVector, dataset)
query_im_name = queryImageFeatureVector(:, end);
dataset_im_names = dataset(:, end);

queryImageFeatureVector(:, end) = [];
dataset(:, end) = [];

relDeviation = zeros(length(dataset), 1);
for k = 1:length(dataset)
    relDeviation(k) = sqrt( sum( power( dataset(k, :) - queryImageFeatureVector, 2 ) ) ) ./ 1/2 * ( sqrt( sum( power( dataset(k, :), 2 ) ) ) + sqrt( sum( power( queryImageFeatureVector, 2 ) ) ) );
end

% add image fnames to euclidean
relDeviation = [relDeviation dataset_im_names];

% sort them according to smallest distance
[sortRelDist indxs] = sortrows(relDeviation);
sortedRelImgs = sortRelDist(:, 2);

% clear axes
arrayfun(@cla, findall(0, 'type', 'axes'));

% display query image
str_img_name = int2str(query_im_name);
query_im = imread( strcat('images\', str_img_name, '.jpg') );
subplot(3, 7, 1);
imshow(query_im, []);
title('Query Image', 'Color', [1 0 0]);

% dispaly images returned by query
for m = 1:numOfReturnedImages
    im_name = sortedRelImgs(m);
    im_name = int2str(im_name);
    str_im_name = strcat('images\', im_name, '.jpg');
    returned_im = imread(str_im_name);
    subplot(3, 7, m+1);
    imshow(returned_im, []);
end

end
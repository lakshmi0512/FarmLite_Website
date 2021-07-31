function waveletMoments = waveletTransform(image)
imgGray = double(rgb2gray(image))/255;
imgGray = imresize(imgGray, [256 256]);

coeff_1 = dwt2(imgGray', 'coif1');
coeff_2 = dwt2(coeff_1, 'coif1');
coeff_3 = dwt2(coeff_2, 'coif1');
coeff_4 = dwt2(coeff_3, 'coif1');

meanCoeff = mean(coeff_4);
stdCoeff = std(coeff_4);

waveletMoments = [meanCoeff stdCoeff];

end
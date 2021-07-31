function [Feature_Vector] = Extract_FeaturesofSoil(queryImage)

    queryImage = imresize(queryImage, [256 256]);
    hsvHist = hsvHistogram(queryImage);
    autoCorrelogram = colorAutoCorrelogram(queryImage);
    color_moments = colorMoments(queryImage);
    img = double(rgb2gray(queryImage))/255;
    [meanAmplitude, msEnergy] = gaborWavelet(img, 4, 6); % 4 = number of scales, 6 = number of orientations
    wavelet_moments = waveletTransform(queryImage);
    Feature_Vector = [hsvHist autoCorrelogram color_moments meanAmplitude msEnergy wavelet_moments];
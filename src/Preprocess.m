

function [img] = Preprocess(img)
% DESCRIPTION: Preprocess given image.
% INPUT:       %img     Image to be preprocessed
% OUTPUT:      Preprocessed image.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;
    
    % Convert image to single precision
    img = im2single(img);

    % Standardize image resolution e.g. (128 128 3)
    img_res = size(img, 1) * size(img, 2);
    StandardResolution = Preprocess.Resolution(1) * Preprocess.Resolution(2);
    if img_res ~= StandardResolution
        img = imresize(img, Preprocess.Resolution);
    end

end


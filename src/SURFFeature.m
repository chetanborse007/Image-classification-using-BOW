

function [blobs, descriptors] = SURFFeature(img)
% DESCRIPTION: Generate SURF local features for a given image.
% INPUT:       %img             Image from which local features are to be
%                               extracted
% OUTPUT:      %blobs           Interesting Blob points
%              %descriptors     Extracted local features

    % Import project configuration i.e. 'Configuration.m'
    Configuration;
    
    % Transform RGB image into Gray image
    gray = rgb2gray(img);

    % Find interesting Blob points
    blobs = detectSURFFeatures(gray, ...
                               'MetricThreshold', SURF.MetricThreshold, ...
                               'NumOctaves', SURF.NumOctaves, ...
                               'NumScaleLevels', SURF.NumScaleLevels);

    % Generate SURF local features
    [descriptors, ~] = extractFeatures(gray, ...
                                       blobs', ...
                                       'Method', SURF.Method, ...
                                       'Upright', SURF.Upright, ...
                                       'SURFSize', SURF.SURFSize);

    descriptors = descriptors';

end


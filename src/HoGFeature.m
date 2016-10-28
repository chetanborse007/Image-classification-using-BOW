

function [descriptors] = HoGFeature(img, frames)
% DESCRIPTION: Generate HoG local features for a given image.
% INPUT:       %img             Image from which local features are to be
%                               extracted
%              %frames          Interest points
% OUTPUT:      %descriptors     Extracted local features.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;

    % Generate HoG local features
    [descriptors, ~] = extractHOGFeatures(img, ...
                                          frames', ...
                                          'CellSize', HoG.CellSize, ...
                                          'BlockSize', HoG.BlockSize, ...
                                          'BlockOverlap', HoG.BlockOverlap, ...
                                          'NumBins', HoG.NumBins, ...
                                          'UseSignedOrientation', HoG.UseSignedOrientation);

    descriptors = descriptors';

end


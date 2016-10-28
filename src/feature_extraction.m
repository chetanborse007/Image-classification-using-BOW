

function feat = feature_extraction(img)
% DESCRIPTION: Generate the one dimensional feature vector i.e. Histogram 
%              for the given image by concatenating histograms of different 
%              codebook types.
% INPUT:       %img             Image for which histogram is to be
%                               generated
% OUTPUT:      One dimensional feature vector i.e. Histogram for the given 
%              image.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;
    
    feat = [];
    
    % Multi-Scale Color Dense SIFT Histogram
    if any(strcmp(Model.FeatureType, 'SIFT'))
        SIFT = Histogram(img, 'SIFT');
        feat = [feat SIFT];
    end
    
    % HoG Histogram
    if any(strcmp(Model.FeatureType, 'HoG'))
        HoG = Histogram(img, 'HoG');
        feat = [feat HoG];
    end
    
    % SURF Histogram
    if any(strcmp(Model.FeatureType, 'SURF'))
        SURF = Histogram(img, 'SURF');
        feat = [feat SURF];
    end
    
end


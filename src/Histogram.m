

function [histogram] = Histogram(img, HistogramType)
% DESCRIPTION: Generate the one dimensional feature vector i.e. Histogram 
%              for the given image and for specified histogram type.
% INPUT:       %img             Image for which histogram is to be
%                               generated
%              %HistogramType   Histogram types
% OUTPUT:      One dimensional feature vector i.e. Histogram for the given 
%              image.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;

    % Load respective Codebook for generating Histogram
    % i.e. 'SIFT_CODEBOOK' for SIFT Histogram, 'HoG_CODEBOOK' for HoG 
    % Histogram.
	if strcmp(HistogramType, 'SIFT')
	    load('./BOW.mat', 'SIFT_CODEBOOK');
	elseif strcmp(HistogramType, 'HoG')
	    load('./BOW.mat', 'HoG_CODEBOOK');
	elseif strcmp(HistogramType, 'SURF')
	    load('./BOW.mat', 'SURF_CODEBOOK');
    end
    
    % Preprocess given image
    img = Preprocess(img);

    % Generate Local Features for a given image
    % e.g. Multi-Scale Color Dense SIFT, HoG, SURF, etc.
	if strcmp(HistogramType, 'SIFT') || strcmp(HistogramType, 'HoG')
	    [frames, descriptors] = PhowFeature(img);
		if strcmp(HistogramType, 'HoG')
		    descriptors = HoGFeature(img, frames(1:2,:));
		end
	elseif strcmp(HistogramType, 'SURF')
	    [~, descriptors] = SURFFeature(img);
    end

    % Assign every local feature to respective closest cluster (Visual Word)
	if strcmp(HistogramType, 'SIFT')
	    [~, indices] = min(vl_alldist(SIFT_CODEBOOK, im2double(descriptors)));
	elseif strcmp(HistogramType, 'HoG')
	    [~, indices] = min(vl_alldist(HoG_CODEBOOK, im2double(descriptors)));
	elseif strcmp(HistogramType, 'SURF')
	    [~, indices] = min(vl_alldist(SURF_CODEBOOK, im2double(descriptors)));
%         DistanceMatrix = pdist2(SURF_CODEBOOK', im2double(descriptors'), 'jaccard');
%         [~, indices]   = min(DistanceMatrix);
    end

    % Find visual word frequencies for a given image
	if strcmp(HistogramType, 'SIFT')
	    histogram = hist(indices, KMeans.SIFT.NUMCENTERS);
	elseif strcmp(HistogramType, 'HoG')
	    histogram = hist(indices, KMeans.HoG.NUMCENTERS);
	elseif strcmp(HistogramType, 'SURF')
	    histogram = hist(indices, KMeans.SURF.NUMCENTERS);
	end

end


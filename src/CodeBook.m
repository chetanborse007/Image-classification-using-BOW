

function [] = CodeBook(Path, Extension, CodebookType)
% DESCRIPTION: Generate the Codebook of visual words for the provided 
%              codebook types.
% INPUT:       %Path            Path of images for which codebook is to be
%                               generated
%              %Extension       Allowed image types (extensions)
%              %CodebookType    Codebook types e.g. SIFT, HoG, etc.
% OUTPUT:      Create and save 'BOW.mat' file with respective codebooks 
%              i.e. 'SIFT_CODEBOOK' for SIFT, 'HoG_CODEBOOK' for HoG.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;

    
    % Initialise MatLab Cell for local features
    if any(strcmp(CodebookType, 'SIFT'))
        SIFTLocalFeature = {};
    end
    if any(strcmp(CodebookType, 'HoG'))
        HoGLocalFeature = {};
    end
    if any(strcmp(CodebookType, 'SURF'))
        SURFLocalFeature = {};
    end

    count = 0;
    Categories = dir(Path);
    for i = 1:numel(Categories)
        % Skip hidden files and folders
        if Categories(i).name(1) == '.' || ~Categories(i).isdir
           continue;
        end

        % Fetch and create a list of images for every category
        images = [];
        for ext = 1:size(Extension, 2)
            images = [images; ...
                      dir(fullfile(Path, Categories(i).name, strcat('*.', Extension{ext})))];
        end
        
        for j = 1:numel(images)
%             disp([Path, Categories(i).name, images(j).name]);
            % Read image
            img = imread(fullfile(Path, Categories(i).name, images(j).name));
            
            % Preprocess given image
            img = Preprocess(img);

            % Generate Local Features e.g. Multi-Scale Color Dense SIFT, HoG, SURF, etc.
            if any(strcmp(CodebookType, 'SIFT')) || ...
               any(strcmp(CodebookType, 'HoG'))
                [frames, SIFTLocalFeature{count+j}] = PhowFeature(img);
                if any(strcmp(CodebookType, 'HoG'))
                    HoGLocalFeature{count+j} = HoGFeature(img, frames(1:2, :));
                end
            end
            
            if any(strcmp(CodebookType, 'SURF'))
                [~, SURFLocalFeature{count+j}] = SURFFeature(img);
            end
        end

        count = count + numel(images);
    end

    if any(strcmp(CodebookType, 'SIFT'))
        SIFTLocalFeature = cat(2, SIFTLocalFeature{:});
    end
    if any(strcmp(CodebookType, 'HoG'))
        HoGLocalFeature = cat(2, HoGLocalFeature{:});
    end
    if any(strcmp(CodebookType, 'SURF'))
        SURFLocalFeature = cat(2, SURFLocalFeature{:});
    end


    %pool = parpool;
    
    % Quantize extracted Dense SIFT local features (descriptors) using 
    % K-Means algorithm 
    if any(strcmp(CodebookType, 'SIFT'))
        [SIFT_CODEBOOK, ~] = vl_kmeans(im2double(SIFTLocalFeature), ...
                                       KMeans.SIFT.NUMCENTERS, ...
                                       KMeans.Verbose, ...
                                       'Distance', KMeans.Distance, ...
                                       'Initialization', KMeans.Initialization, ...
                                       'Algorithm', KMeans.Algorithm, ...
                                       'NumRepetitions', KMeans.NumRepetitions, ...
                                       'MaxNumIterations', KMeans.MaxNumIterations);
                                       %'NumTrees', KMeans.NumTrees, ...
                                       %'MaxNumComparisons', KMeans.MaxNumComparisons, ...

        save('./BOW.mat', 'SIFT_CODEBOOK', '-append');
    end
    
    % Quantize extracted HoG local features (descriptors) using 
    % K-Means algorithm 
    if any(strcmp(CodebookType, 'HoG'))
        [HoG_CODEBOOK, ~] = vl_kmeans(im2double(HoGLocalFeature), ...
                                      KMeans.HoG.NUMCENTERS, ...
                                      KMeans.Verbose, ...
                                      'Distance', KMeans.Distance, ...
                                      'Initialization', KMeans.Initialization, ...
                                      'Algorithm', KMeans.Algorithm, ...
                                      'NumRepetitions', KMeans.NumRepetitions, ...
                                      'MaxNumIterations', KMeans.MaxNumIterations);

        save('./BOW.mat', 'HoG_CODEBOOK', '-append');
    end
    
    % Quantize extracted SURF local features (descriptors) using 
    % K-Means algorithm 
    if any(strcmp(CodebookType, 'SURF'))
% %         pool = parpool;
%         [~, SURF_CODEBOOK] = kmeans(im2double(SURFLocalFeature'), ...
%                                     KMeans.SURF.NUMCENTERS, ...
%                                     'Display', KMeans.Display, ...
%                                     'Distance', KMeans.Distance, ...
%                                     'EmptyAction', KMeans.EmptyAction, ...
%                                     'MaxIter', KMeans.MaxIter, ...
%                                     'OnlinePhase', KMeans.OnlinePhase, ...
%                                     'Options', KMeans.Options, ...
%                                     'Replicates', KMeans.Replicates, ...
%                                     'Start', KMeans.Start);
%         SURF_CODEBOOK = SURF_CODEBOOK';
% %         delete(gcp('nocreate'));

        [SURF_CODEBOOK, ~] = vl_kmeans(im2double(SURFLocalFeature), ...
                                       KMeans.SURF.NUMCENTERS, ...
                                       KMeans.Verbose, ...
                                       'Distance', KMeans.Distance, ...
                                       'Initialization', KMeans.Initialization, ...
                                       'Algorithm', KMeans.Algorithm, ...
                                       'NumRepetitions', KMeans.NumRepetitions, ...
                                       'MaxNumIterations', KMeans.MaxNumIterations);

        save('./BOW.mat', 'SURF_CODEBOOK', '-append');
    end

    %delete(gcp('nocreate'));

end


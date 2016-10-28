

function [] = train(TrainPath, TrainCount, Extension)
% DESCRIPTION: Train Bag of Words model.
% INPUT:       %TrainPath       Path for training images
%              %TrainCount      Total training images
%              %Extension       Allowed image types (extensions)
% OUTPUT:      Create and save 'BOW.mat' file with variables 'HISTOGRAM', 
%              'LABEL' and 'TFIDF'.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;
    
    
    % Create a Codebook of visual words
    disp('Generating Codebook');
    CodeBook(TrainPath, Extension, Model.FeatureType);
    
    
    % Initialise HISTOGRAM matrix with dimension (Total Train Images, 
    % Histogram Bin Size) e.g. (1800, 400).
    % This matrix holds one dimensional feature vectors (visual word 
    % frequency vectors) for every train image.
    disp('Generating Train Histograms');
    HISTOGRAM = zeros(TrainCount, Model.HistogramBinSize);
    LABEL     = zeros(TrainCount, 1);
    
    count = 0;
    Categories = dir(TrainPath);
    for i = 1:numel(Categories)
        % Skip hidden files and folders
        if Categories(i).name(1) == '.' || ~Categories(i).isdir
           continue;
        end

        % Fetch and create a list of images for every category
        images = [];
        for ext = 1:size(Extension, 2)
            images = [images; ...
                      dir(fullfile(TrainPath, Categories(i).name, strcat('*.', Extension{ext})))];
        end
        
        for j = 1:numel(images)
%             disp([TrainPath, Categories(i).name, images(j).name]);
            % Read image
            img = imread(fullfile(TrainPath, Categories(i).name, images(j).name));
            
            % Generate one dimensional feature vector i.e. Histogram for
            % the given image
            HISTOGRAM(count+j, :) = feature_extraction(img);
            
            % Mark and store its label
            LABEL(count+j, :) = i;%disp(i);
        end

        count = count + numel(images);
    end
    
    % Save 'HISTOGRAM' and 'LABEL' into 'BOW.mat' file
    save('./BOW.mat', 'HISTOGRAM', 'LABEL', '-append');

    
    % Transform visual word frequencies into TF-IDF scores
    disp('Generating TF-IDF Scores');
    TFIDFWeight();
    
end


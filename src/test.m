

function [] = test(TestPath, TestCount, Extension)
% DESCRIPTION: Test Bag of Words model.
% INPUT:       %TestPath        Path for testing images
%              %TestCount       Total testing images
%              %Extension       Allowed image types (extensions)
% OUTPUT:      Generates one dimensional vector of predicted labels and 
%              compute accuracy of model.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;
    
    
    % Initialise TestHistogram matrix with dimension (Total Test Images, 
    % Histogram Bin Size) e.g. (600, 400).
    % This matrix holds one dimensional feature vectors (visual word 
    % frequency vectors) for every train image.
    disp('Generating Test Histograms');
    TestHistogram = zeros(TestCount, Model.HistogramBinSize);
    TestLabel     = zeros(TestCount, 1);
    
    count = 0;
    Categories = dir(TestPath);
    for i = 1:numel(Categories)
        % Skip hidden files and folders
        if Categories(i).name(1) == '.' || ~Categories(i).isdir
           continue;
        end

        % Fetch and create a list of images for every category
        images = [];
        for ext = 1:size(Extension, 2)
            images = [images; ...
                      dir(fullfile(TestPath, Categories(i).name, strcat('*.', Extension{ext})))];
        end
        
        for j = 1:numel(images)
%             disp([TestPath, Categories(i).name, images(j).name]);
            % Read image
            img = imread(fullfile(TestPath, Categories(i).name, images(j).name));

            % Generate one dimensional feature vector i.e. Histogram for
            % the given image
            TestHistogram(count+j, :) = feature_extraction(img);
            
            % Mark and store its known label
            TestLabel(count+j, :) = i;
        end

        count = count + numel(images);
    end
    
    
    % Predict labels for the Test Histograms based on K nearest neighbours
%     save('TestHistogram.mat', 'TestHistogram', 'TestLabel');
    disp('Applying K Nearest Neighbours');
    PredictedLabel = your_kNN(TestHistogram);
    
    
    % Compute accuracy of model
    accuracy = sum(PredictedLabel==TestLabel) ./ TestCount;
    display('Accuracy: ');
    display(accuracy);

end


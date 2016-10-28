

function [PredictedLabel] = KNN(TestHistogram)
% DESCRIPTION: Predict labels for the Test Histograms based on K nearest 
%              neighbours.
%              This algorithm uses TF-IDF scores and query search technique
%              for similarity measurement and then retrieve top K
%              neighbours for voting. The label for test image will be
%              determined simply based on majority of votes.
% INPUT:       %TestHistogram       Test histograms for which labels are to
%                                   be predicted
% OUTPUT:      One dimensional vector of predicted labels.

    % Import project configuration i.e. 'Configuration.m'
    Configuration;

    % Load 'TFIDF' and 'LABEL' variables from 'BOW.mat'
    load('./BOW.mat', 'TFIDF', 'LABEL');
    
    % Compute similarity scores of test histogram with every trained
    % histogram
    TestScores = TFIDF * TestHistogram';

    % Sort similarity scores in descending order
    [~, LabelIndex] = sort(TestScores, 'descend');

    % Consider K closest neighbours based on highest similarity scores
    Neighbours = LabelIndex(1:KNN.K, :);

    % Get the vote of everyone from top K neighbours
    Votes = zeros(size(Neighbours));
    for j = 1:size(Neighbours, 2)
        Votes(:, j) = LABEL(Neighbours(:, j));
    end
    
    % Find the majority of votes and assign respective label to test image
    PredictedLabel = mode(Votes);
    
    PredictedLabel = PredictedLabel';

end


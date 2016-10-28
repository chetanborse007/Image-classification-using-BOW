

function [] = TFIDFWeight()
% DESCRIPTION: Transform visual word frequencies into TF-IDF scores.
% INPUT:       Load 'HISTOGRAM' variable from 'BOW.mat' file.
% OUTPUT:      Create and save 'BOW.mat' file with the variable 'TFIDF'.

    % Load 'HISTOGRAM' variable from 'BOW.mat' file
    load('./BOW.mat', 'HISTOGRAM');
    
    % Find the total images in 'HISTOGRAM' matrix
    ImageCount = size(HISTOGRAM, 1);
    
    % Find the Logarithmic Term Frequencies for visual words
    TF = 1 + log(HISTOGRAM);
    TF(TF < 0) = 0;

    % Find the Document Frequencies for visual words
    % i.e. total number of images in which visual word incurs.
    DF = sum(HISTOGRAM~=0, 1);

    % Find Inverse Document Frequencies for visual words
    IDF = log(1 + (ImageCount * bsxfun(@power, DF+1, -1)));
    
    % Finally, compute TF-IDF Scores for visual words
    TFIDF = bsxfun(@times, TF, IDF);

    % Save 'TFIDF' into 'BOW.mat' file
    save('./BOW.mat', 'TFIDF', '-append');

end


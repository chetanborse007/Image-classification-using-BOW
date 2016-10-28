

function predict_label = your_kNN(feat)
% DESCRIPTION: Predict labels for the Test Histograms based on K nearest 
%              neighbours.
% INPUT:       %feat        Test histograms for which labels are to
%                           be predicted
% OUTPUT:      One dimensional vector of predicted labels.

    predict_label = KNN(feat);

end




% DESCRIPTION: This is a configuration file for Bag of Words model.
%              You can change any parameter in this configuration file.


% Configuration for image dataset.
% > Path for training, validation and testing images
% > Image extensions
Config.TrainPath = './train3/';
Config.ValidationPath = './test3/';
Config.TestPath = './test3/';
Config.Extension = 'JPG BMP';
Config.Extension = regexp(Config.Extension, ' +', 'split');
Config.TrainCount = Lookup(Config.TrainPath, Config.Extension);
Config.ValidationCount = Lookup(Config.ValidationPath, Config.Extension);
Config.TestCount = Lookup(Config.TestPath, Config.Extension);

% Standard resolution for preprocessed images
Preprocess.Resolution = [128 128];

% Configuration for Multi-Scale Color Dense SIFT features
Phow.Verbose = false;
Phow.Sizes = [3 5 7];
Phow.Fast = false;
Phow.Step = 4;
Phow.Color = 'RGB';
Phow.ContrastThreshold = 0.005;
Phow.WindowSize = 1.5;
Phow.Magnif = 6;
Phow.FloatDescriptors = false;

% Configuration for HoG features
HoG.CellSize = [8 8];
HoG.BlockSize = [2 2];
HoG.BlockOverlap = [1 1];
HoG.NumBins = 9;
HoG.UseSignedOrientation = true;

% Configuration for SURF features
SURF.MetricThreshold = 200;
SURF.NumOctaves = 2;
SURF.NumScaleLevels = 5;
SURF.Method = 'SURF';
SURF.Upright = false;
SURF.SURFSize = 128;

% Configuration for K-Means quantisation
KMeans.Verbose = 'Verbose';
KMeans.SIFT.NUMCENTERS = 150;
KMeans.HoG.NUMCENTERS = 100;
KMeans.SURF.NUMCENTERS = 250;
KMeans.Distance = 'L2';
KMeans.Initialization = 'PLUSPLUS';
KMeans.Algorithm = 'ELKAN';
KMeans.NumRepetitions = 1;
if strcmp(KMeans.Algorithm, 'ANN')
    KMeans.NumTrees = 3;
    KMeans.MaxNumComparisons = 50;
end
KMeans.MaxNumIterations = 2500;

% KMeans.SIFT.NUMCENTERS = 150;
% KMeans.HoG.NUMCENTERS = 100;
% KMeans.SURF.NUMCENTERS = 250;
% KMeans.Display = 'iter';
% KMeans.Distance = 'cityblock';
% KMeans.EmptyAction = 'singleton';
% KMeans.MaxIter = 1400;
% KMeans.OnlinePhase = 'on';
% KMeans.Options = statset('UseParallel', 1, ...
%                          'UseSubstreams', 1, ...
%                          'Streams', RandStream('mlfg6331_64'));
% KMeans.Replicates = 1;
% KMeans.Start = 'plus';

% Configuration for BOG model
Model.FeatureType = {'SIFT', 'HoG'};
Model.HistogramBinSize = KMeans.SIFT.NUMCENTERS + ...
                         KMeans.HoG.NUMCENTERS;

% Model.FeatureType = {'SURF'};
% Model.HistogramBinSize = KMeans.SURF.NUMCENTERS;

% Configuration for K Nearest Neighbours
KNN.K = 11;


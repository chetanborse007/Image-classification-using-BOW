

function [count] = Lookup(path, ext)
% DESCRIPTION: Lookup folder and return total number of files (for 
%              specified extensions) residing in a folder.
% INPUT:       %Path            Path of images for which lookup is to be
%                               performed
%              %Extension       Allowed image types (extensions)
% OUTPUT:      Returns total number of files residing in a specified folder.

    count = 0;
    folder = dir(path);
    for i = 1:numel(folder)
        if folder(i).name(1) == '.' || ~folder(i).isdir
           continue;
        end

        files = [];
        for j = 1:size(ext, 2)
            files = [files; ...
                     dir(fullfile(path, folder(i).name, strcat('*.', ext{j})))];
        end

        count = count + numel(files);
    end

end


% ImageCrop: for cropping images in certain folders
% author: Eswai
% github: github.com/loper-eswai

function ImageCrop(src_dir,dst_dir,format,spacing)
% spacing: spacing of cropping
% src_dir: source directory
% dst_dir: destination directory
% format: file format of images in source directory

subfolders=dir(src_dir);
for ii=1:length(subfolders)
    subname=subfolders(ii).name;
    % ignore current dir and father dir
    if ~strcmp(subname,'.')&&~strcmp(subname,'..')
        frames=dir(fullfile(src_dir,subname,['*.',format]));
        imgnum=length(frames);
        dstpath=fullfile(dst_dir,subname);
        if ~isdir(dstpath)
            mkdir(dstpath);
        end
        for jj=1:imgnum
            imgpath=fullfile(src_dir,subname,frames(jj).name);
            I=imread(imgpath);
            row=floor(size(I,1)/spacing);
            col=floor(size(I,2)/spacing);
            % Start Croping
            for rr=1:row
                for cc=1:col
                    rect=[(cc-1)*spacing+1,(rr-1)*spacing+1,spacing-1,spacing-1];
                    newI=imcrop(I,rect);
                    newname=[frames(jj).name,'_',num2str((rr-1)*col+cc),['.',format]];
                    newpath=fullfile(dstpath,newname);
                    imwrite(newI,newpath);
                end
            end
        end
    end % end of if
end
end




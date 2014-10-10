function [ output ] = cropImage( img )
columns = size(img,2);
rows = size(img,1);

output = img(10:rows-10,10:columns-10);
end


for fid = 1:6  % running a loop for 6 files in the folder

%% preprocessing for setting file names to be used in input and output    
fids = int2str(fid);
TxtfileName = strcat('ResultOf',fids,'.txt');
JpgfileName = strcat('ResultOf',fids,'.jpg');
inptfileName = strcat('part1_',fids,'.jpg');

%% reading the input image
fullim = imread(inptfileName);
fullim = im2double(fullim);

%% generating 3 color channel images
height = floor(size(fullim,1)/3);

B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

%% cropping the border pixels
B = cropImage(B);
G = cropImage(G);
R = cropImage(R);

%% evaluating edge response
edgeofB = edge(B,'prewitt');
edgeofG = edge(G,'prewitt');
edgeofR = edge(R,'prewitt');

%% fiinding displacement of color channels
dispOfG = displacement(edgeofG,edgeofB);
fileID = fopen(TxtfileName,'w');
fprintf(fileID,'Displacement vector of Green plate: %d %d',dispOfG);

dispOfR = displacement(edgeofR,edgeofB);
fprintf(fileID,'\r\nDisplacement vector of Red plate: %d %d',dispOfR);
fclose(fileID);

%% setting the new shifted color channel images
newG = circshift(G, dispOfG);
newR = circshift(R, dispOfR);

%% final output
colorim = cat(3, newR, newG, B);
imwrite(colorim,JpgfileName);

end
%STARTER CODE FOR PART A
file_name1 = 'go1.jpg';
file_name2 = 'black_chip.jpg';
file_name3 = 'white_chip2_smaller.jpg';
 
im_to_search = imread(file_name1);
im_temp_bl = imread(file_name2);
im_temp_wh = imread(file_name3);
 
gray_search = rgb2gray(im_to_search);
gray_temp_bl = rgb2gray(im_temp_bl);
gray_temp_wh = rgb2gray(im_temp_wh);
 
correlation_map_bl = normxcorr2(gray_temp_bl, gray_search);
correlation_map_wh = normxcorr2(gray_temp_wh, gray_search);
 
figure
subplot(221), imshow(im_to_search)
subplot(222), imshow(gray_search)
subplot(223), imshow(gray_temp_bl)
subplot(224), imshow(gray_temp_wh)
 
figure
subplot(221), imshow(im_to_search)
subplot(222), imshow(correlation_map_bl)
%top row is black chips
subplot(223), imshow(im_to_search)
subplot(224), imshow(correlation_map_wh)
%bot row is black chips


TF = (correlation_map_wh == (imdilate(correlation_map_wh, strel('disk',13))) & correlation_map_wh > 0.535);
%TF = islocalmax(mask);
figure, imshow(TF);

[row,col] = find(TF);



chip_disp_width = 40;
chip_disp_height = 40;
figure, imshow(file_name1 )
hold on
rows = size(row);


for i = 1 : rows
    rectangle('Position',[ col(i) - chip_disp_width, row(i) - chip_disp_height, chip_disp_width, chip_disp_height],'EdgeColor','r')

end

TF = (correlation_map_bl == (imdilate(correlation_map_bl, strel('disk',13))) & correlation_map_bl > 0.535);
%TF = islocalmax(mask);
figure, imshow(TF);

[row,col] = find(TF);

figure, imshow(file_name1 )
hold on
rows = size(row);

for i = 1 : rows
    rectangle('Position',[ col(i) - chip_disp_width, row(i) - chip_disp_height, chip_disp_width, chip_disp_height],'EdgeColor','r')

end

%STARTER CODE FOR PART B

RPS = imread('RPS.PNG');
Rock = imread('Rock.PNG');
Papper = imread('Paper.PNG');
Scissors = imread('Scissors.PNG');

figure;

subplot(221), imshow(RPS)
subplot(222), imshow(Rock)
subplot(223), imshow(Papper)
subplot(224), imshow(Scissors)


gray_RPS = rgb2gray(RPS);
gray_Rock = rgb2gray(Rock);
gray_Paper= rgb2gray(Papper);
gray_Scissors = rgb2gray(Scissors);



mask = fspecial('gaussian',7, 1.5);

imfilter(gray_Rock, mask);
gray_Rock = gray_Rock(1:4:end,1:4:end);


%gray_Rock = fliplr(gray_Rock);


figure, imshow(gray_Rock);

correlation_Rock = normxcorr2(gray_Rock, gray_RPS);
TF = (correlation_Rock == (imdilate(correlation_Rock, strel('disk',13))) & correlation_Rock > 0.422);

figure, imshow(correlation_Rock);
[row,col] = find(TF);



HandH = 150;
HandW = 200;

figure, imshow(RPS )
hold on

rows = size(row);
for i = 1 : rows
    rectangle('Position',[ col(i) -  HandW/2, row(i) - HandH/2,  HandH, HandW],'EdgeColor','r')

end



imfilter(gray_Scissors, mask);
gray_Scissors = gray_Scissors(1:2:end,1:2:end);



figure, imshow(gray_Scissors);

correlation_Scissors = normxcorr2(gray_Scissors, gray_RPS);
TF = (correlation_Scissors == (imdilate(correlation_Scissors, strel('disk',17))) & correlation_Scissors > 0.558);

figure, imshow(correlation_Scissors);
[row,col] = find(TF);



HandH = 250;
HandW = 200;

figure, imshow(RPS )
hold on

rows = size(row);
for i = 1 : rows
    rectangle('Position',[ col(i) -  HandW, row(i) - HandH,  HandH, HandW],'EdgeColor','r')

end



imfilter(gray_Paper, mask);
gray_Paper= gray_Paper(1:3:end,1:3:end);



figure, imshow(gray_Paper);

correlation_Paper = normxcorr2(gray_Paper, gray_RPS);
TF = (correlation_Paper == (imdilate(correlation_Paper, strel('disk',13))) & correlation_Paper> 0.5);

figure, imshow(correlation_Paper);
[row,col] = find(TF);



HandH = 250;
HandW = 200;

figure, imshow(RPS)
hold on

rows = size(row);
for i = 1 : rows
    rectangle('Position',[ col(i) -  HandW, row(i) - HandH/2,  HandH, HandW],'EdgeColor','r')

end
 
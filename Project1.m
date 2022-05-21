
%group image prosses
im1 = imread('Project1 picture.png');
im2 = rgb2gray(im1);
subplot(3,5,1), imshow(im1);
%find min and max values of image
ansmax = max(im2(:))
ansmin = min(im2(:))
[x_max, y_max, valmax] = find(im2 == ansmax)
[x_min, y_min, valmin] = find(im2 == ansmin)

%reduce resalution of image 
subplot(3,5,2), imshow(im2);
IMr1 = reduceResalution(im2)
subplot(3,5,3), imshow(IMr1);
IMr2 = reduceResalution(IMr1)
subplot(3,5,4), imshow(IMr2);
IMr3 = reduceResalution(IMr2)
subplot(3,5,5), imshow(IMr3);


%landscape  image prosses
im3 = imread('Project1LS.png');
im4 = rgb2gray(im3);
subplot(3,5,6), imshow(im3);
%find min and max values of image
ansmax1 = max(im4(:))
ansmin1 = min(im4(:))
[x_max1, y_max1, valmax1] = find(im4 == ansmax1)
[x_min1, y_min1, valmin1] = find(im4== ansmin1)


%reduce resalution of image 
subplot(3,5,7), imshow(im4);
IMrl1 = reduceResalution(im4)
subplot(3,5,8), imshow(IMrl1);
IMrl2 = reduceResalution(IMrl1)
subplot(3,5,9), imshow(IMrl2);
IMrl3 = reduceResalution(IMrl2)
subplot(3,5,10), imshow(IMrl3);


%part b

im5 = imread('bacteria.bmp');
subplot(3,5,11), imshow(im5)
subplot(3,5,12), imhist(im5)
mask =  (im5 < 100);
subplot(3,5,13), imshow(mask)

output = im5.*uint8(mask);
subplot(3,5,14), imshow(output)

imL = bwlabel(output,8)
RGB =  label2rgb (imL, 'hsv', 'k', 'shuffle');
subplot(3,5,15), imshow(RGB)

areaAll = sum(mask(:) == 1);
uni = unique(imL);

counts = histc(imL(:), uni)

function y = reduceResalution(Data)
    y = Data(1:2:end,1:2:end)
end



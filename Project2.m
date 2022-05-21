%imput imagis

boat = imread("Boat2.tif");
building = imread("building.gif");
NYC = imread("New York City.jpg");
bikeLane = imread("bike-lane.jpg");
cornerWindow = imread("corner_window.jpg");
corridor = imread("corridor.jpg");

figure(1)
subplot(2,3,1),imshow(building), title("original image")
subplot(2, 3, 2), imhist(building), title("histagram")
AvgBuilding = filter(building, 'Avg', 3);
subplot(2,3,3),imshow(AvgBuilding), title("Avraged filter size 3")
AvgBuilding5 = filter(building, 'Avg', 5);

subplot(2,3,4),imshow(AvgBuilding5), title("Avraged filter size 5")
AvgBuilding7 = filter(building, 'Avg', 7);
subplot(2,3,5),imshow(AvgBuilding7), title("Avraged filter size 7")

figure(2)
subplot(2,3,1),imshow(boat), title("original image")
subplot(2, 3, 2), imhist(boat), title("histagram")
GauBoat3 = filter(boat, 'Gau', 3);
subplot(2,3,3),imshow(GauBoat3), title("gaussian filter size 3")

GauBoat5 = filter(boat, 'Gau', 5);
subplot(2,3,4),imshow(GauBoat5), title("gaussian filter size 5")

GauBoat7 = filter(boat, 'Gau', 7);
subplot(2,3,5),imshow(GauBoat7), title("gaussian filter size 7")

midboat = filter(boat, 'Mid', 3);
subplot(2,3,6),imshow(midboat), title("Middian filter size 3")


figure(3)

[soboBike, soboFx, soboFy] = edgeDetector(bikeLane,'Sobo');
subplot(2, 2, 1), imshow(bikeLane),title("original image")
subplot(2, 2, 2), imshow(soboBike), title("edges found using sobo filter");
subplot(2, 2, 3), imshow(soboFx, []), title("Sx");
subplot(2, 2, 4), imshow(soboFy, []), title("Sy");

prewBike = edgeDetector(bikeLane,'Prew');

figure(4)

[prewBike, prewFx, prewFy] = edgeDetector(bikeLane,'Prew');
subplot(2, 2, 1), imshow(bikeLane),title("original image")
subplot(2, 2, 2), imshow(prewBike), title("edges found using prew filter");
subplot(2, 2, 3), imshow(prewFx, []), title("Px");
subplot(2, 2, 4), imshow(prewFy, []), title("Py");

figure(5)
subplot(2, 2, 1), imshow(NYC),title("original image")
LoG1 = LoG(NYC,3,1);
subplot(2, 2, 2), imshow(LoG1),title("edges found using LoG with sigma 1 and filter size 3");
LoG2 = LoG(NYC,3,2);
subplot(2, 2, 3), imshow(LoG3),title("edges found using LoG with sigma 2 and filter size 3");
LoG3 = LoG(NYC,3,2);
subplot(2, 2, 4), imshow(LoG3),title("edges found using LoG with sigma 3 and filter size 3");

figure(6)
subplot(2, 2, 1), imshow(cornerWindow),title("original image")
Canny0_5 = Canny(cornerWindow,0.5,0.5);
subplot(2, 2, 2), imshow(Canny0_5),title("Canny with sigma 0.5 and thresh 0.5");
Canny0_1 = Canny(cornerWindow,0.1,0.5);
subplot(2, 2, 3),  imshow(Canny0_1),title("Canny with sigma 0.5 and thresh 0.1");
Canny0_7 = Canny(cornerWindow,0.7,0.5);
subplot(2, 2, 4),  imshow(Canny0_7),title("Canny with sigma 0.5 and thresh 0.7");

function  im = filter(image, type, sizeOfFilter)

    flag = 0;
    padding = idivide(int32(sizeOfFilter), int32(2), 'floor');
    imPadded =  padarray(image, [double(padding) double(padding)],0,'both');
    [rows, cols] = size(image);
    im = uint8(zeros(rows,cols));

        switch type
            case 'Avg'
               mask = ones(sizeOfFilter,sizeOfFilter,'double');
               mask = mask/(sizeOfFilter*sizeOfFilter);
            case 'Gau'
                sigma = (sizeOfFilter - 1)/4;
                mask = fspecial('gaussian',sizeOfFilter, sigma);
            case 'Mid'
                flag = 1;      
        end
  
   for row = padding+1:rows+padding   
       for col = padding+1:cols+padding
                       
            section = uint8(imPadded(row-padding:row+padding, col-padding:col+padding));

            if(flag == 0)    
                newMatrix = mask.*double(section());
                im(row-padding, col-padding) = (sum(newMatrix(:)));
            else
                im(row-padding, col-padding) = median(section,"all");
            end   
       end
   end     
end

function  [G, Gx, Gy] = edgeDetector(image, filter)

    im = double(rgb2gray(image));

    switch (filter)
        case 'Sobo'
            Fx = [-1 -2 -1; 0 0 0; 1 2 1];
            Fy = Fx';
        case 'Prew'
            Fx = [-1 -1 -1; 0 0 0; 1 1 1];
            Fy = Fx';
    end

    Gx = imfilter(im, Fx);
    Gy = imfilter(im, Fy);    

    Gtemp = (Gx.^2+Gy.^2).^0.5;
    
    Gmax = max(Gtemp(:));
    G = (Gtemp > Gmax*.15);
    
end

function  im = LoG(image, sizeOfFilter,sigma)
    
    grayIm = double(rgb2gray(image));

    mask = fspecial('log', sizeOfFilter, sigma);

    im = imfilter(grayIm, mask);


end

function  im = Canny(image, thresh, sigma )

    grayIm = double(rgb2gray(image));

    im = edge(grayIm,'Canny', thresh, sigma);

end

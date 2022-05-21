s1 = imread("s1.JPG");
s2 = imread("s2.JPG");
s3 = imread("s3.JPG");
s4 = imread("s4.JPG");
s5 = imread("s5.JPG");
s6 = imread("s6.JPG");
s7 = imread("s7.JPG");
s8 = imread("s8.JPG");
s9 = imread("s9.JPG");
s10 = imread("s10.JPG");
s11 = imread("s11.JPG");
s12 = imread("s12.JPG");
s13 = imread("s13.JPG");
s14 = imread("s14.JPG");
s15 = imread("s15.JPG");
s16 = imread("s16.JPG");
s17 = imread("s17.JPG");
s18 = imread("s18.JPG");
s19 = imread("s19.JPG");
s20 = imread("s20.JPG");

numrows = height(s9);
numcols = width(s9);

s1 = imresize(s1,[numrows numcols]);
s2 = imresize(s2,[numrows numcols]);
s3 = imresize(s3,[numrows numcols]);
s4 = imresize(s4,[numrows numcols]);
s5 = imresize(s5,[numrows numcols]);
s6 = imresize(s6,[numrows numcols]);
s7 = imresize(s7,[numrows numcols]);
s8 = imresize(s8,[numrows numcols]);
s10 = imresize(s10,[numrows numcols]);
s11 = imresize(s11,[numrows numcols]);
s12 = imresize(s12,[numrows numcols]);
s13 = imresize(s13,[numrows numcols]);
s14 = imresize(s14,[numrows numcols]);
s15 = imresize(s15,[numrows numcols]);
s16 = imresize(s16,[numrows numcols]);
s17 = imresize(s17,[numrows numcols]);
s18 = imresize(s18,[numrows numcols]);
s19 = imresize(s19,[numrows numcols]);
s20 = imresize(s20,[numrows numcols]);

files = dir('*.mat');


for i = 1:20
    load(files(i).name);
 
end

%load('ms20.mat')


Ms = cell(1,20);
BMs = cell(1,20);
Rs = cell(1,20);
Gs = cell(1,20);
Bs = cell(1,20);
BRs = cell(1,20);
BGs = cell(1,20);
BBs = cell(1,20);

sSat = cell(1,20);
sVal = cell(1,20);
sHSV = cell(1,20);
bSat = cell(1,20);
bVal = cell(1,20);
bHSV = cell(1,20);



simg = {s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20};
matfile = {ms1, ms2, ms3, ms4, ms5, ms6, ms7, ms8, ms9, ms10, ms11, ms12, ms13, ms14, ms15, ms16, ms17, ms18, ms19};
%matfiles = dir('*.mat');



for i = 1:19
    [R,G,B] = imsplit(simg{i});
    Rs{i} = R(matfile{i} == 1);
    Gs{i} = G(matfile{i} == 1);
    Bs{i} = B(matfile{i} == 1);

    BRs{i} = R(matfile{i} == 0);
    BGs{i} = G(matfile{i} == 0);
    BBs{i} = B(matfile{i} == 0);

end

RedS = vertcat(Rs{:});
GreenS = vertcat(Gs{:});
BlueS = vertcat(Bs{:});

BRedS = vertcat(BRs{:});
BGreenS = vertcat(BGs{:});
BBlueS = vertcat(BBs{:});


figure(1)
subplot(1,3,1),imhist(RedS), title("Strawberry Red Histagram")
subplot(1, 3, 2), imhist(GreenS ), title("Strawberry Green Histagram")
subplot(1,3,3),imhist(BlueS), title("Strawberry Blue histagram")

figure(2)
subplot(1,3,1),imhist(BRedS), title("Background  Red Histagram")
subplot(1, 3, 2), imhist(BGreenS ), title("Background  Green Histagram")
subplot(1,3,3),imhist(BBlueS), title("Background  Blue histagram")






for i = 1:19

    HSV{i} = rgb2hsv(simg{i});
    [Hue, Sat, Val] = imsplit(HSV{i});

    sHue{i} = Hue(matfile{i} == 1);
    sSat{i} = Sat(matfile{i} == 1);
    sVal{i} = Val(matfile{i} == 1);

    bHue{i} = Hue(matfile{i} == 0);
    bSat{i} = Sat(matfile{i} == 0);
    bVal{i} = Val(matfile{i} == 0);

end
 
sTHue = vertcat(sHue{:});
sTSat = vertcat(sSat{:});
sTVal = vertcat(sVal{:});

bTHue = vertcat(bHue{:});
bTSat = vertcat(bSat{:});
bTVal = vertcat(bVal{:});

figure(3)
subplot(1,3,1),imhist(sTHue), title("Strawberry Hue Histagram")
subplot(1, 3, 2), imhist(sTSat ), title("Strawberry Sat Histagram")
subplot(1,3,3),imhist(sTVal), title("Strawberry Val histagram")

figure(4)
subplot(1,3,1),imhist(bTHue), title("Background Hue Histagram")
subplot(1, 3, 2), imhist(bTSat ), title("Background Sat Histagram")
subplot(1,3,3),imhist(bTVal), title("Background Val histagram")


colorTotalS = double(RedS + GreenS + BlueS);

NormRedS = double(RedS)./colorTotalS;
NormGreenS = double(GreenS)./colorTotalS;
NormBlueS = double(BlueS)./colorTotalS;

figure(5)
subplot(1,3,1),imhist(NormRedS), title("Strawberry Norm Red Histagram")
subplot(1, 3, 2), imhist(NormGreenS), title("Strawberry Norm Green Histagram")
subplot(1,3,3),imhist(NormBlueS), title("Strawberry Norm Blue histagram")

colorTotalB = double(BRedS + BGreenS + BBlueS);

NormRedB = double(BRedS)./colorTotalB;
NormGreenB = double(BGreenS)./colorTotalB;
NormBlueB = double(BBlueS)./colorTotalB;

figure(6)
subplot(1,3,1),imhist(NormRedB), title("Background Norm Red Histagram")
subplot(1, 3, 2), imhist(NormGreenB), title("Background Norm Green Histagram")
subplot(1,3,3),imhist(NormBlueB), title("Background Norm Blue histagram")

%ms20 = roipoly(s20)

%save('ms20')
%roipoly
%poly2mask(xi,yi,m,n)

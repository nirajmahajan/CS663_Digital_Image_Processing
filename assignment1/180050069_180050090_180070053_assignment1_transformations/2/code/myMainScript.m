%% MyMainScript

tic;
%% code start
%% a part
myForegroundMask('../data/statue.png')

%% b part
myLinearContrastStretching('../data/barbara.png')
myLinearContrastStretching('../data/TEM.png')
myLinearContrastStretching('../data/canyon.png')
myLinearContrastStretching('../data/church.png')
myLinearContrastStretching('../data/chestXray.png')
myLinearContrastStretching('../data/masked_statue.png')

%% c part
myHE('../data/barbara.png')
myHE('../data/TEM.png')
myHE('../data/canyon.png')
myHE('../data/church.png')
myHE('../data/chestXray.png')
myHE('../data/masked_statue.png')

%% d part
myHM('../data/retina.png','../data/retinaMask.png','../data/retinaRef.png','../data/retinaRefMask.png')

%% e part
%% image(1)
myCLAHE('../data/barbara.png',50,0.1)
myCLAHE('../data/barbara.png',100,0.1)
myCLAHE('../data/barbara.png',8,0.1)
myCLAHE('../data/barbara.png',50,0.05)
%% image(2)
myCLAHE('../data/TEM.png',50,0.1)
myCLAHE('../data/TEM.png',100,0.1)
myCLAHE('../data/TEM.png',8,0.1)
myCLAHE('../data/TEM.png',50,0.05)
%% image(3)
myCLAHE('../data/canyon.png',50,0.1)
myCLAHE('../data/canyon.png',100,0.1)
myCLAHE('../data/canyon.png',8,0.1)
myCLAHE('../data/canyon.png',50,0.05)
%% image(6)
myCLAHE('../data/chestXray.png',50,0.1)
myCLAHE('../data/chestXray.png',100,0.1)
myCLAHE('../data/chestXray.png',8,0.1)
myCLAHE('../data/chestXray.png',50,0.1)

%% code end
toc;

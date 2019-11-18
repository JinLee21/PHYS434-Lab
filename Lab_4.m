clear;
clear clc;
% PHYS 434
% LAB 4
% Jin Kyoung Lee
%% Problem 1

h5disp("LAB/gammaray_lab4.h5")
gammarayData = h5read("LAB/gammaray_lab4.h5",'/data');
% gammaray_lab4.h5: reading of the number of particles detected every 100
% milliseconds (gamma-ray satellite has approx. 90 min. orbit)
% Columns:
% time(in gps seconds);
% solar phase(deg) showing the position of the sun relative to the orbit;
% Earth longitude(deg): giving the position of the spacecraft relative to
% the ground;
% particle counts
% Rows: # of samples
gammarayData(1,:)
% Plot
phase = gammarayData(1:1500000,2);
plot(phase,"Red") % Solar phase plot
hold on
longitude = gammarayData(1:1500000,3);
plot(longitude,"Blue") % Earth longitude plot
ylim([0,450]);
legend('Solar Phase(deg)','Earth Longitude(deg)')
hold off
numOfParticle = gammarayData(1:1500000,4);
plot(numOfParticle) % Number of particle plot
% It is observed that when the solar phase and Earth longitude overlap, the
% particle counts are higher than usual. Therefore, to build a background
% pdf() for this data, we need to compare the background when the phase and
% longitude overlap and the background when they do not overlap.

% 90 min = 5400000 millisec, and the satellite takes reading every 100
% milliseconds, therefore, 54000 readings/orbit. Therefore, if we make
% histogram for the number of particles detected every 54000 readings, we
% will be able to see the distribution for the background.

numOfParticleHist = gammarayData(1:54000,4).';
%subplot(1,2,1);
histogram(numOfParticleHist,'DisplayStyle','Stairs','LineWidth',2)
hold on
numOfParticleHist1 = gammarayData(54001:108000,4).';
histogram(numOfParticleHist1,'DisplayStyle','Stairs','LineWidth',2)
numOfParticleHist2 = gammarayData(108001:162000,4).';
histogram(numOfParticleHist2,'DisplayStyle','Stairs','LineWidth',2)
xlabel('Number of Particles detected (for one orbit)')
ylabel('Measurement')
hold off
%subplot(1,2,2);
histogram(numOfParticleHist,'DisplayStyle','Stairs','LineWidth',2)
hold on
histogram(numOfParticleHist1,'DisplayStyle','Stairs','LineWidth',2)
histogram(numOfParticleHist2,'DisplayStyle','Stairs','LineWidth',2)
set(gca,'YScale','log')
xlabel('(Log scale)')
legend('1st orbit','2nd orbit','3rd orbit')
hold off
% By making histogram for number of particles detected for one orbit, it is
% observed that the background distribution follows Poisson distribution.
x1 = 0:25;
gammaRay = makedist("Poisson","lambda",6);
plot(x1,pdf(gammaRay,x1))
% We can set the maximum number of particles detected(threshold) = 25.
%% Problem 2

clear;
clear clc;
h5disp("LAB/images.h5")
image1 = h5read("Lab/images.h5",'/image1');
imagestack = h5read("LAB/images.h5",'/imagestack');
% Plotting image 1
figure
imagesc(image1)
% Getting values from 6 (the least bright) to 30 (the most bright), and we
% can get rid of the values that has negative or close to zero. The
% background is not time dependent. Therefore, to find sigmal for the faint
% stars, we should collect data that has value of greater than 6 and less
% than 30.
faintStar = image1(6<image1 & image1<30); % Extracting data 6<=value<=30

imagestack1 = imagestack(1,:,:);
image1mat = zeros(200:200);
for i = 1:200
    row = imagestack1(:,:,i);
    image1mat(i,:) = row;
end
figure
imagesc(image1mat)
faintStar1 = image1mat(6<image1mat & image1mat<30);

imagestack2 = imagestack(2,:,:);
image2mat = zeros(200:200);
for i = 1:200
    row = imagestack2(:,:,i);
    image2mat(i,:) = row;
end
figure
imagesc(image2mat)
faintStar2 = image2mat(6<image2mat & image2mat<30);

imagestack3 = imagestack(3,:,:);
image3mat = zeros(200:200);
for i = 1:200
    row = imagestack3(:,:,i);
    image3mat(i,:) = row;
end
figure
imagesc(image3mat)
faintStar3 = image3mat(6<image3mat & image3mat<30);

imagestack4 = imagestack(4,:,:);
image4mat = zeros(200:200);
for i = 1:200
    row = imagestack4(:,:,i);
    image4mat(i,:) = row;
end
figure
imagesc(image4mat)
faintStar4 = image4mat(6<image4mat & image4mat<30);

imagestack5 = imagestack(5,:,:);
image5mat = zeros(200:200);
for i = 1:200
    row = imagestack5(:,:,i);
    image5mat(i,:) = row;
end
figure
imagesc(image5mat)
faintStar5 = image5mat(6<image5mat & image5mat<30);

imagestack6 = imagestack(6,:,:);
image6mat = zeros(200:200);
for i = 1:200
    row = imagestack6(:,:,i);
    image6mat(i,:) = row;
end
figure
imagesc(image6mat)
faintStar6 = image6mat(6<image6mat & image6mat<30);

imagestack7 = imagestack(7,:,:);
image7mat = zeros(200:200);
for i = 1:200
    row = imagestack7(:,:,i);
    image7mat(i,:) = row;
end
figure
imagesc(image7mat)
faintStar7 = image7mat(6<image7mat & image7mat<30);

imagestack8 = imagestack(8,:,:);
image8mat = zeros(200:200);
for i = 1:200
    row = imagestack8(:,:,i);
    image8mat(i,:) = row;
end
figure
imagesc(image8mat)
faintStar8 = image8mat(6<image8mat & image8mat<30);

imagestack9 = imagestack(9,:,:);
image9mat = zeros(200:200);
for i = 1:200
    row = imagestack9(:,:,i);
    image9mat(i,:) = row;
end
figure
imagesc(image9mat)
faintStar9 = image9mat(6<image9mat & image9mat<30);

imagestack10 = imagestack(10,:,:);
image10mat = zeros(200:200);
for i = 1:200
    row = imagestack10(:,:,i);
    image10mat(i,:) = row;
end
figure
imagesc(image10mat)
faintStar10 = image10mat(6<image10mat & image10mat<30);

faintStarCombined = [faintStar1.', faintStar2.', faintStar3.', faintStar4.', faintStar5.', faintStar6.', faintStar7.', faintStar8.', faintStar9.', faintStar10.'];
histogram(faintStarCombined,"DisplayStyle","Stairs","LineWidth",2)
% From the histogram, it seems the background follows Poisson distribution,
% although it is hard to be sure by looking at the shape.
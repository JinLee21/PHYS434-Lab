% PHYS 434
% LAB 3
% Jin Kyoung Lee
%% Problem 1

% Temperature should be around 12 Kelvin: Mean = 12
% Most of data consistent with 12 K to within the 0.4 degree precision of
% the themometry and the thermal control system: Standard deviation = 0.4

% A)-1.
% Creating good 100k data points
goodDP = random('Normal',12,0.4,[1,100000]);
% Bad data points
badDP = [10. 10.3, 2.1, 0., 0., 15.6, 22.3, 12.7];
dataCombined = [goodDP,badDP]; % size: 100k+8 points
% Making plot
histogram(dataCombined,'DisplayStyle','stairs')
xlabel('Temperature (K)')
ylabel('Measurement')
% A)-2. Statistical question: Goal is to identify bad data and throw it out

%{
The background will be normal distribution with a mean of 12 and standard
deviation of 0.4

Q. What is the threshold for temperature measured from properly working
thermal control system?

Reasoning: Since given bad points are all outside of background
distribution, if we figure out the threshold (5 sigma) for temperature
measured from properly working thermal control system, we can find the
data points that are outside of the distribution, and we can assume those
data points are bad measurement and get rid of them.
%}

% A)-3. Restate (2) in math.
pdfGoodDP = makedist("Normal","mu",12,"sigma",0.4);
prob5sigma = [1/3.5e6, 1-1/3.5e6];
threshold = icdf(pdfGoodDP,prob5sigma)
%{
-> We found out that threshold (5 sigma) is 9.9997 and 14.0003.
Therefore, if the data points are outside of the range 9.9997<x<14.0003,
we can assume that those points are bad data points.
%}

% A)-4. Applying statistical test and construct a truth table
%{
True Pos = kept good data
True Neg = mistakes made (omission or commission)
False Pos = mistakes made (omission or commission)
False Neg = correctly discarded bad data
%}

minThreshold = threshold(1);
maxThreshold = threshold(2);
dataTest = zeros(100008,1);
for i = 1:100008
    dataTest(i) = dataCombined(i);
    if (dataTest(i)>=minThreshold) && (dataTest(i)<=maxThreshold)
        truePos = dataTest((dataTest>=minThreshold) & (dataTest<=maxThreshold));
        TP = length(truePos);
    else
        (dataTest(i)<minThreshold) || (dataTest(i)>maxThreshold)
        falseNeg = dataTest((dataTest<minThreshold) | (dataTest>maxThreshold));
        FN = length(falseNeg);
    end
end
numOfTruePos = TP
numOfFalseNeg = FN
% True Pos = 100k
% False Neg = 5
% True Neg & False Pos = 3

%{
B) How does the number of omissions, where you threw out good data depend
on the statistical threshold you chose and is it a predictable quantity?
-> There were no omissions.

C) Are there mistakes of commission (bad data getting in)? If yes, are
they avoidable and how do they depend on your statistical threshold?
-> Yes. For our given data points, there shoule be 100k True Pos results,
however, we got 100003, which means that there were 3 bad data points
gotten in: 10, 10.3, 12.7 (from our added bad data points.)
It is because they are within the statistical threshold: 9.9997<x<14.0003.
With this statistical threshold, it is not possible to avoid that these
points get in, therefore, statistical threashold should be set again
with different sigma value.
%}
%% Problem 2

% 2D Gaussian with 1 arcsecond RMS
% RMS (root mean square): standard deviation

% 1. Question in words:
% -> What is the distance in arcseconds that have a '5 sigma' detection?

% Creating normal distribution with mean of 0 and standard deviation of 1
x2 = linspace(-5,5,100000);
pdfAsteroids = makedist("Normal","mu",0,"sigma",1);
plot(x2,pdf(pdfAsteroids,x2))
prob5sigma2 = 1-1/3.5e6;
distance = icdf(pdfAsteroids,prob5sigma2)
%{
The distance that gives '5 sigma' detection of movement is 5.0006
arcseconds.
%}
%% Problem 3

%{
Cosmic ray rate of 1 cosmic ray/min
If we can observe where the moon is for 8 hours/night and we observe for
15 days and see 6800 cosmic rays, what is the significance of our moon
shadow detection?
%}

% 8 hours = 480 min
% 1 cosmic ray/min, therefore, 480 cosmic ray/night

% 1) What is pdf for 1 day?
avgBG = 480;
pdf1day = makedist("Poisson","lambda",avgBG);
x3 = 350:600;
stairs(x3,pdf(pdf1day,x3))
% 2) What is expected probability distribution for 15 days?
numDays = 15;
avgBG15days = avgBG * numDays;
pdf15days = makedist("Poisson","lambda",avgBG15days);
x4 = 6500:8000;
stairs(x4,pdf(pdf15days,x4))
% 3) What is the probability of getting 6800 cosmic rays?
prob6800 = 1 - cdf(pdf15days, 6800)
% 4) What is sigma value?
sigma = icdf("Normal",prob6800,0,1)
% Therefore, the significance of the moon shadow detection is 4 sigma.
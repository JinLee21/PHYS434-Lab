% PHYS 434
% LAB 1
% Jin Kyoung Lee


% A little statistics

% # 1: Converting a probability into a 'sigma'.
% creating random distribution
d = random('Normal', 0, 0.01, [1,100000]);
histogram(d,50,'DisplayStyle','stairs','LineWidth',4) % creating histogram of distribution
xlim([-0.05,0.05]) % limiting the range of x showing on the graph
histogram(d,50,'DisplayStyle','stairs', 'LineWidth',3,'Normalization','pdf')
hold on

x1 = linspace(-0.05,0.05,1000) % generating vector x of 1000 points linearly spaced b/w -.05 and .05
% creating normal(Gaussian) distribution
pd = makedist('Normal','mu',0,'sigma',0.01);
plot(x1,pdf(pd,x1),'Red','LineWidth',2);
set(gca,'YScale','log')
hold off
% integrating the stardard normal distribution
p = normcdf(x1,0,0.01)

% determining the associated 'sigma' value for a given probability
% trying some probability values
percent = [.8413,.9773] % 1 sigma = 84.13%, 2 sigma = 97.73%
sigmaTrial = norminv(percent)
% converting probability into sigma
sigma = norminv(p)
% The minus sign that appears in the results means that the sigma value is at 
% the left side of the mean of the normal distribution.


% # 2: Continuous analytic distribution: Exponential
% making plot of exponential distribution
d2 = random('Normal', 0, 0.01, [1,1000]);
histogram(d2,50,'DisplayStyle','stairs','LineWidth',4) % creating histogram of distribution
xlim([0,0.05]) % limiting the range of x showing on the graph
hold on
x2 = linspace(0,0.05,1000);
expd = makedist('Exponential','mu',.01);
plot(x2,pdf(expd,x2),'Red','LineWidth',2);
hold off
% # 3: Hypothetical value
% If there is a exponential distribution with mean of 5
% then what is the probability between 3 and 4?
% mean = 5, lambda (decay parameter) = 1/5 = 0.2
x3 = linspace(0,30,30);
expd3 = makedist('Exponential','mu',5);
plot(x3,pdf(expd3,x3),'Red','LineWidth',2);
% determining probability between x3 = 3 and x3 = 6
p3 = cdf('Exponential',x3,5)
% probability 0<x3<3 = 0.3389
% probability 0<x3<6 = 0.6446
% ptobability 3<x3<6 = 0.3057

% converting probability into sigma
sigmaProblem3 = expinv(0.3057,5)
% #4: Another hypothetical value
% creating random exponential distribution
x4 = linspace(0,30,30);
expd4 = makedist('Exponential','mu',2);
plot(x4,pdf(expd4,x4),'Red','LineWidth',2)
p4 = cdf('Exponential',x4,2)
% What is the probability between x4 = 15 and x4 = 20?
% probability 0<x4<15 = 0.9993
% probability 0<x4<20 = 0.9999
% probability 15<x4<20 = 0.0006

% converting probability into sigma
sigmaProblem4 = expinv(0.0006,2)
% When a distribution is exponential, the probability gets smaller as x value 
% gets bigger, and as probability gets smaller, the absolute value of sigma 
% gets bigger.



% Non-Continuous distributions: Poisson
x5 = 0:30;
poisson = makedist("Poisson", 'lambda',5); 
subplot(1,2,2)
stairs(x5-0.5,pdf(poisson,x5),"LineWidth",2);
set(gca,'YScale','log')
subplot(1,2,1)
stairs(x5-0.5,pdf(poisson,x5),"LineWidth",2);
% What is the probability of getting x5 = 5?
p5 = cdf('Poisson',5)
% Poisson distribution is discete, the probability is also discrete, and its
% probability at any x5 will be always 1.
pPoisson = cdf('Poisson',x5)
% Probability is discrete, however, the average chagnes continuously
% because, in Poisson distribution, mu is the average number of
% successes in a specific time interval, therefore, the average is not
% always integer.
clear all
close all

load('data_leopoldo.mat', 'R');
load('data_tinkercad.mat', 'tinkercad');

%data = tinkercad

data = R(:,1);
[sizeData, ~] = size(data);

% Histogram creation

nbins = 100;
[h,x] = hist(data, nbins);

% Characteristics

mu = mean(data)
sigma = std(data)

% Histogram and Normal Plot

[~, sizeH] = size(h);
normH = h ./ sizeH;

stairs(x, normH);
hold on
plot(x, normpdf(x, mu, sigma));

% Average Evolution

muTime = zeros(sizeData, 1);
for i = 1:sizeData
    muTime(i) = mean(data(1:i));
end

figure
plot(muTime, 'm');

% Sampling

splitedSize = 100;
splitedData = reshape(data, splitedSize, []);

splitedMu = mean(splitedData);
splitedSigma = std(splitedData);
splitedDelta = (2 * splitedSigma) / sqrt(splitedSize);

figure
errorbar(splitedMu, splitedDelta, 'x r')

load starData
nObs = size(spectra,1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

%task1
lambdaEnd = lambdaStart+(nObs-1) * lambdaDelta;
lambda = (lambdaStart: lambdaDelta: lambdaEnd);

%task2
s = spectra(:,6);
%task3

figure(2)
loglog(lambda, s, ".-")

xlabel("Wavelength")
ylabel("Intensity")

%task4
[sHa, idx] = min(s)
lambdaHa = lambda(idx)

%task5
hold on
    plot(lambdaHa, sHa, 'rs', 'MarkerSize', 8)
hold off

%task6
z = (lambdaHa / 656.28) - 1
speed = z * 299792.458



%Task1
[sHa,idx] = min(spectra(:,:));
lambdaHa = lambda(idx);
z = lambdaHa/656.28 - 1;
speed = z*299792.458;
%task3
figure(3)
for c = 1 : 1 : 7
    s = spectra(:,c);
    
    loglog(lambda, s, "--")
    hold on
end

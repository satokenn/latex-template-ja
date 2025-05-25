load starData
nObs = size(spectra,1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

lambdaEnd = lambdaStart+(nObs-1) * lambdaDelta;
lambda = (lambdaStart: lambdaDelta: lambdaEnd);

%Task1
[sHa,idx] = min(spectra(:,:));
lambdaHa = lambda(idx);
z = lambdaHa/656.28 - 1;
speed = z*299792.458;
%task3,4,5
figure(3)
for c = 1 : 1 : 7
    s = spectra(:,c);
    if(speed(c) <= 0)
        loglog(lambda, s, "--")
    else 
        loglog(lambda, s, "LineWidth", 3)
    end
    hold on
end
hold off

%task6
legend(starnames);
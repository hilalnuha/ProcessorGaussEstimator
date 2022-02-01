close all
clear
load('OpticalNetwork.mat')
maxx=max(X);
maxy=max(Y);
trainfract=0.9;
Xn=X;
Yn=Y;

numsi=max(size(X));
numtrain=floor(trainfract*numsi);

maxval=1/(1-trainfract);
SVMperfAll=[];
for ii=1:maxval
    indperm=randperm(numsi);
    indtrain=indperm(1:numtrain);
    indtest=indperm(numtrain+1:end);
    
    Xtrain=Xn(indtrain,:);
    Ytrain=Yn(indtrain,1);
    Xtest=Xn(indtest,:);
    Ytest=Yn(indtest,1);
    
    netSVM = fitrsvm(Xtrain,Ytrain);
    outval = predict(netSVM,Xtrain);
    maxx=1;
    outvaltest=predict(netSVM,Xtest);
    
    outvaltestmax=outvaltest*maxx;
    testingtargetmax=Ytest;
    SVMOut=outvaltestmax;
    SVMmsetest=mse(SVMOut,testingtargetmax);
    SVMrmsetest=rmse(SVMOut,testingtargetmax);
    SVMmaetest=mae(SVMOut,testingtargetmax);
    SVMmbetest=mbe(SVMOut,testingtargetmax);
    SVMnmsetest=nmse(SVMOut,testingtargetmax);
    SVMnrmsetest=nrmse(SVMOut,testingtargetmax);
    SVMmapetest=mape(SVMOut,testingtargetmax);
    SVMr2test=rsquare(SVMOut,testingtargetmax);
    SVMadjr2=adjr2(SVMOut,testingtargetmax,5);
    SVMperf=[SVMmsetest SVMrmsetest SVMmaetest SVMmbetest SVMnmsetest SVMnrmsetest SVMmapetest*100 SVMr2test*100 SVMadjr2*100];
    SVMperfAll=[SVMperfAll; SVMperf];
    
    figure
rl=[0.1 0.99];
axx=[0 1.1];
plot( SVMOut,testingtargetmax,'ob',rl,rl,'r');
xlabel('Actual')
ylabel('Estimated')
xlim(axx);
ylim(axx);
%title(['RNN 120 m Testing ']);
text(0.1*max(rl),0.8*max(rl),['R^2=' num2str(round(SVMr2test*100,2)) ' %'])

end

SVMperfAll
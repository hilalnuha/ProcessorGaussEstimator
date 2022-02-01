close all
clear
load('OpticalNetwork.mat')
maxx=max(X);
maxy=max(Y);
trainfract=0.9;
Xn=X(:,[1 2 3 4]);
Yn=Y;

numsi=max(size(X));
numtrain=floor(trainfract*numsi);

maxval=1/(1-trainfract);
GaussperfAll=[];
for ii=1:3
    indperm=randperm(numsi);
    indtrain=indperm(1:numtrain);
    indtest=indperm(numtrain+1:end);
    
    Xtrain=Xn(indtrain,:);
    Ytrain=Yn(indtrain,1);
    Xtest=Xn(indtest,:);
    Ytest=Yn(indtest,1);
    
    netGauss = fitrgp(Xtrain,Ytrain,'Sigma',2);
    outval = predict(netGauss,Xtrain);
    maxx=1;
    outvaltest=predict(netGauss,Xtest);
    
    outvaltestmax=outvaltest*maxx;
    testingtargetmax=Ytest;
    GaussOut=outvaltestmax;
    Gaussmsetest=mse(GaussOut,testingtargetmax);
    Gaussrmsetest=rmse(GaussOut,testingtargetmax);
    Gaussmaetest=mae(GaussOut,testingtargetmax);
    Gaussmbetest=mbe(GaussOut,testingtargetmax);
    Gaussnmsetest=nmse(GaussOut,testingtargetmax);
    Gaussnrmsetest=nrmse(GaussOut,testingtargetmax);
    Gaussmapetest=mape(GaussOut,testingtargetmax);
    Gaussr2test=rsquare(GaussOut,testingtargetmax);
    Gaussadjr2=adjr2(GaussOut,testingtargetmax,4);
    Gaussperf=[Gaussmsetest Gaussrmsetest Gaussmaetest Gaussmbetest Gaussnmsetest Gaussnrmsetest Gaussmapetest*100 Gaussr2test*100 Gaussadjr2*100];
    GaussperfAll=[GaussperfAll; Gaussperf];
    
    figure
rl=[0.1 0.99];
axx=[0 1.1];
plot( GaussOut,testingtargetmax,'ob',rl,rl,'r');
xlabel('Actual')
ylabel('Estimated')
xlim(axx);
ylim(axx);
%title(['RNN 120 m Testing ']);
text(0.1*max(rl),0.8*max(rl),['R^2=' num2str(round(Gaussr2test*100,2)) ' %'])

end

GaussperfAll
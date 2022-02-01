figure
histogram(X(:,1));
xlabel('Node Number ');
%ylabel('frequency')
figure
histogram(X(:,2));
xlabel('Thread Number');
figure
histogram(X(:,3));
xlabel('Spatial Distribution');
figure
histogram(X(:,4));
xlabel('Temporal Distribution');
figure
histogram(X(:,5));
xlabel('T/R');
figure
histogram(Y(:,1));
xlabel('Processor Utilization ');
% Manhat L1
clear;
close all;
tic;
OPTIONS=optimset('MaxIter',50000);
T = readtable('TwoLeadECG_TEST.csv');    % Load the training dataset
%T=readtable('Phi1.txt');% Function Phi1
%T=readtable('Phi2.txt');% Function Phi2
%T = readtable('TwoLeadECG_TRAIN.csv');    % Load the training dataset

T=table2array(T);

% add constant (first coordinate is 1)
T=[T(:,1) ones(size(T,1),1) T(:,2:size(T,2))];

%T=T(1:20,:);

outputs = T(1:end,1);                         % Column 1: y(i) values (output labels)
num_samples = size(outputs,1);            % Number of samples in the dataset
features = T(1:end,2:end);                    % Columns 2 onward: x(i) values (input features) 
num_features = size(features,2);          % Number of features in one sample (dimensionality)

alpha = 0.01;        % For the LReLU function (LReLU(x) = alpha*x +(1−alpha)*max{0,x})
eps = 0.000001;       % Tolarence for the bisection method (gap between upper and lower bounds)

%T=table2array(T);
%T=[ones(size(T,1),1) T];

% Simplify the variable names and convert table to matrix
X = features;
Y = outputs;
%Y=Y*10;

d=size(T,2)-1;% number of features (space dimension)
N=size(T,1);% number of points in the dataset (discretisation points)
n=1;% number of nodes in the hidden layer (pairs)



% Initial point
%Xval=zeros(2*n*d,1);
Xval=ones(2*n*d,1);

%Xval(1)=10;

numiter=5;
for ll=1:numiter
ll
% Compute subgradient as a row vector

v=zeros(1,2*n*d);
for i=1:N
    for j=1:n
    % some approximation of subgradient    
    if (Xval((j-1)*d+1:j*d))'*(X(i,:))'>=0
        v((j-1)*d+1:j*d)=v((j-1)*d+1:j*d)+X(i,:);
   % elseif (Xval((j-1)*d+1:j*d))'*(X(i,:))'>-0.1;
   %    v((j-1)*d+1:j*d)=v((j-1)*d+1:j*d)+X(i,:)*0.5;
    end;
    % some approximation of subgradient   
    if (Xval(n*d+(j-1)*d+1:n*d+j*d))'*(X(i,:))'>=0
        v(n*d+(j-1)*d+1:n*d+j*d)=v(n*d+(j-1)*d+1:n*d+j*d)+X(i,:);
    %elseif (Xval(n*d+(j-1)*d+1:n*d+j*d))'*(X(i,:))'>-0.1;
    %   v(n*d+(j-1)*d+1:n*d+j*d)=v(n*d+(j-1)*d+1:n*d+j*d)+X(i,:)*0.5;
    end;

    
        end;
end;

%v=v/max(abs(v));

A=zeros(2*N,2*n*d+N+2*n*N);% Top 2N rows
En=ones(1,n);% Row vectors of length n (times 2)

% Constructing top part of constraint matrix in LPP
%Z0=ones(N,n*N);
Z2=zeros(N,n*N);
for i=1:N
    Z2(i,(i-1)*n+1:i*n)=2*En;
    %Z0(i,(i-1)*n+1:i*n)=0*En;
end
% v (lower case v) is coming from subgradient
% V1=[];
% V2=[];
% for i=1:N
%     V1=[V1;-v(1,1:n*d)];
%     V2=[V2;-v(n*d+1:2*n*d)];
% end;
A=[zeros(N,2*n*d) -eye(N) zeros(N,n*N) Z2;
   zeros(N,2*n*d) -eye(N) Z2           zeros(N,n*N)];
%Constructing bottom matrix

Z=zeros(N*n,n*d);
for i=1:N
    for j=1:n
    Z((i-1)*n+j,(j-1)*d+1:j*d)=X(i,:); % Dataset points Xi 
    end
end
%     a         b             z            z+         z-
B=[Z         zeros(N*n,d*n) zeros(N*n,N) -eye(n*N) zeros(n*N);
  zeros(N*n,d*n) Z          zeros(N*n,N) zeros(n*N) -eye(n*N) ];

%LHS
A=[A;B];
%Cost vector
f=zeros(1,2*n*d+N+2*N*n);
f(2*d*n+1:2*d*n+N)=ones(1,N);
f(1:2*n*d)=-v;
%RHS
b=[-Y;Y;zeros(2*n*N,1)];
%LB
LB=[-inf*ones(2*n*d+N,1);zeros(2*n*N,1)];
UB=inf*(ones(2*n*d+N+2*N*n,1));
[Xval,val]=linprog(f,A,b,[],[],LB,UB);
val



% Compute the value of the approximation

for i=1:N
    Ya1(i)=0;
    Ya2(i)=0;
    for j=1:n
    Ya1(i)=Ya1(i)+max(0,X(i,:)*Xval((j-1)*d+1:j*d));
    Ya2(i)=Ya2(i)+max(0,X(i,:)*Xval(n*d+(j-1)*d+1:n*d+j*d));
    end;
    Ya(i)=Ya1(i)-Ya2(i);
end;
error=(Ya'-Y);
Iter(ll)=sum(abs(error))
end;
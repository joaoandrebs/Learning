% Método de Euler
clear all; clc; close all;

m = 30; M = 150; k1 = 30000; k2 = 80000; c1=60;  XB = 0.1; fB = 3; 
x01 = 0;
v01 = 0;
a01 = 0;
x02 = 0;
v02 = 0;
a02 = 0;

wB = 2*pi*fB

Dt = 0.0001;   t0=0;   tf=10;   t=t0:Dt:tf;   NT=length(t);

xB = XB*cos(wB*t);

x1 = zeros(1,NT);  v1 = zeros(1,NT);  a1 = zeros(1,NT);  x1(1,1)=x01;  v1(1,1)=v01;  a1(1,1)=a01;
x2 = zeros(1,NT);  v2 = zeros(1,NT);  a2 = zeros(1,NT);  x2(1,1)=x02;  v2(1,1)=v02;  a2(1,1)=a02;

for i=1:NT-1
ti=t(1,i);

%f1(1,i) = (-k1*(x1-x2) - c1*(v1-v2))/m;
%f2(1,i) = (k1*(x1-x2) + c1*(v1-v2) - k2*(x2-XB))/m;

f1(1,i) = (-k1*(x1(1,i)-x2(1,i)) - c1*(v1(1,i)-v2(1,i)))/M;
f2(1,i) = (k1*(x1(1,i)-x2(1,i)) + c1*(v1(1,i)-v2(1,i)) - k2*(x2(1,i)-xB(1,i)))/m;

x1(1,1+i) = x1(1,i) + v1(1,i) * Dt;
v1(1,i+1) = v1(1,i) + f1(1,i) * Dt;
x2(1,1+i) = x2(1,i) + v2(1,i) * Dt;
v2(1,i+1) = v2(1,i) + f2(1,i) * Dt;



end
%figure(1)
%plot(t,x); grid on; hold on;
%figure(2)
%plot(t,v); grid on; hold on;

%figure(1)
%subplot(1,2,1)
%plot(t,x); grid on; hold on;
%subplot(1,2,2)
%plot(t,v); grid on; hold on;

%figure(1)
%plot(t,xB); grid on;

figure(2)
subplot(1,2,1)
plot(t,x1); grid on;
xlabel('tempo'); ylabel('deslocamento');
subplot(1,2,2)
plot(t,v1); grid on;
xlabel('tempo'); ylabel('velocidade');

figure(3)
subplot(1,2,1)
plot(t,x2); grid on;
xlabel('tempo'); ylabel('deslocamento');
subplot(1,2,2)
plot(t,v2); grid on;
xlabel('tempo'); ylabel('velocidade');

figure(4)
subplot(1,2,1)
plot(t,x2); grid on;
xlabel('tempo'); ylabel('deslocamento');
subplot(1,2,2)
plot(t,v2); grid on;
xlabel('tempo'); ylabel('velocidade');

figure(4)
subplot(1,2,1)
plot(f1); grid on;
xlabel('tempo'); ylabel('deslocamento');
subplot(1,2,2)
plot(f2); grid on;
xlabel('tempo'); ylabel('deslocamento');

% 1 B)
%Calculo XRMS 

%para x

X1RMS = sqrt(sum(x1.^2)/NT)

X2RMS = sqrt(sum(x2.^2)/NT)

%para v

V1RMS = sqrt(sum(v1.^2)/NT)

V2RMS = sqrt(sum(v2.^2)/NT)

%para a

A1RMS = sqrt(sum(f1.^2)/NT)

A2RMS = sqrt(sum(f2.^2)/NT)

% 2 a) Diminuir o valor de XM (RMS) abaixo de 50% de XB

%diminuindo os parametros de M e aumentando o k1, obtemos 50% de XB

% 2 b) Diminuir o valor de f1 abaixo de 30 m/s^2

%diminuindo todos os parametros obtemos 19.58 m/s^2








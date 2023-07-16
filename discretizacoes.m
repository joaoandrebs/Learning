%Diferenças finitas - deflexao de vigas

%Dados da viga
L = 1.0;          % m
E = 210e9;         %(N/m²)
I = (0.02*(0.04)^3)/12;     %Momento de inercia da area de seç retangular
q = 2000;         %carga distribuida (N/m) em kg = 200 kg sobre a viga

h = L/9;      % numero de pontos para análise menos 1. no caso utilizado 5
x = [ 0, h, 2*h, 3*h, 4*h, 4*h,];
y1 = 0;
y5 = 0;

R1 = q*L/2

%Momento fletor
M2 = R1*x(1,2)-(q*x(1,2)^2)/2;
M3 = R1*x(1,3)-(q*x(1,3)^2)/2;
M4 = R1*x(1,4)-(q*x(1,4)^2)/2;

B2 = M2/(E*I)*h^2-y1;
B3 = M3/(E*I)*h^2;
B4 = M4/(E*I)*h^2-y5;


%Matriz A

A=[-2 1 0 ; 1 -2 1; 0 1 -2];

B = [B2 ; B3 ; B4];

Y = A\B
y = [y1;Y;y5]

plot(x,y); grid on;
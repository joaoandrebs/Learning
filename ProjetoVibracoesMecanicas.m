function [] = Sistema_com_5_graus_de_liberdade()
%% Sistema com 5 graus de liberdade
%Alunos: Gustavo Henrique Fagundes; João André Bitencourt dos Santos; Jorge
%Henrique Frasson e Patric de Mattos Peres
%        
%              m4,x4,A4  m3,x3,A3                    m1,x1,A1
%                 K4        K3                          K1
%      xA         xE        xD         m2*xG,AG         xC           xB                                   
%                                     I2*th2,Ath2                  
%      KA                                                            KB                
%                                             
%     base fixa                                                  base fixa
%
%
% syms operações simbólicas
%
clear all ; clc ;

syms K1 KA KB K3 K4 % molas
syms m1 m2 m3 m4 I2 % massas
syms x1 xG x3 x4 th2  % coordenadas independentes 
syms xA xB xC xD xE % coordenadas dependentes
syms a b c d e % distancias em relação ao centro de massa
syms A1 AG A3 A4 Ath2 % acelerações
syms M K

% relações geometricas entre coordenadas dependentes e independentes

xA = xG  - a*(th2) ;
xB = xG  + b*(th2) ;
xC = xG  + c*(th2) ;
xD = xG  - d*(th2) ;
xE = xG  - e*(th2) ;

% Equações das forças nas massas --->>> verificar



FKA = KA*( xA ) ;

FK4 = K4*( x4 - xE )

FK3 = K3*( x3 - xD ) ;

FK1 = K1*( x1 - xC ) ;

FKB = KB*( xB ) ;



% Equações do sistema


eq1 =  - FK1  -  m1*A1  ;     %  m1
eq2 =  - FKA - FKB + FK1 + FK3 + FK4 - m2*AG  ;     % m2
eq3 =  - FK3  -  m3*A3  ;     % m3
eq4 =  + FKA*a -FKB*b + FK1*c -FK3*d -FK4*e - I2*Ath2 ;  % I2 momento de inercia de massa kg m²
eq5 =  - FK4  -  m4*A4  ;     % m4


% --------------------------------------

EQ1 = expand(eq1);
EQ2 = expand(eq2);
EQ3 = expand(eq3);
EQ4 = expand(eq4);
EQ5 = expand(eq5);


VARIAVEIS_D = [   x1 ; xG ; x3 ; th2; x4 ] ;  % variaveis de deslocamento
VARIAVEIS_A = [   A1 ; AG ; A3 ; Ath2; A4 ] ; % variaveis de aceleração
 
EQUACOES = [ EQ1 ; EQ2 ; EQ3 ; EQ4; EQ5] ;
EQUACOES;


for i=1:5
for j=1:5
    EQUACOES(i,1)=collect(EQUACOES(i,1),VARIAVEIS_D(j,1))  ;
end
end

EQUACOES
EQUACOES=EQUACOES*-1;


for i=1:5
   COEFM=coeffs(EQUACOES(i,1),VARIAVEIS_A(i,1));
    M(i,i)=COEFM(1,2); 
end

M


for i=1:5
for j=1:5
    COEFK=coeffs(EQUACOES(i,1),VARIAVEIS_D(j,1));
    nK=length(COEFK);
    if nK == 1 ; K(i,j) = 0 ; end;
    if nK == 2 ; K(i,j)=COEFK(1,2); end; 
end
end


K

%% Dados numéricos
%======================================
% PROCEDIMENTO NUMÉRICO
%======================================

a = 1.5 ;
b = 1.6 ;
c = 1.0 ;
d = 0.4 ;
e = 1.0 ;

m1 = 80 ; % kg
m2 = 700 ; 
m3 = 200 ;
m4=  250;
I2 = 850 ;

K1 = 7500 ; % N/m
KA = 5500 ; % N/m
KB = 5000 ; % N/m
K3 = 7850 ; % N/m
K4 = 8620 ; % N/m

subs(M)
subs(K)

Mnum = double(subs(M)) ;
Knum = double(subs(K)) ;

M
K
Mnum
Knum


%% Cálculo de Autovalores e Autovetores
[VET,VAL]=eig(inv(Mnum)*Knum);
VET
VAL

%valores das frequências naturais
w_natural = sqrt(VAL);
w_natural

% figuras dos modos de vibração
figure(1)
for i=1:5
    subplot(1,5,i);
    plot(VET(:,i));
    grid on
end

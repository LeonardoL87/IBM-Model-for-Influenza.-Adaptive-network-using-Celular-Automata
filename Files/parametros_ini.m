function parametros_ini()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

l=0.2; %ponderaci�n de errores
b=5;
dt=1; %fraccionamiento de cada d�a.
r=0.0819; %paraminic(2);   %fraccion de tasa de latentes que pasan a ser infecciosos
g1=(0.4177); %paraminic(3); %recuperacion de infecciosos y asintomaticos
q= 0.076; % paraminic(4);
e=0.53;  %corresponde a k en el paper de la gripe de 1918. recuperacion

n=(1/(60*365));   %tasa de natalidad y muerte (por ahora)
d= (0.01);   %tasa de mortalidad por gripe (desde J)
a= 0.25;%(0.1623); %tasa de diagnosticados (pasan a J)

g2=(0.4177);
sigma=.5;
par=[l b sigma dt r g1 q e n d a g2];

save('parametros01.txt','par', '-ascii');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

escalaF=1/2;       %escala 1/10 en total
escalaC=1/2;
escalaS=escalaF*escalaC;    
% filas y columnas de la grilla
F= 500*escalaF*1 + 6;     
C= 500*escalaC*1 + 6;      
vecindad=ceil(b); %casillas vecinas
% parametros del modelo
esc=6;

Ns=174673*escalaS/esc;
Ne=365*escalaS/esc; 
Ni=186*escalaS/esc;
Nr=0*Ns;
Ns=Ns-Nr;
Nt=Ns+Ni+Ne;

DensidadS= Ns/((F-6)*(C-6));  %densidad de susceptibles
contactosI = DensidadS*vecindad; 

par=[escalaF escalaC F C vecindad esc Ns Ne Ni Nr DensidadS contactosI];
save('parametrosGrilla.txt','par', '-ascii');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S=50;%25; %cian
E=35;%50; %naranja
A=25;%35; %verde musgo
I=15;%100; %bordeau
R=40;%75;%40; %amarillo
D=1; %rojo
Vacio=255;%0;
obs=0;%20;

par=[S E A I R D Vacio obs];
save('coloresG.txt','par', '-ascii');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
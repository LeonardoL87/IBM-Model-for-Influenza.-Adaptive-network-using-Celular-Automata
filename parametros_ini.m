function parametros_ini(escala,vacin,densidad)
%--------------------------------------------------------------------------
% This function sets the initial and general values of the varables of the
% simulator, the user can set two of them: 1) the simulation scale from 1 to
% N; 2) Proportion of vaccinated population from 0 to 1/N, where N is the 
% size of initial sucseotible popuilation.
%--------------------------------------------------------------------------
switch nargin
    case 3
        esc=escala;
        vac=vacin;
        den=densidad;
    case 2
        esc=escala;
        vac=vacin;
    case 1
        esc=escala;
        vac=0;
    case 0
        esc=5;
        vac=0;
end
l=0.2;
b=9.9148;
dt=1; 
r=0.0819*dt;
g1=0.4177*dt; 
q= 0.003*dt;
e=0.53*dt;
n=(1/(60*365));   
d= 0.01*dt; 
a= 0.25*dt;
g2=0.4177*dt;
sigma=0.2025;
par=[l b sigma dt r g1 q e n d a g2];
save('Files/parametros01.txt','par', '-ascii');
%--------------------------------------------------------------------------
escalaF=esc;       
escalaC=esc;
escalaS=escalaF*escalaC*den;
F= round(500*escalaF + 6);     
C= round(500*escalaC + 6);      
vecindad=6;
%--------------------------------------------------------------------------
Nt=175224;
Ns=round(174673*escalaS);
Ne=round(365*escalaS); 
Ni=round(186*escalaS);
Nr=round(vac*Ns);
Ns=Ns-Nr;
%--------------------------------------------------------------------------
DensidadS= Ns/((F-vecindad)*(C-vecindad));  
contactosI = DensidadS/vecindad; 
par=[escalaF escalaC F C vecindad esc Ns Ne Ni Nr DensidadS contactosI];
save('Files/parametrosGrilla.txt','par', '-ascii');
%--------------------------------------------------------------------------
S=50;
E=35;
A=25;
I=15;
R=40;
D=1; 
Vacio=255;
obs=0;
par=[S E A I R D Vacio obs];
save('Files/coloresG.txt','par', '-ascii');
%--------------------------------------------------------------------------
end
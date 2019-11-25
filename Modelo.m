%--------------------------------------------------------------------------
% This next code corresponds to the dynamics of influenza virus, 
% on this script we invocate each funcion corresponding to each fase of dynamics
function [St,Et,Rt,At,It]=Modelo(Esc,vac,density,contact)
% matlabpool
%-------------------------INITIAL PARAMETERS-------------------------------
%This function load model parameters, change this parameters we must change
%inputs in this function.
parametros_ini(1/5*Esc,vac,density);
%------<<<<<--GAUSSIAN DISTRIBUTION FOR INFECTIVE INDIVIDUALS--->>>>>------

%dist() returns: 
%     pGauss: values of the normal distribution
%     t: time vector asociated.
[pGauss,t]=dist();
%----------------<<<<<--LOADIG INITIAL PARAMETERS--->>>>>------------------
% par01 loads:
%       b infection related parameter
%       d fraction of each day.
%       r fraction latent rate become infectious
%       g recovery rate
%       n birth rate and natural death rate
%       d death rate by illnes
% par02 loads:
%       F: number of rows in the grid   
%       C: number of columns in the grid     
%       Ns: Number of initial susceptible population
%       Ne: Number of initial latent population
%       Ni: Number of initial infectious population 
%       Nr: Number of inital recovered population
% par03 loads parameters for visualization:
%       S: Susceptible
%       E: Latent
%       A: Asymptomatic
%       I: Infectious
%       R: Recovered
%       D: Dead
%       Vacio: Empty
%       obs: Obstacle
par01=load('Files/parametros01.txt');
par02=load('Files/parametrosGrilla.txt');
par03=load('Files/coloresG.txt');
%--------------------------------------------------------------------------
F=par02(3);
C=par02(4);
%--------------------------------------------------------------------------
Vacio=par03(7);
%--------------------------------------------------------------------------
dt=par01(4);
dias=71;
iter=ceil(dias/dt);
%--------------------------------------------------------------------------
% Load the grid
grilla=ones(F,C)*Vacio;
grillaD=zeros(F,C);
%--------------------------------------------------------------------------
%create an aditional grid for infectious individuals density
grillaI=zeros(F,C);
Mapa=cell(F,C);
for i=1:F
    for j=1:C
        Mapa{i,j}=zeros(1,10);
    end
end
[grilla,grillaI,Mapa]=inicializar(pGauss,t,grilla,grillaI,Mapa,0);

%Set initial populations
St=zeros(1,iter); St(1)=par02(7);
Et=zeros(1,iter); Et(1)=par02(8);
Rt=zeros(1,iter); Rt(1)=par02(10); 
At=zeros(1,iter); 
It=zeros(1,iter); It(1)=par02(9);

% %-------------------------SIMULATION---------------------------------------

for t1=2:iter 

    if contact == 1
       [grilla,grillaI,grillaD,Mapa]=dinamica(grilla,grillaI,grillaD,Mapa,pGauss,t,St(t1-1),Rt(t1-1),It(t1-1));
    elseif contact == 2
            [grilla,grillaI,Mapa]=dinamica2(grilla,grillaI,Mapa,pGauss,t,St(t1-1),Rt(t1-1),It(t1-1));
            else fprintf('Error in the selection of contact  \n')
    end
%      0: random movment
%      1: center movment
    [grilla,grillaI,grillaD,Mapa]=movimiento(grilla,grillaI,grillaD,Mapa,1); 
    [St,Et,Rt,At,It]=conteo(grilla,St,Et,Rt,At,It,t1);
end

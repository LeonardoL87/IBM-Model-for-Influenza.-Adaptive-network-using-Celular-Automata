close all
clear all
clc
%% Main Script for influenza simulation with FCM
% Esc: escale of the experiment. 1 for full scale and 17n for scaled.
% vac: Vaccinaed  population fraction fraction.
% density: population density. 1 for full density and 1/n for less density.
% contact: 1 for local contact and 2 for full grid contact.
% Runs: number of experiments.
%%
Runs=10;
Esc=1;
vac=0;
density=1;
contact=1;
I=zeros(Runs,71);
A=I;
S=I;
E=I;
R=I;
fprintf('Starting  Simulation  \n')
% Start de simulations
tic;
for i=1:Runs
	fprintf('Experiment %d\n',i)
	[St,Et,Rt,At,It]=Modelo(Esc,vac,density,contact);
    I(i,:)=It;
    A(i,:)=At;
    S(i,:)=St;
    E(i,:)=Et;
    R(i,:)=Rt;
%     if you want to save the runs, you can uncomement this line
% 	  save('Infected_pop.txt','It','-append','-ascii');
   fprintf('Experiment Finished  \n')
end
fprintf(' Simulation Finished  \n')
toc;

figure()
plot(1:71,I,...
    'LineWidth',3,...
    'color',[0,0,0]+0.75)
hold on
plot(1:71,mean(I),...
'LineWidth',3,'color','red')
hold off
axis tight
grid on
xlabel('Days')
ylabel('Reported Cases')
title('Infected population')


figure()
plot(1:71,A,...
    'LineWidth',3,...
    'color',[0,0,0]+0.75)
hold on
plot(1:71,mean(A),...
'LineWidth',3,'color','magenta')
hold off
axis tight
grid on
xlabel('Days')
ylabel('Asymptomatic Cases')
title('Asymptomatic population')


figure()
plot(1:71,R,...
    'LineWidth',3,...
    'color',[0,0,0]+0.75)
hold on
plot(1:71,mean(R),...
'LineWidth',3,'color','green')
hold off
axis tight
grid on
xlabel('Days')
ylabel('Recovered')
title('Recovered population')

figure()
plot(1:71,S,...
    'LineWidth',3,...
    'color',[0,0,0]+0.75)
hold on
plot(1:71,mean(S),...
'LineWidth',3,'color','blue')
hold off
axis tight
grid on
xlabel('Days')
ylabel('Susceptible')
title('Susceptible population')


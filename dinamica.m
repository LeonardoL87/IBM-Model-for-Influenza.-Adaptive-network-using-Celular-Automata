function [grilla,grillaI,grillaD,Mapa]=dinamica(grilla,grillaI,grillaD,Mapa,dist,x1,St,Rt,It)
%--------------------------------------------------------------------------
% This function describes epidemic dynamics, result are given in the grids
% grilla and grillaI.
%--------------------------------------------------------------------------
par01=load('Files/parametros01.txt');
par02=load('Files/parametrosGrilla.txt');
par03=load('Files/coloresG.txt');
%--------------------------------------------------------------------------
F=par02(3);
C=par02(4);
vecindad=par02(5);
%--------------------------------------------------------------------------
I=par03(4);
A=par03(3);
S=par03(1);
E=par03(2);
R=par03(5);
Vacio=par03(7);
%--------------------------------------------------------------------------
% obs=par03(8);
contactosI=par02(12);
dt=par01(4);
beta=par01(2);   %tasa de contagio promedio por iteracion. Carga viral normal.
betaa=beta*par01(7);   %tasa de contagio por asintomáticos
% betaprima=beta*contactosI*dt; %prob de contagio por contacto con I;
betaprimaa=betaa*contactosI*dt; %prob de contagio por contacto con A
epsilon=par01(8);
r=par01(5);
% gamma1=par01(6)/par01(4);
gamma1=par01(6);
% gamma1=par01(6);
mu=par01(9);
DensidadS= St/((F)*(C));  
DensidadI= It/((F)*(C));
DensidadR= Rt/((F)*(C));
contactosI = DensidadS/vecindad; 
%--------------------------------------------------------------------------
Gaux=grilla;
grillaI=abs(grillaI);
% Mapa=cell(F,C);
t=x1;
f=vecindad+1;
c=vecindad+1;
Ff=F-vecindad;
Cf=C-vecindad;
for i=f:Ff
    for j=c:Cf
        if grillaD(i,j)>0
            grillaD(i,j)=(grillaD(i,j)+1)*dt;
        end
            
        %% FCM
        if sum(Mapa{i,j})~=0
            SI=grillaI(i,j)*contactosI*dt;
            C=MapaAutomata(DensidadI/(((2*vecindad)+1)^2-1),DensidadR/(((2*vecindad)+1)^2-1),SI,DensidadI,Mapa{i,j});
%             fprintf('y= %i ',j)
            Mapa{i,j}=C; 
        end
        
        %% DINAMICA 
        if grilla(i,j) == I 
            for m=-vecindad:vecindad
                   for n=-vecindad:vecindad
                       infectar = rand*dt;
                       if (Gaux(i+m,j+n) == S && infectar<(grillaI(i,j)*(contactosI*dt)))
                           Gaux(i+m,j+n)=E;
                           grillaD(i+m,j+n)=1;
                       end
                   end
            end
        end        
        %infección por asintomáticos
        if grilla(i,j)==A
            for m=-vecindad:vecindad
                   for n=-vecindad:vecindad
                       infectar = rand*dt;
                       if (Gaux(i+m,j+n) == S && infectar<betaprimaa)
                           Gaux(i+m,j+n)=E;
                           grillaD(i+m,j+n)=1;
                       end
                   end
            end
        end
       %-----------------------INFECTIOUS PHASE----------------------------
        if grilla(i,j)==E && grillaD(i,j) >=4       
           infeccioso=rand*dt;
%            infeccioso=0.15+(.5-0.15)*rand;
           if(infeccioso<epsilon) 
             sintomatico=rand*dt; 
              if(sintomatico<r) 
                 Gaux(i,j)=I;
                 grillaI(i,j) =abs(spline(dist,t,rand));
              else 
                 Gaux(i,j)=A;
              end
           end
        end
        %--------------------------RECOVERY PHASE--------------------------
       recuperado=rand*dt;
       if grilla(i,j)==I && (recuperado<gamma1) && grillaD(i,j)>=11
          Gaux(i,j)=R;
       end
      
       if grilla(i,j)==A && grillaD(i,j)>=11
          if (recuperado<gamma1)
              Gaux(i,j)=R;
          end
       end
       %--------------------BIRTHS-----------------------------------------
	nac = rand(1);
       if( nac < mu &&  grilla(i,j) == Vacio)
         Gaux(i,j)=S;
         grillaI(i,j)=Vacio;
       end
       %-------------------------------------------------------------------      
     end
end
grilla=Gaux;
end

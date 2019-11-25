function [grilla,grillaI,Mapa]=dinamica2(grilla,grillaI,Mapa,dist,x1,St,Rt,It)
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
vecindad2=16;
%--------------------------------------------------------------------------
I=par03(4);
A=par03(3);
S=par03(1);
E=par03(2);
R=par03(5);
Vacio=par03(7);
%--------------------------------------------------------------------------
contactosI=par02(12);
dt=par01(4);
beta=par01(2);  
betaa=beta*par01(7); 
betaprimaa=betaa*contactosI*dt; %prob de contagio por contacto con A
epsilon=par01(8);
r=par01(5);
gamma1=par01(6);
DensidadS= St/((F-vecindad)*(C-vecindad));  
DensidadI= It/((F-vecindad)*(C-vecindad));
DensidadR= Rt/((F-vecindad)*(C-vecindad));
contactosI = DensidadS/vecindad; 
mu=par01(9);
%--------------------------------------------------------------------------
Gaux=grilla;
grillaI=abs(grillaI);
t=x1;
f=vecindad+1;
c=vecindad+1;
Ff=F-vecindad;
Cf=C-vecindad;
for i=f:Ff
    for j=c:Cf
        %% FCM
        SI=grillaI(i,j)*contactosI*dt;
            C=MapaAutomata(DensidadI/(((2*vecindad)+1)^2-1),DensidadR/(((2*vecindad)+1)^2-1),SI,DensidadI,Mapa{i,j});
        Mapa{i,j}=C; 
        
        %% DINAMIC 
        if grilla(i,j) == I 
            p=0; 
            while p < vecindad2
                x=ceil(rand()*(Ff-6)+3);
                y=ceil(rand()*(Cf-6)+3);
                infectar=rand(1);
                p=p+1;   
                if (Gaux(x,y) == S) && (infectar < (grillaI(i,j)*(contactosI*dt)))            
                    Gaux(x,y)=E;    %grilla de posici�n de S
                end
            end
        end
        
        % infección por asintomáticos
        if grilla(i,j)==A
          p=0;          
          while p < vecindad2
             x=ceil(rand()*(Ff-6)+3);
             y=ceil(rand()*(Cf-6)+3);
             infectar=rand(1);
             p=p+1;
             if (Gaux(x,y)==S) && (infectar<betaprimaa)
                Gaux(x,y)=E;    
             end
          end
        end

       %-----------------------INFECTIOUS PHASE----------------------------
        if grilla(i,j)==E        
           infeccioso=rand;

           if(infeccioso<epsilon) 
             sintomatico=rand; 
              if(sintomatico<r) 
                 Gaux(i,j)=I;
                 grillaI(i,j) =abs(spline(dist,t,rand));
              else 
                 Gaux(i,j)=A;
              end
           end
        end
        %--------------------------RECOVERY PHASE--------------------------
       recuperado=rand;        
       if grilla(i,j)==I && (recuperado<gamma1)
          Gaux(i,j)=R;
       end
       
       if grilla(i,j)==A
          if (recuperado<gamma1)
              Gaux(i,j)=R;
          end
       end
       %--------------------BIRTHS-----------------------------------------
	nac = rand(1);
       if( nac < mu &&  grilla(i,j) == Vacio)
%        if( nac < mu &&  grilla(i,j) ~= Vacio &&  grilla(i,j) ~= obs)
         Gaux(i,j)=S;
         grillaI(i,j)=Vacio;
       end
       %-------------------------------------------------------------------      
     end
end
grilla=Gaux;
end

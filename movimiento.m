function [grilla,grillaI,grillaD,Mapa]=movimiento(grilla,grillaI,grillaD,Mapa,mov,t,tc)
%--------------------------------------------------------------------------
% This function corresponds with the movement phase, the results are given
% back in the two grids (grilla and grillaI), the parameter mov corresponds
% to the movment option 0- Random movment and1-directed to the center of 
% the grid. The parameters t and tc model an quarentine state; t is the
% actual time step and tc is the begin of quarentine.
%--------------------------------------------------------------------------
if nargin <= 6
    t=0;
    tc=1;
end;
if t>=tc 
    return;
end
par02=load('Files/parametrosGrilla.txt');
par03=load('Files/coloresG.txt');
%--------------------------------------------------------------------------
F=par02(3);
C=par02(4);
vecindad=par02(5);
%--------------------------------------------------------------------------
Vacio=par03(7);
obs=par03(8);
%--------------------------------------------------------------------------
Gaux=grilla;
mover=[0 0];
if mov==1
    fil=ceil(F/8);
    Fil=ceil(7/8*F);
    col=ceil(C/8);
    Col=ceil(7/8*C);
else if mov==0
        fil=vecindad+1;
        Fil=F-vecindad;
        col=vecindad+1;
        Col=C-vecindad;
    end
end
%--------------------------------------------------------------------------
for i=fil:Fil
    for j=col:Col 
        C=Mapa{i,j};
        C10=C(10);
        if(mov==0)
            mover = floor(rand([1,2])*3-1);
                if (C10>=0.5)% && (C10 <=0.7)
                mover=[0 0];
                end            
        end
%--------------------------------------------------------------------------        
        if(mov==1)
            mover=[0 0];
            if j<C/2 
                mover(2)=1;
            end
            if j>=C/2 
                mover(2)=-1;
            end           
            if i<F/2 
                mover(1)=1;
            end
            if i>=F/2 
                mover(1)=-1;
            end 
        end
%--------------------------------------------------------------------------        
            if(Gaux(i+mover(1),j+mover(2))~=obs && Gaux(i,j)~=obs && Gaux(i,j)~=Vacio)
                Vaux = Gaux(i+mover(1),j+mover(2));
                Gaux(i+mover(1),j+mover(2)) = Gaux(i,j);
                Gaux(i,j)=Vaux;
                 if grillaI(i,j)~=Vacio
                        Vaux = grillaI(i+mover(1),j+mover(2));
                        grillaI(i+mover(1),j+mover(2)) = grillaI(i,j);
                        grillaI(i,j)=Vaux;
                 end
                 if grillaD(i,j)~=0
                     Vaux = grillaD(i+mover(1),j+mover(2));
                     grillaD(i+mover(1),j+mover(2)) = grillaD(i,j);
                     grillaD(i,j)=Vaux;                     
                 end
                 if sum(Mapa{i,j}) ~=0
                     Vaux = Mapa{i+mover(1),j+mover(2)};
                     Mapa{i+mover(1),j+mover(2)} = Mapa{i,j};
                     Mapa{i,j}=Vaux; 
                 end
            end		           
    end
end
%--------------------------------------------------------------------------
grilla=Gaux;
end

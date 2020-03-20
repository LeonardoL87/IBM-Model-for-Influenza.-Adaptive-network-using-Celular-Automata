function [grilla,grillaI,Mapa]=inicializar(dist,t,grilla,grillaI,Mapa,sec)
%--------------------------------------------------------------------------
% This function set the initial state of the grid.
%--------------------------------------------------------------------------

%-----------------------PARAMETERS SET-------------------------------------

    par02=load('Files/parametrosGrilla.txt');
    par03=load('Files/coloresG.txt');
    vecindad=par02(5);
    S=par03(1); %cian
    E=par03(2); %naranja
    I=par03(4); %bordeau
    R=par03(5); %amarillo
    Vacio=par03(7);
    obs=par03(8);      
    F=par02(3);
    C=par02(4);
    Ni=par02(9);
    Ne=par02(8);
    Ns=par02(7);
    Nr=par02(10);
    
    
    %% ---------------------INFECTED-----------------------------------------
    p=0;
    while p < Ni
        x=ceil(vecindad+(F-2*vecindad)*rand);
        y=ceil(vecindad+(C-2*vecindad)*rand);
        if (grilla(x,y)==Vacio && grilla(x,y)~=obs)
            grilla(x,y)=I;    
            grillaI(x,y)=spline(dist,t,rand(1));
            p=p+1;
        end
    end
    %% -----------------------LATENT-----------------------------------------
    p=0;
    while p < Ne
        x=ceil(vecindad+(F-2*vecindad)*rand);
        y=ceil(vecindad+(C-2*vecindad)*rand);
        if (grilla(x,y)==Vacio && grilla(x,y)~=obs)
            grilla(x,y)=E;
            p=p+1;
        end
    end
    %% ------------------SUSCEPTIBLE-----------------------------------------
    p=0;
    while p < Ns
        x=ceil(vecindad+(F-2*vecindad)*rand);
        y=ceil(vecindad+(C-2*vecindad)*rand);
        if (grilla(x,y)==Vacio && grilla(x,y)~=obs)
            grilla(x,y)=S;
            p=p+1;
        end
    end
   %% ------------------RECOVERED-------------------------------------------- 
    p=0;
    while p < Nr
    	x=ceil(vecindad+(F-2*vecindad)*rand);
        y=ceil(vecindad+(C-2*vecindad)*rand);
    	if (grilla(x,y)==Vacio &&  grilla(x,y)~=obs)
      		grilla(x,y)=R;
      		p=p+1;
    	end
    end
    %% ---------------------Map-----------------------------------------
       p=0;
    while p < ceil(Ns*0)
    	x=ceil(vecindad+(F-2*vecindad)*rand);
        y=ceil(vecindad+(C-2*vecindad)*rand);
    	if (sum(Mapa{x,y})==0 && grilla(x,y)~= Vacio &&  grilla(x,y)~=obs)
      		Mapa{x,y}=[0 rand 0 0 0.1 0 rand 0 rand 0];
      		p=p+1;
    	end
    end
end

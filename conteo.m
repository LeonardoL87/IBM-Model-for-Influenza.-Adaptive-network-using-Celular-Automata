function [St,Et,Rt,At,It]=conteo(grilla,St,Et,Rt,At,It,t)
%--------------------------------------------------------------------------
% This function keeps track of different population size in each time step.
%--------------------------------------------------------------------------
 par02=load('Files/parametrosGrilla.txt');
 par03=load('Files/coloresG.txt');
%--------------------------------------------------------------------------
 F=par02(3);
 C=par02(4);
%--------------------------------------------------------------------------
 I=par03(4);
 A=par03(3);
 S=par03(1);
 E=par03(2);
 R=par03(5);
 %---------------------------------------------------------------------- ---
 for i=1:F
	for j=1:C
		switch grilla(i,j)
			case(S) 
                St(t)=St(t)+1;
			case(E) 
                Et(t)=Et(t)+1;
			case(I) 
                It(t)=It(t)+1;
			case(R) 
                Rt(t)=Rt(t)+1;          
			case(A) 
                At(t)=At(t)+1;            
		end
	end
 end
%--------------------------------------------------------------------------
end

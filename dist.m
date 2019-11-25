function [pGauss,t1]=dist()
%--------------------------------------------------------------------------
% This function calculates the probabilistic distribution for infected
% individuals, corresponding to a normal distribution.
%--------------------------------------------------------------------------
    par=load('Files/parametros01.txt');
    b=par(2);
    sigma=par(3);
    min=b-sigma*5/2;
    paso=sigma/2;
    max=b+sigma*5/2;
    t1=min:paso:max;
    pGauss=zeros(1,11);
    %----------------------------------------------------------------------
    for t=1:6
        pGauss(t) = normpdf(t1(t),b,sigma)*paso;
        pGauss(12-t) = pGauss(t);
     
    end
    %----------------------------------------------------------------------
    for t=2:11
        pGauss(t) =  pGauss(t) + pGauss(t-1);
    end
end
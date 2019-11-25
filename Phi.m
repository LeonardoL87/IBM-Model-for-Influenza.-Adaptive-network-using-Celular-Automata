function phi=Phi(C10)

% phi=(-10/4*(C10-3/10)+1);
% phi=2/(1+exp(5*C10));
phi=0;
    if C10 >= .3 && C10 < .4
        phi=spline([.3,.39],[.8,1],C10);
    end
    if C10 >= .4 && C10 < .59
        phi=spline([.4,.59],[.5,.79],C10);
    end
    if C10 >=.6  && C10 <= .7
        phi=spline([.6,.7],[0,.499],C10);
    end
%     if C10 >= .3 && C10 < .4
%         phi=interp1([.3,.4],[.8,1],C10);
%     end
%     if C10 >= .4 && C10 < .6
%         phi=interp1([.4,.6],[.5,.8],C10);
%     end
%     if C10 >=.6  && C10 <= .7
%         phi=interp1([.6,.7],[0,.5],C10);
%     end
end

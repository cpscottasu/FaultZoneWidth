%Code developed for:
%Slip Zone Width and Distributed Fault Slip from Differential Lidar Along the Creeping Section of the Central San Andreas Fault, California
%Chelsea Scott1, Stephen DeLong2 and Ramon Arrowsmith1
%1School of Earth and Space Exploration, Arizona State University, Tempe, AZ, USA
%2US Geological Survey, Moffett Field, CA, USA

clear all; close all
load strain_example 
%xdata- fault perpendicular location
%ydata- strain 
%b- mapped fault location - use as guess for fault location in the Gaussian
%fit 
    
x0= [1,0,1];%initial value of parameters
fun = @(x)(x(1)/1e3*exp(-(xdata-(b-x(2))).^2/(2*(x(3)*50)^2)))-ydata; %Gaussian function to fit to strain data 

options.Algorithm = 'levenberg-marquardt';
[x,resnorm,residual,exitflag,output,lambda,jacobian] = lsqnonlin(fun,x0,[],[],options); %non-linear least squares

x_toplot= min(xdata):1:max(xdata);
y_toplot=(x(1)/1e3*exp(-(x_toplot-(b-x(2))).^2/(2*(x(3)*50)^2)));
x(3) = abs(x(3));
x=[x(1)/1e3 (b-x(2)) x(3)*50 ];
f1= x(2);

figure
plot( xdata/1e3-mean(xdata/1e3), ydata ,'r.');hold on
plot(x_toplot/1e3-mean(xdata/1e3), y_toplot, '-k')
plot([1,1]*x(2)/1e3-mean(xdata/1e3),[ylim],'-k')
plot([1,1]*(x(2)-2*x(3))/1e3-mean(xdata/1e3),[ylim],'-b')
plot([1,1]*(x(2)+2*x(3))/1e3-mean(xdata/1e3),[ylim],'-b')
xlabel('Fault perpendicular (km)');ylabel('Shear strain')
title(['FZ Width: ',num2str(4*x(3)),' m'])
set(gca,'FontSize',14)




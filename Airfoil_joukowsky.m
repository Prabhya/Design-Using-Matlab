clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program is written to generate airfoil profile using Joukowsky Transform
% The aim of this program is understand how the profile of airfoil changes with change in initial constants
% The program does not have any part on how to generate values of C, r, C_x, C_y.
% As more theory i progress in i will start implementing how to generate C, r, C_x, C_y, based on more user friendly data.
% -Prabhjeet Singh Arora
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


c= 60;                  % Joukowsky transform coefficient
r= 68.83;                  % Radius of circle which is to be transformed
C_x = -5; 
C_y = 7.5;                % Center of circle which is to be transformed


%%%%%%% Generating a discrete circle %%%%%%%
theta = 0:pi/360:2*pi;
x = (r)*cos(theta)+C_x;
y = (r)*sin(theta)+C_y;

%%%%%%% Defining the discrete states/vectors as complex numbers %%%%%%%
zeta = complex(x,y);

%%%%%%% Joukowsky Transformation on the said points of complex plane %%%%%%%
z = zeta+c^2*zeta.^-1;

%%%%%%% Defining the complex numbers back as states/vectors %%%%%%%%
%%%%%%%      Shift and scale of the airfoil for tuning      %%%%%%%%
x_shift = 0;
y_shift = 0;
scale = 1;

z  = scale*z;                             % Scaling
zx =real(z)- x_shift*ones(1,length(z));   % Shifting in x - direction
zy =imag(z)- y_shift*ones(1,length(z));   % Shifting in y - direction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% Plot/Profile %%%%%%%%%%%%%%%
figure(1)
plot(zx,zy,'.-b');

%%%%%%%%%%%%% Plot Configuration %%%%%%%%%%%%%%%%%%%
title('Generating Airfoil Profile using Joukowsky Transform','FontSize',20);
legend('Discretized Airfoil Outline','FontSize',14);
xlabel('X - axis (in m)','FontSize',18);
ylabel('Y - axis (in m)','FontSize',18);
xlim([-130 130]);
ylim([-130 130]);
cprint = strcat('Joukowsky constant = ',num2str(c),' m');
rprint = strcat('Radius = ',num2str(r),' m');
c_xprint = strcat('X-Center = ',num2str(C_x),' m');
c_yprint = strcat('Y-Center = ',num2str(C_y),' m');
t = text(0,-75,{cprint,rprint,c_xprint,c_yprint});
t.FontSize = 16
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


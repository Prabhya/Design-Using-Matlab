clc
clear

%%%%%%%% Airfoil Profile generated according to Airfoil_joukowsky.m program %%%%%%%%
%%%%% Configuration %%%%%
r = 65.43;
c = 60;
C_x = -5;
C_y = 7.5;
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Tranform preparation %%%%%
th = 0:pi/360:2*pi;
cir = [r*cos(th)+C_x;r*sin(th)+C_y];
zeta = complex(cir(1,:),cir(2,:));

%%%%% Joukowsky Transform %%%%%
airfcom = zeta + c^2*zeta.^-1;
airf = [real(airfcom);imag(airfcom)];

%%%%% Airfoil Profile plot %%%%%
figure(1)
plot(airf(1,:),airf(2,:),'.')

%%%%% Plot Configuration %%%%%
title('Generating Airfoil Profile using Joukowsky Transform','FontSize',20);
legend('Discretized Airfoil Outline','FontSize',14);
xlabel('X - axis (in m)','FontSize',18);
ylabel('Y - axis (in m)','FontSize',18);
axis([-130 130 -130 130]);
cprint = strcat('Joukowsky constant = ',num2str(c),' m');
rprint = strcat('Radius = ',num2str(r),' m');
c_xprint = strcat('X-Center = ',num2str(C_x),' m');
c_yprint = strcat('Y-Center = ',num2str(C_y),' m');
t = text(0,-75,{cprint,rprint,c_xprint,c_yprint});
t.FontSize = 16
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Wing Design in 3-dimension %%%%%%%%%%%%%%%%%%

%%%%%%%%% Developing surface of a simple wing %%%%%%%%%%%%%%%

%%%%% Generating wing span %%%%%
airf_step = length(airf)-1;
airf_z_max = 700;
airf_z_min = -700;
airf_z_span = airf_z_max - airf_z_min;
airf_z = airf_z_min:airf_z_span/airf_step:airf_z_max;    
airf_3d = [airf;airf_z];

%%%%%%% Swapping y-z values to generate profile in x-z plane %%%%%%%
airf_x = airf_3d(1,:)'*ones(1,length(airf_3d));
airf_y = (airf_3d(3,:)'*ones(1,length(airf_3d)))';  % swap with z-values
airf_z = (airf_3d(2,:)'*ones(1,length(airf_3d)));   % swap with y-values

%%%%%%%%% 3d Wing Plot %%%%%%%%%
figure(2)
s=surf(airf_x,airf_y,airf_z);
%axis([-1500 1500 -1500 1500 -1500 1500]);
axis([-200 200 -1000 1000 -200 200])
s.EdgeColor = 'interp';
colormap winter
xlabel('X-axis (in m)', 'FontSize',18)
ylabel('Y-axis (in m)','FontSize',18)
zlabel('Z-axis (in m)','FontSize',18)
title('Surface generation of 3-d wing', 'FontSize',22)
grid on
hold on

function [Fixed] = convert_2_fixed_frames(r, theta, Xn, Yn, phi)
% converts the collecte
theta_clean = theta(r~=0);
r_clean = r(r~=0);
d = 0.1143; % in meters
x = r_clean .* cosd(theta_clean)+d;
y = r_clean .* sind(theta_clean);
z = zeros(length(x), 1);
z(end) = 1;
coordinate = [x, y, z];
% phi = Neato's rotation angle

% Xn and Yn are current NEATO's position in global frame
R_L = [cosd(phi), sind(phi), 0; -sind(phi), cosd(phi), 0; 0, 0, 1];
T_L = [1, 0, Xn; 0, 1, Yn; 0, 0, 1];
% % T_R_L = [cosd(phi).*(r_clean.*cosd(theta_clean)+d)-
% sind(phi).*(r_clean.*sind(theta_clean))+Xn; ...
% sind(phi).*(r_clean.*cosd(theta_clean)+d)+cosd(phi).*(r_clean*sind(theta_clean))+Yn; 1];
Fixed = T_L*R_L*coordinate';

plot(Fixed(1,:),Fixed(2,:),'ko')
end

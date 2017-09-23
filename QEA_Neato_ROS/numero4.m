T_gm = [1,0,Xn;0,1,Yn;0,0,1];
T_mg = [1,0,-Xn;0,1,-Yn;0,0,1];
% Xn and Yn are the neato's position in Neato's frame
R_gm = [cosd(phi), -sind(phi), 0; sind(phi), cosd(phi), 0; 0, 0, 1];
R_mg = [cosd(phi),sind
% phi = Neato's rotation
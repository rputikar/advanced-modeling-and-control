%% 
% Define the parameters as vectors/matrices

K = [0.7  0.3 -0.4;
     1.1 -0.6 -0.2;
     0.2  0.5 -0.9]; % gains
%% 
% Calculate the inverse of the steady-state gain matrix

K_inv = inv(K);
%% 
% Calculate the RGA matrix

rga_matrix = K .* (K_inv.');
disp('RGA matrix:');
rga_matrix
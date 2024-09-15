%% 
% Define the parameters as vectors/matrices

k = [5, 2.5; -4, 1];        % gains
theta = [3, 5; 6, 1];       % time delays
tau = [4, 15; 20, 5];       % time constants
%% 
% Laplace variable

s = tf('s'); 
%% 
% Initialize the transfer function matrix

G = tf(zeros(2, 2)); % Create a 2x2 transfer function matrix
%% 
% Loop to populate the transfer function matrix

for i = 1:2
    for j = 1:2
        G(i, j) = k(i, j) * exp(-theta(i, j) * s) / (tau(i, j) * s + 1);
    end
end
G
%% 
% Calculate the steady-state gain matrix by substituting s=0

K = evalfr(G, 0);
disp('Gain matrix at steady state:');
K
%% 
% Calculate the inverse of the steady-state gain matrix

K_inv = inv(K);
%% 
% Calculate the RGA matrix

rga_matrix = K .* (K_inv.');
disp('RGA matrix:');
rga_matrix
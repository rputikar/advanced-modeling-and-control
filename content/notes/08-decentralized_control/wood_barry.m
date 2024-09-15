%% Wood Barry Column
% The control objective in the WB distillation column is to maintain the desired 
% compositions in both the overhead (distillate) and bottom products by manipulating 
% the reflux flow rate and steam flow rate. However, since both inputs affect 
% both outputs, *decoupling* and *interaction management* are often required to 
% ensure efficient and stable control of the system.
% 
% This model is widely used in process control to study interactions in distillation 
% columns, and it simplifies the control of more complex chemical processes.
% 
% *Inputs* (Manipulated Variables):
%% 
% # *Reflux Flow Rate* (Input 1)
% # *Steam Flow Rate* (Input 2)
%% 
% *Outputs* (Controlled Variables):
%% 
% # *Overhead Composition (Distillate)* (Output 1)
% # *Bottom Composition* (Output 2)
%% 
% The transfer function is given by
% 
% $$G=\left[\begin{array}{cc}\frac{12.8 \exp (-s)}{16.7 s+1} & \frac{-18.9 \exp 
% (-3 s)}{21 s+1} \\\frac{6.6 \exp (-7 s)}{10.9 s+1} & \frac{-19.4 \exp (-3 s)}{14.4 
% s+1}\end{array}\right]$$
%% RGA

% Define Laplace variable
s = tf('s');

% Define the transfer function matrix G(s) with delays
G11 = 12.8 * exp(-s) / (16.7 * s + 1);
G12 = -18.9 * exp(-3 * s) / (21 * s + 1);
G21 = 6.6 * exp(-7 * s) / (10.9 * s + 1);
G22 = -19.4 * exp(-3 * s) / (14.4 * s + 1);

% Combine into a transfer function matrix
G = [G11 G12; G21 G22];
G

% Compute the steady-state gain matrix (i.e., evaluate at s = 0)
K = dcgain(G);

% Calculate the RGA matrix
RGA = K .* inv(K)';

% Display the results
disp('Static Gain Matrix (K):');
disp(K);

disp('Static RGA:');
disp(RGA);
%% Controller pairing
% The diagonal values 2.0094 indicate the gain between an input and its corresponding 
% output (e.g., input 1 to output 1 and input 2 to output 2). The off-diagonal 
% values −1.0094 represent the interaction between mismatched input-output pairs 
% (e.g., input 1 to output 2 and input 2 to output 1).
% 
% The RGA matrix suggests significant *interaction* and *inverse coupling* between 
% inputs and outputs, as the off-diagonal values are large and negative.
% 
% *Direct pairing* (input 1 to output 1, and input 2 to output 2) is preferred 
% because:
%% 
% * The diagonal values are still positive.
% * The off-diagonal negative values make inverse pairing (input 1 to output 
% 2, and input 2 to output 1) undesirable, as it could lead to unstable or inefficient 
% control.
%% Controller design
% Apply Ziegler-Nichols tuning (Matlab Control System Designer) to design 2 
% PID controllers
% 
% Design PID 1 based on  $$$g_{11} = \frac{12.8 e^{-s}}{16.7s + 1}$$$
% 
% PID Controller $G_{\textrm{C1}}$
%% 
% * $$$G_{c_1} = 1.2895 \left( 1 + \frac{1}{2s} + 0.4602s \right)$$$
% * $$$GM = 5.02 \, \text{dB}, \quad PM = 34.9^\circ$$$
%% 
% Design PID 2 based on $$$g_{22} = \frac{-19.4 e^{-3s}}{14.4s + 1}$$$
% 
% PID Controller $G_{\textrm{C2}}$
%% 
% * $$$G_{c_2} = -0.2548 \left( 1 + \frac{1}{5.6s} + 1.4s \right)$$$
% * $$$GM = 4.88 \, \text{dB}, \quad PM = 40.1^\circ$$$
%% 
% *Detuning*
% 
% If F=2
% 
% $$$$G_{c_1} = 0.6448 \left( 1 + \frac{1}{2s} + 0.4602s \right)$$$$G_{c_2} 
% = -0.1274 \left( 1 + \frac{1}{5.6s} + 1.4s \right)$$$$
% 
% If F=5
% 
% $$$$G_{c_1} = 0.2579 \left( 1 + \frac{1}{2s} + 0.4602s \right)$$$$G_{c_2} 
% = -0.0510 \left( 1 + \frac{1}{5.6s} + 1.4s \right)$$$$
%% 
% Define symbolic variables

syms s
%% 
% Given transfer functions in G(s)

G11 = (2 * exp(-7*s)) / (10*s + 1)
G12 = (0.5 * exp(-4*s)) / (19*s + 1)
G21 = (exp(-3*s)) / (20*s + 1)
G22 = (1.5 * exp(-2*s)) / (15*s + 1)
%% 
% Calculating D12(s) as -G12(s) / G11(s)

D12 = -(G12 / G11);
D12 = simplify(D12);
%% 
% Display the results

disp('D12(s) =');
disp(D12);
%% 
% The presence of $e^{-3s}$ indicates that the decoupler has a predictive capability 
% – it can predict the future input change that affect the current output, i.e., 
% the output change first before the input change (this can’t happen in our physical 
% world). Therefore, the decoupler is considered a non-causal system, thus cannot 
% be realized physically. 
% 
% Calculating D21(s) as -G21(s) / G22(s)

D21 = -(G21 / G22);
D21 = simplify(D21);

disp('D21(s) =');
disp(D21);
%% 
% Therefore, the decoupler is physically relizable, i.e., order of numerator 
% is not higher than the order of denominator, and also there is no predictive 
% term, only a delay term in the decoupler.
% 
%
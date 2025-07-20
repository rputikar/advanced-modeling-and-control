%% Demonstration of Partial Fraction and Transfer Function Functions in MATLAB
%% Define polynomial roots and coefficients

roots_vec = [-2 -3];         % Roots of the polynomial (denominator)
num = [1 5];                 % Numerator coefficients of the transfer function
den = poly(roots_vec);      % Convert roots to polynomial: s^2 + 5s + 6

% Display polynomial from roots
disp('Denominator from roots using poly:')
disp(den)

% Display symbolic polynomial
syms s
disp('Symbolic Denominator:')
disp(poly2sym(den, s))
%% roots: Find roots of a polynomial

roots_from_den = roots(den);
disp('Roots from polynomial using roots:')
disp(roots_from_den)
%% tf: Create a transfer function object

sys = tf(num, den)
%% pole: Find poles of the system
% Poles are the roots of the denominator and determine system stability and 
% dynamics.

disp(pole(sys))
%% tf2zp: Transfer function to zero-pole-gain form
%% 
% * |z| = zeros (roots of numerator)
% * |p| = poles (roots of denominator)
% * |k| = system gain

[z, p, k] = tf2zp(num, den);
disp('Zeros:'), disp(z)
disp('Poles:'), disp(p)
disp('Gain:'), disp(k)
%% zp2tf: Zero-pole-gain to transfer function form
% reconstruct and verify

[num2, den2] = zp2tf(z, p, k);
tf2 = tf(num2, den2)
%% zpk: Create a zero-pole-gain model
% Cleaner for high-order systems or when poles and zeros are more intuitive 
% than coefficients.

disp('Zero-Pole-Gain model:')
sys_zpk = zpk(z, p, k)
%% residue: Partial-fraction expansion
% Useful in inverse Laplace transforms and time-domain analysis.
% 
% Returns:
%% 
% * |R| = residues (coefficients in partial fractions)
% * |P| = poles
% * |K| = direct polynomial term (if any)
%% 
% The residues arise from decomposing the rational function. It refers to the 
% coefficients of the partial fraction expansion of a rational function. In control 
% and signal processing, residues determine how each pole contributes to the system's 
% time-domain response. Negative residue can indicate opposite phase, undershoot, 
% or inversion in the system response. 
% 
% We want to express it in the form:
% 
% $$\frac{s+5}{\left(s+2\right)\left(s+3\right)}=\frac{A}{s+3}+\frac{B}{s+2}$$
% 
% _Multiply both sides by the denominator_
% 
% $$s+5=A\left(s+2\right)+B\left(s+3\right)$$
% 
% $$s+5=As+2A+Bs+3B=\left(A+B\right)s+\left(2A+3B\right)$$
% 
% $$s+5=\left(A+B\right)s+\left(2A+3B\right)$$
% 
% we get:
% 
% $A+B=1$ and $2A+3B=5$
% 
% Solving simultaneously: $B=3\Rightarrow A=-2$
% 
% In terms of partial fractions: 
% 
% $$\frac{s+5}{\left(s+2\right)\left(s+3\right)}=\frac{-2}{s+3}+\frac{3}{s+2}$$

[R, P, K] = residue(num, den)
%% 
% K is the non-fractional part of the transfer function. It may represent step, 
% ramp, or other base inputs. Here K is empty because Degree of numerator < degree 
% of denominator.
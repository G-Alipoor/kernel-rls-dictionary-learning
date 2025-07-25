function P = OKDLRSUpdate(Y, P, varargin)

%
% OKDLRSUpdate
% This function updates the profile of the dictionary according to the online
% kernel dictionary learning algorithm, proposed in the following paper:
%     H. Liu and F. Sun, "Online kernel dictionary learning for object recognition," 2016,
%     IEEE International Conference on Automation Science and Engineering (CASE), pp. 268--273,
%
% Generated by Ghasem Alipoor (alipoor@hut.ac.ir) and Karl Skretting (karl.skretting@uis.no)
% Last modification: 13 June 2023
%

pnames = {'Rho', ...  % constant learning rate
    'mu_m', ...            % lower bound of mu
    'maxL', ...              % max value for profile L, ex 400
    'newL'};                % Profile L after pruning, ex 300
dflts = {1.1, 0.1, 200, 190};        % maxL, newL
[Rho, mu_m, maxL, newL] = getarg(varargin,pnames,dflts);

Epsilon = 1e-4;
c_m = 1e4;
MaxIter = 200;

M = size(Y, 2);      % Number of input data samples used to update the profile

K_Yy = ker_eval(P.Y, Y, P.KernelType, P.KernelParam);
K_yy = ker_eval(Y, Y, P.KernelType, P.KernelParam);
P.K = cat(1, cat(2, P.K, K_Yy), cat(2, K_Yy', K_yy));
P.Y = cat(2, P.Y, Y);
P.A = cat(1, P.A, randn(M, P.Q));
for k = 1:P.Q
    P.A(:, k) = P.A(:, k)/(sqrt(P.A(:, k)'*P.K*P.A(:, k)) + eps);
end
P.C = cat(2, P.C, randn(P.Q, M));
L = size(P.C, 2);
% Main iteration
Diff_C = inf;
Diff_A = inf;
Iter = 0;
while (Diff_C > Epsilon || Diff_A > Epsilon) && Iter < MaxIter
    % Step 1: Calculate C
    % 1.1: Calculate mu_C
    L_A = P.A'*P.K*P.A;
    L_C = norm(L_A, 'fro');
    mu_c = max(Rho*L_C, mu_m);
    % 1.2: Update C
    Del = -2*P.A'*P.K + 2*L_A*P.C;
    C_new = P.C - Del/mu_c;
    for j = 1:L
        c_j = C_new(:, j);
        [~, Idx] = maxk(abs(c_j), P.s);
        c_j(setdiff(1:P.Q, Idx)) = 0;
        Idx = find(abs(c_j) > c_m);
        c_j(Idx) = sign(c_j(Idx))*c_m;
        C_new(:, j) = c_j;
    end
    Diff_C = norm(P.C - C_new, 'fro')/(norm(P.C, 'fro') + eps);
    P.C = C_new;

    % Step 2: Calculate A
    % 2.1: Calculate mu_A
    L_A = 2*norm(P.K, 'fro')*norm(P.C*P.C', 'fro');
    mu_A = max(Rho*L_A, mu_m);
    % 2.2: Update A
    Del = 2*P.K*(P.A*P.C - eye(size(P.A, 1)))*P.C';
    A_new = P.A - Del/mu_A;
    if L > maxL
        [~, Idx] = maxk(vecnorm(A_new'), newL);
    else
        Idx = 1:L;
    end
    A_new(setdiff(1:L, Idx), :) = 0;
    for k = 1:P.Q
        A_new(:, k) = A_new(:, k)/(sqrt(A_new(:, k)'*P.K*A_new(:, k)) + eps);
    end
    Diff_A = norm(P.A - A_new, 'fro')/(norm(P.A, 'fro') + eps);
    P.A = A_new;

    Iter = Iter + 1;
end
% Discarding the least important samples
Idx = sort(Idx);
P.Y = P.Y(:, Idx);
P.C = P.C(:, Idx);
P.K = P.K(Idx, Idx);
P.A = P.A(Idx, :);
end

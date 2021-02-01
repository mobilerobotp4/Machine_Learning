function[w, b, alpha] = svm_quadprog_dual(X, y, C)
    % Size of feature vector and Number of training examples
    d = size(X, 1);
    n = size(X, 2);

    % Construct the matrices to use quadprog()
    H = (y*y').*(X'*X);
    f = -ones(1, n);
    A = zeros(1 ,n);
    cval = zeros(1, 1);
    Aeq = y';
    ceq = 0;
    lb = zeros(n, 1);
    ub = C*ones(n, 1);

    % Solve using quadratic programming
    alpha = quadprog(H, f, A, cval, Aeq, ceq, lb, ub);

    % Compute optimal weight vector and bias
    w = X*(alpha.*y);                             % weights
    i = min(find(alpha>0));                       % support vector index
    G = X'*X;
    b = y(i) - G(i, :)*(alpha.*y);
end
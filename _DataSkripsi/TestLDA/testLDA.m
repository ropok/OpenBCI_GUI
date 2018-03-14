% 1.1 Dummy Data
X = [rand(10,2); rand(15,2) + 1.5];
Y = [zeros(10,1); ones(15,1)];

% 1.2 Mean Vector
% | x1 | y1 |
%  ---------
% | x2 | y2 |
meanX(1,1) = mean(X(1:10,1)); % C1 - X
meanX(1,2) = mean(X(1:10,2)); % C1 - Y
meanX(2,1) = mean(X(11:25,1)); % C2 - X
meanX(2,2) = mean(X(11:25,2)); % C2 - Y

% 1.3 nilai tengah (m2-m1) : diantara vector m2 dan m1 : x2-x1 dan y2-y1
mid = meanX(2,:) - meanX(1,:);

% 2.1 Scattering Dummy Data
hold on
    scatter(X(1:10,1), X(1:10,2)); % C1
    scatter(X(11:25,1), X(11:25,2)); % C2
    % 2.2 Scattering Mean Vector
    scatter(meanX(1,1), meanX(1,2), '*b');
    scatter(meanX(2,1), meanX(2,2), '*r');
    scatter(mid(1), mid(2), '^k');
hold off
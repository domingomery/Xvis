kp = 0.4;
N = 100;
[X1,d1] = Xgaussgen([1.5   2  ;3.5  1.0  ],kp*[1 1;1 1],N*ones(2,1));
[X2,d2] = Xgaussgen([3   2  ;4   2 ],kp*[1 1;1 1],N*ones(2,1));
[X3,d3] = Xgaussgen([2   3  ;3.5 3.5],kp*[1 1;1 1],N*ones(2,1));
[X4,d4] = Xgaussgen([2.5 3  ;2.5 4  ],kp*[1 1;1 1],N*ones(2,1));
[X5,d5] = Xgaussgen([2.5 2.5;4   3  ],kp*[1 1;1 1],N*ones(2,1));
[X6,d6] = Xgaussgen([2.5 2  ;3   4  ],kp*[1 1;1 1],N*ones(2,1));
X0 = [X1;X2;X3;X4;X5;X6]; d0 = [d1;d2;d3;d4;d5;d6];

d0 = d0-1;
[Xtrain,dtrain,Xtest,dtest] = Xstratify(X0,d0,2/3);

Xn = ['x_1';'x_2'];

clb;Xplotfeatures(Xtrain,dtrain,Xn)


save data_simulated Xtrain dtrain Xtest dtest Xn

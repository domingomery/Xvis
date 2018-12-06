% selec = Xfclean(X,options)
%
% Toolbox Xvis:
%    Feature selection cleaning.
%
%    This approach eliminate features that are not relevant:
%    1) It eliminates constant features (if standard deviation is < options.theta1)
%    2) If absolute of the correlation coefficient of any two features are
%       greater than options.theta2, one of the is eliminated.
%
%    Default for options.theta1 = 1e-8 and for options.theta2 = 0.99
%
%    Input: X is the feature matrix.
%           options.show = 1 displays results (default options.show=0)
%    Output: selec is the indices of the selected features
%
% Example:
%    load datafish
%    s = Xfclean(X);                 % index of selected features
%    Xs = X(:,s);                    % selected features
%    Xsn = Xn(s,:);                  % list of feature names
%    disp('Original:'); size(X)      % original set of features
%    disp('Selected:'); size(Xs)     % set of selecte features


function selec = Xfclean(X,options)

show = 0;
theta1 = 1e-8;
theta2 = 0.99;

if exist('options','var')
    if isstruct(options)==1
        if isfield(options,'show')
            show = options.show;
        end
        if isfield(options,'theta1')
            theta1 = options.theta1;
        end
        if isfield(options,'theta2')
            theta2 = options.theta2;
        end
    else
        show = options;
    end
end


if not(exist('show','var'))
    show = 0;
end

nf = size(X,2);
p  = 1:nf;
ip = zeros(nf,1);

% eliminating correlated features
warning off
C = abs(corrcoef(X));
warning on
[ii,jj] = find(C>theta2);
if (not(isempty(ii)))
    for i=1:length(ii)
        if (abs(ii(i)-jj(i))>0)
            k = max([ii(i) jj(i)]);
            t = find(p==k);
            n = length(p);
            if (not(isempty(t)))
                if (t==1)
                    p = p(2:n);
                else
                    if (t==n)
                        p = p(1:n-1);
                    else
                        p = p([1:t-1 t+1:n]);
                    end
                end
            end
        end
    end
end

ip(p) = 1;

% eliminating constant features
s = std(X);
ii = find(s<theta1);
if not(isempty(ii))
    ip(ii) = 0;
end
p = find(ip);
fc  = X(:,p);
nc = size(fc,2);
if show
    fprintf('Xfclean: number of features reduced from %d to %d.\n',nf,nc)
end
selec=p;

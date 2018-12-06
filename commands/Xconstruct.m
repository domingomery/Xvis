% This function is not a classifier!!!
% This function is called by Xvis classifier functions (such as Xlda) to
% build the training and testing data.

function [train,test,X,d,Xt,options] = Xconstruct(varargin)

train = 0;
test  = 0;
switch nargin
    case 2 % [ds,options] = Xlda(Xt,options)        % testing only
        X       = [];
        d       = [];
        Xt      = varargin{1};
        options = varargin{2};
        test    = 1;
    case 3   % options = Xlda(X,d,options)          % training only
        X       = varargin{1};
        d       = double(varargin{2});
        if size(X,1)~=length(d)
            error('Length of label vector does not match number of instances.');
        end
        Xt      = [];
        options = varargin{3};
        train   = 1;
    case 4   % [ds,options] = Xlda(X,d,Xt,options)  % training & test
        X       = varargin{1};
        d       = double(varargin{2});
        if size(X,1)~=length(d)
            error('Length of label vector does not match number of instances.');
        end
        Xt      = varargin{3};
        options = varargin{4};
        test    = 1;
        train   = 1;
    otherwise
        error('Xconstruct: number of input arguments must be 2, 3 or 4.');
end

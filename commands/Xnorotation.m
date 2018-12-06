% [f_new,fn_new] = Xnorotation(f,fn)
%
% Toolbox Xvis:
%     This procedure deletes all no rotation invariant features.
%     It deletes the features that have in their name the strings:
%     - orient             
%     - Gabor(   
%     - Fourier Abs (
%     - Fourier Ang (
%     - DCT(
%     - [8,u2] for LBP             
%
% Example:
%        I = imread('fruit.png');                                 % input image
%        R = Xsegbimodal(I);                                      % segmentation
%        bi(1).name = 'gabor';     bi(1).options.show=1;          % Gabor features
%                                  bi(1).options.Lgabor    = 8;   % number of rotations
%                                  bi(1).options.Sgabor    = 8;   % number of dilations (scale)
%                                  bi(1).options.fhgabor   = 2;   % highest frequency of interest
%                                  bi(1).options.flgabor   = 0.1; % lowest frequency of interest
%                                  bi(1).options.Mgabor    = 21;  % mask size
%        bi(2).name = 'basicint';  bi(2).options.show      = 1;   % Basic intensity features
%        bi(3).name = 'haralick';  bi(3).options.show      = 1;   % Haralick
%                                  bi(3).options.dharalick = 3;   % 3 pixels distance for co-ocurrence
%        options.b = bi;
%        [Xi,Xni] = Xfxint(I,R,options);                          % intensity features
%        bg(1).name = 'hugeo';     bg(1).options.show      = 1;   % Hu moments
%        bg(2).name = 'fitellipse';bg(2).options.show      = 1;   % ellipse features
%        options.b = bg;
%        [Xg,Xng] = Xfxgeo(R,options);                            % geometry features
%        X0 = [Xi Xg]; Xn0 =[Xni;Xng];
%        fprintf('\nOriginal features\n');
%        Xprintfeatures(X0,Xn0)
%        [X,Xn] = Xnorotation(X0,Xn0);     % delete position features
%        fprintf('\nSelected features\n');
%        Xprintfeatures(X,Xn)

function [f_new,fn_new] = Xnorotation(f,fn)

s = {'Orientation','Ellipse-orient','Gabor(','[8,u2]','sLBP','Fourier Abs (','Fourier Ang (','DCT('};

[f_new,fn_new] = Xnofeatures(f,fn,s); 


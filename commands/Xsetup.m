% Xsetup
%
% Toolbox Xvis:
%    Setup of Toolbox Xvis
% 
%    Run this procedure from Xvis folder


XvisPath = pwd;

addpath(fullfile(XvisPath));
addpath(fullfile(XvisPath,'misc'));
addpath(fullfile(XvisPath,'Examples'));

title('Installing Xvis 1.0 ...');

savepath

fprintf('Xvis 1.0 installed succefully!\n');

disp('If you want to use GDXray database follow these steps:')
disp('1. Download GDXray from http://dmery.ing.puc.cl/index.php/material/gdxray/');
disp('2. Edit file gdx_root.txt in Xvis directory and write the name of the root directory of GDXray (of your computer).'); 





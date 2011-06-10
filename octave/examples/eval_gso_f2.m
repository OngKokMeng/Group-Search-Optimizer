%clear all;
addpath('~/workspace/libgso');
more off;
%rand('seed',0);
ntimes = 100;

% parametros definidos no artigo
n = 30;
U = 10 *ones(1,n);
L =-10 *ones(1,n);
niter = 3000;

options = gsoptions();
options.a           = round(sqrt(n+1));
options.tmax        = pi/(options.a)^2;
options.amax        = options.tmax/2;
options.limitspace  = 'dont_move';
options.niterations = niter;
options.nscroungers = 0.8;
options.nproducers  = 1;
options.error       = 0;
options.popsize     = 48;
options.elitesize   = 10;
options.stall       = 10;
options.verbose     = 1;
options.lmax        = 10;
		
%% limite minimo para busca
for i=1:options.popsize Xmin(i,:)=ones(1,n).*L; end;  
%% limite maximo para busca
for i=1:options.popsize Xmax(i,:)=ones(1,n).*U; end;  	

options.lmax        = sqrt(sum((Xmax(1,:)-Xmin(1,:)).^2));


fprintf('Running test f2...');
%disp(options);
FX = [];
for i=1:ntimes
	tic;
	[x fx]=gso(@f2,U,L,options);
    FX = [FX fx(1)];
	
    fprintf('Test: %d \t Solution: %e \t Time: %f\n', i,fx(1),toc);
end;

fprintf('Done!\n');
fclose(fid);
%% Histogram Gaussian noise channel
r=randn(10000, 6); 
r=r';
A=sum(r);
size(A)
%sixe(x)
%subplot(3,3,8);
hist(A,100)
% Calculate the min, max, mean, median, and standard deviation
%min=min(A);
%max=max(A);
mn=mean(A);
%md=median(A);
%stdv=std(A);
variance = var(A);
% Create the labels
%minlabel=sprintf('Min -- %3.2d', min);
%maxlabel=sprintf('Max -- %3.2d', max);
mnlabel=sprintf('Mean -- %3.2d', mn);
%mdlabel=sprintf('Median -- %3.2d', md);
%stdlabel=sprintf('Std Deviation -- %3.2d', stdv);
vrlabel=sprintf('variance -- %3.2d', variance);
% Create the textbox
h=annotation('textbox',[0.58 0.75 0.1 0.1]);
set(h,'String',{mnlabel,vrlabel});

%set(h,'String',{minlabel, maxlabel,mnlabel, mdlabel, stdlabel, vrlabel});
%y = g + x; 
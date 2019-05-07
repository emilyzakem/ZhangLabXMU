% Data obtained from equilibrator (http://equilibrator.weizmann.ac.il/) Relevant DOIs: 10.1093/nar/gkr874; 10.1093/bioinformatics/bts317; 10.1371/journal.pcbi.1003098
%                AOB dG  NH3   O2   NO2   NO3   pH  Ionic Strength  NOB dG 
%                 (kJ)  (mM)  (mM)  (mM)  (mM)            (M)        (kJ)
LowNH3HighNO2 = [-252.3	1E-6  0.25  1E-3  5E-2  8.1	    0.7         -71.5
                 -258	1E-6  0.25  1E-4  5E-2  8.1	    0.7         -65.8
                 -263.7	1E-6  0.25  1E-5  5E-2  8.1	    0.7         -60.1
                 -269.4	1E-6  0.25  1E-6  5E-2  8.1	    0.7         -54.4]; %1 nM NH3 and 50 uM NO3

HighNH3LowNO2 = [-263.7  1E-4  0.25	1E-3  1E-4	8.1     0.7         -86.9
                 -269.04 1E-4  0.25	1E-4  1E-4	8.1     0.7         -81.2
                 -275.1  1E-4  0.25	1E-5  1E-4	8.1     0.7         -75.5
                 -280.8  1E-4  0.25	1E-6  1E-4	8.1     0.7         -69.8]; %100 nM NH3 and 0.1 uM NO3

LowerLimitNitrite = 7.21; % nM
UpperLimitNitrite = 29;   % nM

RatioOfFreeEnergyForHighNH3LowNO2 = HighNH3LowNO2(:,1)./HighNH3LowNO2(:,8); % J/J
NitriteConcentrationForHighNH3LowNO2 = HighNH3LowNO2(:,4)*1000000;          % nM

RatioOfFreeEnergyForLowNH3HighNO2 = LowNH3HighNO2(:,1)./LowNH3HighNO2(:,8); % J/J
NitriteConcentrationForLowNH3HighNO2 = LowNH3HighNO2(:,4)*1000000;          % nM

% plotting settings
FS='FontSize'; FSV=12; FN='FontName';  FNV='Arial'; LW='LineWidth'; LWV=2; C='color'; CV=[1,1,1]; U='Units'; UV='inches'; P='Position'; NPV='add'; NP='Nextplot';

% Create the plotting environment
f=figure; f.Renderer='painter'; f.Units=UV; f.Position=[0.1 0.1 4.5 4]; f.Resize='off'; f.NextPlot='add'; f.PaperSize=[8 14]; f.PaperPosition=f.Position; 
axes(NP,NPV,U,UV,P,[1 0.6 3 3],FS,FSV,FN,FNV,LW,LWV-1,'YTick',[3:0.5:5],'XTick',[1 10 100 1000],'XScale','Log','Layer','top','XMinorTick','off','YMinorTick','off','TickDir','out');
% Plot the filled regions
fill([LowerLimitNitrite LowerLimitNitrite UpperLimitNitrite UpperLimitNitrite LowerLimitNitrite],[1 10 10 1 1],CV*0,LW,LWV,'LineStyle',':','FaceAlpha',0.2); 
% Plot the lines for observed values
fill([10000; NitriteConcentrationForHighNH3LowNO2; 0.1; 0.1; flipud(NitriteConcentrationForLowNH3HighNO2); 10000],[4; RatioOfFreeEnergyForHighNH3LowNO2; 4; 4; flipud(RatioOfFreeEnergyForLowNH3HighNO2); 4],CV*0,'FaceAlpha',0.2,LW,LWV);
% plot(NitriteConcentrationForHighNH3LowNO2,RatioOfFreeEnergyForHighNH3LowNO2,NitriteConcentrationForLowNH3HighNO2,RatioOfFreeEnergyForLowNH3HighNO2,C,CV*0,LW,LWV);
% Set the axis limits and labels
axis([1 1000 3 5]); 

xlabel(sprintf('Nitrite Concentration (nM)')); 
ylabel(sprintf('Relative free energy from oxidation\n(J_{NH_{3}} J_{NO_{2}}^{-1})'));
text(1.17,2.5,{'Observed' 'range of' 'nitrite'},U,UV,FS,FSV-4,FN,FNV,'HorizontalAlignment','center')
text(1.9,0.2,{'100 nM NH_{3}' '100 nM NO_{3}'},U,UV,FS,FSV-4,FN,FNV,'HorizontalAlignment','center')
text(2.6,1.4,{'1 nM NH_{3}' '50000 nM NO_{3}'},U,UV,FS,FSV-4,FN,FNV,'HorizontalAlignment','center')
text(0.4,1.9,{'Simulated' 'range of' 'free' 'energies'},U,UV,FS,FSV-4,FN,FNV,'HorizontalAlignment','center')
text(1.17,1.4,{'Expected' 'range'},U,UV,FS,FSV-4,FN,FNV,'HorizontalAlignment','center')

% Export the figure
print(f,'Thermoplot.tif','-dtiff','-cmyk','-r600'); 
close(f);
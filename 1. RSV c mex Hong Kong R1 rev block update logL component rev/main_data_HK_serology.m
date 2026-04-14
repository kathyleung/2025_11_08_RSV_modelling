
% 2025-08-18
% Local HK RSV serology

clearvars;

% 1. Data
igGRSV = readtable('../0. data/Hong_Kong_serology_CC/250813CC RSV-F IgG data.xlsx');
cutoffOD450 = 0.3719;

igGRSV.RSVIgG_positive = zeros(length(igGRSV.SampleID),1);
igGRSV.RSVIgM_positive = zeros(length(igGRSV.SampleID),1);

igGRSV.RSVIgG_positive(igGRSV.RSVIgG_O_D_450nm_>=cutoffOD450) = 1;
igGRSV.RSVIgM_positive(igGRSV.RSVIgM_O_D_450nm_>=cutoffOD450) = 1;

writetable(igGRSV,'../0. data/Hong_Kong_serology_CC/250813CC RSV-F IgG data cutoff.xlsx');
function [data, auxData, metaData, txtData, weights] = mydata_Placopecten_magellanicus

%% set metaData
metaData.phylum     = 'Mollusca';
metaData.class      = 'Bivalvia';
metaData.order      = 'Pectinida';
metaData.family     = 'Pectinidae';
metaData.species    = 'Placopecten_magellanicus';
metaData.species_en = 'Atlantic deep-sea scallop';
metaData.ecoCode.climate = {'MC', 'ME'};
metaData.ecoCode.ecozone = {'MANW'};
metaData.ecoCode.habitat = {'0jMp', 'jiMb'};
metaData.ecoCode.embryo  = {'Mp'};
metaData.ecoCode.migrate = {};
metaData.ecoCode.food    = {'biPp'};
metaData.ecoCode.gender  = {'D'};
metaData.ecoCode.reprod  = {'O'};
metaData.T_typical  = C2K(7);
metaData.data_0     = {'ab'; 'aj'; 'ap'; 'am'; 'Lb'; 'Lj'; 'Lp'; 'Li'; 'Wdb'; 'Wdj'; 'Wdp'; 'Wdi'; 'Ri'};
metaData.data_1     = {'t-L_f'; 'L-W_f'; 'L-N'; 'Wd-JO_f'; 'T-JO'};

metaData.COMPLETE = 3.6;

% Built from Romain's AmP entry 
metaData.author    = {'Romain Lavaud'};
metaData.date_subm = [2018 01 22];
metaData.email     = {'romain.lavaud@dfo-mpo.gc.ca'};
metaData.address   = {'Fisheries and Ocean Canada, Moncton, Canada'};

% My info
% metaData.author    = {'Tom Kiffney'};
% metaData.date_subm = [];
% metaData.email     = {'thomas.kiffney@maine.edu'};
% metaData.address   = {'Darling Marine Center, Walpole, U.S.'};


%% Set zero-variate data;
data.ab   = 4;        units.ab      = 'd'; label.ab      = 'age at birth';         bibkey.ab = 'Cull1974';
  temp.ab = C2K(15);  units.temp.ab = 'K'; label.temp.ab = 'temperature';
data.aj   = 35;       units.aj      = 'd'; label.aj      = 'age at metamorphosis'; bibkey.aj = 'Cull1974';
  temp.aj = C2K(15);  units.temp.aj = 'K'; label.temp.aj = 'temperature';
data.ap   = 365;      units.ap      = 'd'; label.ap      = 'age at puberty';       bibkey.ap = {'Naid1970','ParsRobi1992'};
  temp.ap = C2K(12);  units.temp.ap = 'K'; label.temp.ap = 'temperature';
data.am   = 365 * 20; units.am      = 'd'; label.am      = 'life span';            bibkey.am = 'MacDThom1985';
  temp.am = C2K(12);  units.temp.am = 'K'; label.temp.am = 'temperature';

data.Lb = 0.0105; units.Lb = 'cm'; label.Lb = 'shell length at birth';         bibkey.Lb = 'Cull1974';
data.Lj = 0.035;  units.Lj = 'cm'; label.Lj = 'shell length at metamorphosis'; bibkey.Lj = 'Cull1974';
data.Lp = 2.5;    units.Lp = 'cm'; label.Lp = 'shell length at puberty';       bibkey.Lp = {'Naid1970','LangRobi1987','ParsRobi1992'};
data.Li = 23;     units.Li = 'cm'; label.Li = 'ultimate shell length';         bibkey.Li = 'ADW';

data.Wdb = 1.5e-7; units.Wdb = 'g'; label.Wdb = 'dry tissue weight at birth';         bibkey.Wdb = 'guess';
data.Wdj = 1e-6;   units.Wdj = 'g'; label.Wdj = 'dry tissue weight at metamorphosis'; bibkey.Wdj = 'guess';
data.Wdp = 0.5;    units.Wdp = 'g'; label.Wdp = 'dry tissue weight at puberty';       bibkey.Wdp = 'guess';
data.Wdi = 50;     units.Wdi = 'g'; label.Wdi = 'ultimate dry tissue weight';         bibkey.Wdi = 'guess';

data.Ri   = 3e5;    units.Ri      = '#/d'; label.Ri      = 'maximum reprod rate'; bibkey.Ri = {'MacDThom1985','Guess'};
  temp.Ri = C2K(7); units.temp.Ri = 'K';   label.temp.Ri = 'temperature';

%% Set uni-variate data

% Time since birth vs. shell length along a depth gradient in Newfoundland
% 10 m chl = 1.20 (yearly average of chl, higher values during growing season)
data.tL1 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 19; % yrs, time since birth
            47.50 65.37 82.53 97.10 115.91 125.07 134.47 139.87 145.73 150.90 155.12 157.46 158.15 162.60 168.47 168.46 171.25]'; % mm, shell length at f and T
data.tL1(:,1) = 365 * data.tL1(:,1); % convert yrs to days
data.tL1(:,1) = 0.1 * data.tL1(:,1); % convert mm to cm
units.tL1 = {'d', 'cm'}; label.tL1 = {'time since birth', 'shell length'};
temp.tL1 = C2K(5.38); units.temp.tL1 = 'K'; label.temp.tL1 = 'temperature';
comment.tL1 = 'Growth at 10 m in Newfoundland - yearly average temperature'; bibkey.tL1 = 'MacDThom1985';
% 20m chl = 0.91 ug/L
data.tL2 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; % yrs, time since birth
            45.21 62.86 79.57 93.22 108.05 121.94 128.52 133.69 139.09 145.20 148.25 153.42 153.88 154.10 156.67 159.96 158.30 157.57]'; % mm, shell length at f and T
data.tL2(:,1) = 365 * data.tL2(:,1); % convert yrs to days
data.tL2(:,1) = 0.1 * data.tL2(:,1); % convert mm to cm
units.tL2 = {'d', 'cm'}; label.tL2 = {'time since birth', 'shell length'};
temp.tL2 = C2K(3.97); units.temp.tL2 = 'K'; label.temp.tL2 = 'temperature';
comment.tL2 = 'Growth at 20 m in Newfoundland - yearly average temperature'; bibkey.tL2 = 'MacDThom1985';
% 30m chl = 0.82 ug/L
data.tL3 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; % yrs, time since birth
            42.38 59.33 70.86 88.04 97.92 111.57 112.50 120.73 130.14 132.72 134.35 138.34 140.21 142.55 144.66 148.41 149.11 150.03]'; % mm, shell length at f and T
data.tL3(:,1) = 365 * data.tL3(:,1); % convert yrs to days
data.tL3(:,1) = 0.1 * data.tL3(:,1); % convert mm to cm
units.tL3 = {'d', 'cm'}; label.tL3 = {'time since birth', 'shell length'};
temp.tL3 = C2K(2.78); units.temp.tL3 = 'K'; label.temp.tL3 = 'temperature';
comment.tL3 = 'Growth at 30 m in Newfoundland - yearly average temperature'; bibkey.tL3 = 'MacDThom1985';

% 10m, chl = 1.20
data.tWw1 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; % yrs,  time since birth
             0.86 2.42 4.72 7.84 11.70 13.25 20.08 21.63 23.69 26.40 28.46 26.26 29.07 29.87 30.38 30.23 26.27 33.39]'; % g, wet weight];
data.tWw1(:,1) = 365 * data.tWw1(:,1); % convert yrs to days
units.tWw1 = {'d', 'g'}; label.tWw1 = {'time', 'body weight'};  
temp.tWw1 = C2K(5.38);  units.temp.tWw1 = 'K'; label.temp.tWw1 = 'temperature';
bibkey.tWw1 = 'MacDThom1985'; comment.tWw1 = 'Weights from tL1';
% 20m, chl = 0.91
data.tWw2 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; % yrs,  time since birth
             0.86 1.91 4.17 6.53 9.14 13.26 15.76 17.42 19.93 21.84 23.65 25.05 25.46 23.66 24.41 24.61 23.72 24.17]'; % g, wet weight];
data.tWw2(:,1) = 365 * data.tWw2(:,1); % convert yrs to days
units.tWw2 = {'d', 'g'}; label.tWw2 = {'time', 'body weight'};  
temp.tWw2 = C2K(3.97);  units.temp.tWw2 = 'K'; label.temp.tWw2 = 'temperature';
bibkey.tWw2 = 'MacDThom1985'; comment.tWw2 = 'Weights from tL2';
% 30m, chl = 0.82
data.tWw3 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; % yrs,  time since birth
             0.51 1.91 2.57 4.88 6.18 9.60 10.30 12.31 14.72 16.13 15.33 16.93 16.94 16.84 18.15 17.60 17.55 16.95]'; % g, wet weight];
data.tWw3(:,1) = 365 * data.tWw3(:,1); % convert yrs to days
units.tWw3 = {'d', 'g'}; label.tWw3 = {'time', 'body weight'};  
temp.tWw3 = C2K(2.78);  units.temp.tWw3 = 'K'; label.temp.tWw2 = 'temperature';
bibkey.tWw3 = 'MacDThom1985'; comment.tWw3 = 'Weights from tL3';

% Data above is for univariate data wild scallop tissue/shell growth
% Data below is growth data for cultured scallops 

% Shell length vs. tissue dry weight taken from two size classes of...
% scallops growth at 20% denisty in the Damariscottta River Esturary,
% average yearly chl = 3-4 ug/L
data.LW = [41 38 41 44	38 45 42 44 45 40 42 39 36 43 38 62 66 64 69 62	67 59 66 70	67 68 62 68 72 62 32 35 33 31 33 28 35 33 31 32 32 33 33 35 30 63 62 61 60 63 61 64 63 64 50 60 60 60 64 58 41 39 42 39 38 41 38 40 38 38 33 40 38 38 36 70 63 68 65 58 57 64 66 64 70 62 62 62 64 60 41 40 34 35 40 34 40 36 39 40 39 40 40 40 39 58 73 60 61 62 59 63 66 64 68 58 62 60 55 60 45 43 50 48 45 39 44 42 46 42 42 39 39 44 44 66 62 62 69 64 63 61 70 71 70 66 74 67 71 75 47 42 46 43 44 46 44 49 45 41 49 47 52 43 47 66 66 66 71 61 73 63 66 73 63 72 72 65 72 72 48 51 51 54 47 53 46 56 46 55 56 47 47 44 46 67 70 72 75 61 71 74 74 70 74 62 76 75 76 25 23 21 23 27 22 23 22 26 24 21 20 20 17 16 52 49 53 45 57 53 51 42 49 47 45 46 45 52 37 35 30 25 33 27 26 37 35 33 30 34 32 34 29 33 57 55 55 52 53 55 52 51 57 55 51 56 55 47 54; % cm, shell length
            3.358 3.165 4.516 4.343 3.013 5.139 4.072 4.784 4.985 3.348 3.335 3.555 2.943 4.35 3.584 18.14 18.664 15.083 17.405 14.813 18.616 11.783 15.891 19.634 17.323 20.681 14.111 17.5 23.2 16.22 1.767 2.129 2.177 1.996 2.184 1.097 2.257 2.004 1.912 1.872 1.833 2.411 2.309 2.437 1.498 14.094 14.59 13.549 12.834 15.486 13.299 13.453 15.114 14.453 7.021 10.482 13.016 7.933 14.764 11.578 5.79 3.7 4.03 2.946 2.875 3.564 2.986 4.026 3.12 2.645 2.089 4.323 3.643 3.25 2.736 17.799 12.443 16.014 12.614 11.337 11.243 13.22 16.821 13.058 17.744 14.797 13.263 13.34 12.732 13.087 4.083 2.799 2.347 2.386 3.104 2.507 2.499 2.5 2.859 3.329 3.362 3.692 3.32 3.126 4.69 13.73 23.265 13.681 14.094 16.501 13.845 16.291 17.296 14.614 21.747 9.312 14.505 15.178 12.015 11.949 4.863 4.166 7.079 5.575 4.844 4.552 4.649 4.295 4.917 4.144 4.116 3.682 3.858 4.737 5.718 16.748 15.929 15.625 19.487 15.945 14.82 14.414 18.382 22.013 19.462 15.871 24.239 18.407 24.601 28.565 7.255 4.578 5.853 4.955 4.732 5.148 5.861 6.915 5.801 6.584 6.59 6.053 8.347 5.631 6.058 22.013 19.735 18.404 24.893 18.871 25.583 15.869 19.018 26.692 20.673 24.639 25.089 20.841 20.721 25.018 6.611 8.353 6.435 10.281 6.856 9.352 5.758 9.405 5.298 10.446 10.137 5.605 6.012 4.836 5.973 22.732 20.866 24.404 27.238 21.616 24.815 25.586 27.714 22.458 26.275 7.593 25.806 30.625 28.902 0.731 0.554 0.505 0.595 0.938 0.424 0.529 0.467 0.823 0.684 0.494 0.325 0.359 0.233 0.153 6.641 6.47 8.648 5.624 11.1 9.133 8.032 6.459 6.756 6.089 5.222 6.145 5.383 8.003 3.206 1.1753 0.636 0.804 1.05 1.093 0.906 0.847 2.1 1.302 1.182 1.865 1.414 2.405 1.528 1.794 9.888 11.169 10.099 9.334 9.877 8.913 9.246 7.365 9.947 9.006 7.849 11.568 10.796 6.393 9.018]'; % g, tissue dry weight
data.LW(:,1) = 0.1 * data.tL2(:,1); % convert mm to cm
units.LW = {'cm', 'g'}; label.LW = {'shell length', 'tissue wet weight'}; bibkey.LW = 'Kiff2021';
temp.LW = C2K(10); units.temp.LW = 'K'; label.temp.LWd = 'temperature';
% needs temp + chl

% Year long growth strudy conducted in the Damarriscotta river. 
% I can estimate the age of the scallops based off the timing of spat...
% collection in the area, but have left it as time since the start of the...
% experiment for now. Average yearly chl = 3 ug/L
data.tL_dmc = [0 0 0 0 84 84 84 84 180 180 180 180 413 413 413 413; % days since start of experiment
               10.55 10.55 10.55 10.55 24 24 24 24 41.84 40.91 41.84 40.91 62.11 64.41 63.72 61.37]';  % cm, shell length at f and T
units.tL_dmc   = {'d', 'cm'};  label.tL_dmc = {'time since May 30th 2019', 'shell length'};  bibkey.tL_dmc = 'Mors2020';
temp.tL_dmc    = C2K(10.42);  units.temp.tL_dmc = 'K'; label.temp.tL_dmc = 'temperature';
comment.tL_dmc = 'Temperature varies: 10.42 + 8.19 * sin(2*pi*(DayOfYear + 233)/365'; 

% Shell height growth rate in mm/day for all published net culture sea scallop studies coupled
% with OISST daily satellite data, unsure if this can be used in estimating
% T_A, T_H, T_L, T_AL, and T_AH since I have not seen it in the AmP
% collection or on the DEB wiki. I have attemped to fit the full arrhenius
% temperature equation to the data, but a lack of data above 17 degrees
% means I cannon use 20 deg as the reference temperate. The dataset is
% missing data at the upper thermal limit so it may be limited in use until
% I can fill it in

data.GrowthRate = [11.46 4.36 9.23 9.77 4.30 11.46 4.36 9.23 9.77 4.30 13.35 13.35 13.35 13.35 13.35 13.35 13.35 13.22 13.22 13.22 13.22 13.22 13.22 0.86 0.86 0.86 0.86 0.86 0.86 0.86 0.86 0.86 9.12 9.12 9.12 9.12 9.12 9.12 9.12 9.12 9.12 15.93 15.93 15.93 15.93 15.93 15.93 15.93 15.93 15.93 8.03 8.03 8.03 8.03 8.03 8.03 8.03 8.03 8.03 8.03 8.03 8.03 14.72 14.57 11.16 7.51 14.81 13.49 10.76 6.65 12.19 10.27 6.32 15.01 11.97 10.08 6.32 8.43 8.43 8.43 8.43 2.78 2.78 2.78 2.78 1.49 1.49 1.49 1.49 7.60 7.60 3.13 11.99 14.22 15.24 13.70 11.69 3.74 1.31 3.37 7.97 12.09 14.23 15.31 13.71 11.65 7.73 2.36 1.25 3.23 7.74 11.92 14.21 15.32 13.81 11.75 7.87 2.47 8.63 8.63 8.63 8.63 8.63 8.63 3.05 3.05 3.05 3.05 3.05 3.05 10.06 10.06 10.06 10.06 10.06 10.06 4.52 4.52 4.52 4.52 4.52 4.52 11.75 11.75 11.75 11.75 7.95 7.95 7.95 7.95 3.19 3.19 3.19 3.19 2.36 2.36 2.36 2.36 2.36 2.36 2.36 2.36 2.36 2.36 5.71 5.71 5.71 5.71 5.71 5.71 5.71 5.71 5.71 5.71 7.39 6.43 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 5.50 1.37 1.37 1.37 1.37 1.37 7.04 7.04 7.04 7.04 7.04 3.09 3.09 3.09 3.09 3.09 4.00 4.00 4.00 4.00 4.00 5.21 5.21 3.47 3.47 4.19 4.19 9.54 9.54 14.05 14.05 15.84 15.84 14.70 14.70 3.76 3.76 8.25 8.25 9.86 9.86 12.78 12.78 15.64 15.64 15.07 15.07 11.97 11.97 4.22 4.22 4.59 4.59 7.69 7.69 10.67 10.67 14.43 14.43 17.09 17.09 14.10 14.10 16.29 7.36 8.11 13.16 7.49 13.16 7.49 13.16 7.49 13.16 7.49 7.49 7.49 7.49 7.49 11.04 6.52 11.04 6.52 13.64 11.04 6.52 13.64 11.04 6.52 14.87 12.78 6.24 6.50 14.87 12.78 6.24 6.50 15.15 12.78 6.24 6.50 14.87 12.78 6.37 6.37 14.87 12.78 6.37 6.37 14.87 12.78 6.37 6.37; % temp in C
                   0.233	0.050	0.088	0.108	0.002	0.196	0.048	0.103	0.101	0.000	0.220	0.180	0.170	0.130	0.120	0.100	0.100	0.196	0.180	0.154	0.159	0.166	0.144	0.046	0.046	0.036	0.050	0.001	0.037	0.048	0.048	0.040	0.163	0.114	0.081	0.161	0.171	0.080	0.129	0.112	0.063	0.101	0.087	0.071	0.112	0.087	0.085	0.136	0.075	0.082	0.220	0.091	0.109	0.043	0.116	0.097	0.099	0.050	0.120	0.151	0.071	0.047	0.320	0.140	0.060	0.120	0.220	0.300	0.150	0.120	0.290	0.100	0.150	0.250	0.180	0.140	0.060	0.025	0.019	0.050	0.041	0.025	0.020	0.050	0.041	0.018	0.010	0.063	0.031	0.052	0.043	0.052	0.104	0.221	0.123	0.153	0.104	0.047	0.008	0.035	0.162	0.212	0.131	0.188	0.135	0.063	0.029	0.042	0.010	0.014	0.072	0.134	0.172	0.152	0.102	0.103	0.028	0.029	0.158	0.154	0.148	0.141	0.140	0.115	0.054	0.044	0.050	0.051	0.042	0.055	0.100	0.084	0.060	0.047	0.051	0.070	0.084	0.074	0.072	0.085	0.097	0.059	0.228	0.250	0.220	0.210	0.118	0.086	0.127	0.098	0.000	0.024	0.042	0.039	0.057	0.047	0.059	0.038	0.033	0.043	0.040	0.025	0.032	0.024	0.073	0.060	0.065	0.064	0.050	0.055	0.055	0.048	0.039	0.029	0.064	0.079	0.101	0.099	0.096	0.084	0.078	0.067	0.055	0.046	0.039	0.033	0.043	0.041	0.036	0.019	0.028	0.024	0.020	0.036	0.049	0.049	0.046	0.038	0.029	0.160	0.137	0.103	0.103	0.091	0.042	0.043	0.032	0.019	0.018	0.039	0.041	0.028	0.033	0.026	0.028	0.000	0.010	0.029	0.107	0.084	0.108	0.098	0.133	0.086	0.063	0.073	0.057	0.000	0.029	0.043	0.202	0.079	0.165	0.032	0.086	0.121	0.175	0.110	0.154	0.158	0.046	0.053	0.000	0.027	0.038	0.048	0.108	0.000	0.087	0.067	0.211	0.144	0.103	0.134	0.101	0.161	0.141	0.096	0.075	0.193	0.099	0.159	0.077	0.195	0.113	0.177	0.075	0.099	0.075	0.115	0.087	0.127	0.065	0.128	0.091	0.099	0.142	0.058	0.133	0.100	0.086	0.113	0.172	0.023	0.129	0.000	0.136	0.041	0.063	0.005	0.127	0.030	0.062	0.126	0.236	0.090	0.109	0.108	0.237	0.096	0.088	0.084	0.201	0.103	0.091]';  % shell growth rate mm/day
units.GrowthRate   = {'C', 'mm/day'};  label.GrowthRate = {'temperature', 'shell growth rate mm/day'};  bibkey.GrowthRate = 'ColeKiff2021';
comment.tL_dmc = 'Average shell height of the scallops = 49mm';
%temp.tL_dmc    = C2K(10.42);  units.temp.tL_dmc = 'K'; label.temp.tL_dmc = 'temperature';

%% Romain's Univariate data (fecundity, oxygen consumption)

 % Length vs. fecundity
data.LN = [0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0 10.5 11.0 11.5 12.0 12.5 13.0 13.5 14.0 14.5 15.0 15.5 16.0; % cm, shell length
           0 2.5 4.5 6.5 8.25 10.75 13.5 17.25 21.75 27.25 34.25 42.5 52.25 63.5 76.44 91.24 108.4 127.24 148.72 172.72 199.76 229.76 263.24 300.76 342.76]'; % #, millions of eggs per individual
data.LN(:,2) = 1e6 * data.LN(:,2); % #, convert to millions
units.LN = {'cm', '#'}; label.LN = {'shell length', 'fecundity'}; bibkey.LN = 'McGaSerc1992';
temp.LN = C2K(7); units.temp.LN = 'K'; label.temp.LN = 'temperature';

 % Dry weight vs. oxygen consumption rate
data.WJO = [4.26 4.44 4.53 4.74 4.87 4.88 4.93 4.97 5.18 5.2 5.48 5.6 6.88 7.1 7.8 8.48 8.91 9.02; % g, dry weight
            0.63 0.64 0.69 0.47 0.5 0.26 0.24 0.59 0.63 0.41 0.59 0.72 0.96 0.91 1.33 1.41 1.25 1.37]'; % mgO2/h, oxygen consumption rate
units.WJO = {'g', 'mg/h'}; label.WJO = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO = 'GranCran1991';
temp.WJO = C2K(6); units.temp.WJO = 'K'; label.temp.WJO = 'temperature';

 % Dry weight vs. oxygen consumption rate at different temperatures
data.WJO1 = [0.01 0.05 0.1 0.5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; % g, dry weight
             0.0021 0.0071 0.0120 0.0407 0.0690 0.1169 0.1592 0.1982 0.2348 0.2698 0.3034 0.3358 0.3673 0.3980 0.4279 0.4572 0.4859 0.5141 0.5418 0.5691 0.5960 0.6225]'; % mLO2/h, oxygen consumption rate
units.WJO1 = {'g', 'mL/h'}; label.WJO1 = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO1 = 'ShumBart1988';
temp.WJO1 = C2K(1); units.temp.WJO1 = 'K'; label.temp.WJO1 = 'temperature';

data.WJO3 = [0.01 0.05 0.1 0.5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; % g, dry weight
             0.0054 0.0177 0.0295 0.0970 0.1620 0.2706 0.3652 0.4519 0.5330 0.6100 0.6837 0.7547 0.8235 0.8903 0.9553 1.0188 1.0810 1.1420 1.2018 1.2606 1.3184 1.3754]'; % mLO2/h, oxygen consumption rate
units.WJO3 = {'g', 'mL/h'}; label.WJO3 = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO3 = 'ShumBart1988';
temp.WJO3 = C2K(3); units.temp.WJO3 = 'K'; label.temp.WJO3 = 'temperature';

data.WJO6 = [0.01 0.05 0.1 0.5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; % g, dry weight
             0.0082 0.0259 0.0425 0.1341 0.2200 0.3609 0.4820 0.5920 0.6942 0.7907 0.8827 0.9710 1.0562 1.1387 1.2189 1.2971 1.3733 1.4480 1.5211 1.5928 1.6633 1.7326]'; % mLO2/h, oxygen consumption rate
units.WJO6 = {'g', 'mL/h'}; label.WJO6 = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO6 = 'ShumBart1988';
temp.WJO6 = C2K(6); units.temp.WJO6 = 'K'; label.temp.WJO6 = 'temperature';

data.WJO8 = [0.01 0.05 0.1 0.5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; % g, dry weight
             0.0052 0.0204 0.0368 0.1439 0.2590 0.4662 0.6575 0.8392 1.0140 1.1835 1.3488 1.5105 1.6692 1.8252 1.9788 2.1303 2.2799 2.4278 2.5741 2.7189 2.8623 3.0045]'; % mLO2/h, oxygen consumption rate
units.WJO8 = {'g', 'mL/h'}; label.WJO8 = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO8 = 'ShumBart1988';
temp.WJO8 = C2K(8); units.temp.WJO8 = 'K'; label.temp.WJO8 = 'temperature';

data.WJO10 = [0.01 0.05 0.1 0.5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; % g, dry weight
              0.0077 0.0295 0.0527 0.2031 0.3630 0.6489 0.9115 1.1599 1.3984 1.6293 1.8540 2.0735 2.2886 2.4998 2.7077 2.9125 3.1145 3.3141 3.5113 3.7065 3.8996 4.0910]'; % mLO2/h, oxygen consumption rate
units.WJO10 = {'g', 'mL/h'}; label.WJO10 = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO10 = 'ShumBart1988';
temp.WJO10 = C2K(10); units.temp.WJO10 = 'K'; label.temp.WJO10 = 'temperature';

data.WJO19 = [0.01 0.05 0.1 0.5 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18; % g, dry weight
              0.0085 0.0325 0.0581 0.2234 0.3990 0.7127 1.0007 1.2732 1.5347 1.7877 2.0339 2.2744 2.5100 2.7414 2.9691 3.1934 3.4146 3.6331 3.8491 4.0628 4.2742 4.4837]'; % mLO2/h, oxygen consumption rate
units.WJO19 = {'g', 'mL/h'}; label.WJO19 = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO19 = 'ShumBart1988';
temp.WJO19 = C2K(19); units.temp.WJO19 = 'K'; label.temp.WJO19 = 'temperature';

 % Temperature vs. oxygen consumption rate
data.TJO = [-0.5 0.1 1.6 2.5 4.0 8.1 12.2; % °C, temperature
            0.0719 0.0676 0.0657 0.1159 0.1395 0.1720 0.1679]'; % mLO2/h, oxygen consumption rate
units.TJO = {'°C', 'mL/h'}; label.TJO = {'temperature', 'O_2 consumption rate'}; bibkey.TJO = 'MacDThom1986';

%% Set weights for all real data
weights = setweights(data, []);


%% Set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);

%% Pack auxData and txtData for output
auxData.temp    = temp;
txtData.units   = units;
txtData.label   = label;
txtData.bibkey  = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tL1','tL2', 'tL3'}; comment1 = {'10, 20, 30 m deep'};
set2 = {'tWw1','tWw2', 'tWw3'}; comment2 = {'10, 20, 30 m deep'};
set3 = {'WJO19','WJO10','WJO8','WJO6','WJO3','WJO1'}; comment3 = {'19, 10, 8, 6, 3, 1 °C'};
metaData.grp.sets    = {set1,set2, set3};
metaData.grp.comment = {comment1,comment2, comment3};

%% Links
metaData.links.id_CoL = '60267b9440fb093260b9eec16c18c54f'; % Cat of Life
metaData.links.id_EoL = '448745'; % Ency of Life
metaData.links.id_Wiki = 'Placopecten_magellanicus'; % Wikipedia
metaData.links.id_Taxo = '39370'; % Taxonomicon
metaData.links.id_WoRMS = '156972'; % WoRMS
metaData.links.id_molluscabase = '156972'; % MolluscaBase

%% Discussion points

%% References
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{../../../bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ADW'; type = 'Misc'; bib = [...
'howpublished = {\url{http://animaldiversity.org/accounts/Placopecten_magellanicus/}},'...
'note = {Accessed : 2018-01-08}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Wiki'; type = 'Misc'; bib = [...
'howpublished = {\url{http://en.wikipedia.org/wiki/Placopecten_magellanicus}},'...
'note = {Accessed : 2015-04-30}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Guess'; type = 'Misc'; bib = [...
'note = {Guestimation}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Cull1974'; type = 'Article'; bib = [ ...
'author = {Culliney, J. L.}, ' ...
'year = {1974}, ' ...
'title = {Larval development of the giant scallop \emph{Placopecten magellanicus}}, ' ...
'journal = {Biol. Bull.}, ' ...
'volume = {147}, ' ...
'pages = {321-332}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'GranCran1991'; type = 'Article'; bib = [ ...
'author = {Grant, J. and Cranford, P. J.}, ' ...
'year = {1991}, ' ...
'title = {Carbon and nitrogen scope for growth as a function of diet in the sea scallop \emph{Placopecten magellanicus}}, ' ...
'journal = {J. mar. biol. Ass. U.K}, ' ...
'volume = {71}, ' ...
'pages = {437-450}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'LangRobi1987'; type = 'Article'; bib = [ ...
'author = {Langton, R. W. and Robinson, W. E. and Schick, D.}, ' ...
'year = {1987}, ' ...
'title = {Fecundity and reproductive effort of sea scallop \emph{Placopecten magellanicus} from the {G}ulf of {M}aine}, ' ...
'journal = {Mar. Ecol. Prog. Ser.}, ' ...
'volume = {37}, ' ...
'pages = {19-25}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'MacDThom1985'; type = 'Article'; bib = [ ...
'author = {MacDonald, B. A. and Thompson, R. J.}, ' ...
'year = {1985}, ' ...
'title = {Influence of temperature and food availability on the ecological energetics of the giant scallop \emph{Placopecten magellanicus}. II. {R}eproductive output and total production}, ' ...
'journal = {Mar. Ecol. Prog. Ser.}, ' ...
'volume = {25}, ' ...
'pages = {295-303}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'MacDThom1986'; type = 'Article'; bib = [ ...
'author = {MacDonald, B. A. and Thompson, R. J.}, ' ...
'year = {1986}, ' ...
'title = {Influence of temperature and food availability on the ecological energetics of the giant scallop \emph{Placopecten magellanicus}. III. {P}hysiological ecology, the gametogenic cycle and scope for growth}, ' ...
'journal = {Mar. Biol.}, ' ...
'volume = {93}, ' ...
'pages = {37-48}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'MacDThom1988'; type = 'Article'; bib = [ ...
'author = {MacDonald, B. A. and Thompson, R. J.}, ' ...
'year = {1988}, ' ...
'title = {Intraspecific variation in growth and reproduction in latitudinally differentiated populations of the giant scallop \emph{Placopecten magellanicus} ({G}melin)}, ' ...
'journal = {Biol. Bull.}, ' ...
'volume = {175}, ' ...
'pages = {361-371}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'McGaSerc1992'; type = 'Article'; bib = [ ...
'author = {McGarvey, R. and Serchuk, F. M. and McLaren, I. A.}, ' ...
'year = {1992}, ' ...
'title = {Statistics of reproduction and early life history survival of the {G}eorges {B}ank sea scallop \emph{Placopecten magellanicus} population}, ' ...
'journal = {J. Northwest Atl. Fish. Sci.}, ' ...
'volume = {13}, ' ...
'pages = {83-99}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Naid1970'; type = 'Article'; bib = [ ...
'author = {Naidu, K. S.}, ' ...
'year = {1970}, ' ...
'title = {Reproduction and breeding cycle of the giant scallop \emph{Placopecten magellanicus} ({B}ivalvia: {P}ectinidae) in {P}ort au {P}ort {B}ay, {N}ewfoundland}, ' ...
'journal = {Can. J. Zool.}, ' ...
'volume = {48}, ' ...
'pages = {1003-1012}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ParsRobi1992'; type = 'Article'; bib = [ ...
'author = {Parsons, G. J. and Robinson, S. M. C. and Chandler, R. A. and Davidson, L. A. and Lanteigne, M. and Dadswell, M. J.}, ' ...
'year = {1992}, ' ...
'title = {Intra-annual and long-term patterns in the reproductive cycle of giant scallops \emph{Placopecten magellanicus} ({B}ivalvia: {P}ectinidae) from {P}assamaquoddy {B}ay, {N}ew {B}runswick, {C}anada}, ' ...
'journal = {Mar. Ecol. Prog. Ser.}, ' ...
'volume = {80}, ' ...
'pages = {203-214}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'RoddLund1994'; type = 'Article'; bib = [ ...
'author = {Roddick, D. L. and Lundy, M. J. and Kenchington, E.}, ' ...
'year = {1992}, ' ...
'title = {Yield per recruit analysis and minimum meat weight recommendations for the {B}ay of {F}undy scallop fishery}, ' ...
'journal = {DFO Atlantic Fisheries report}, ' ...
'volume = {58}, ' ...
'pages = {15}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ShumBart1988'; type = 'Article'; bib = [ ...
'author = {Shumway, S. E. and Barter, J. and Stahlnecker, J.}, ' ...
'year = {1988}, ' ...
'title = {Seasonal changes in oxygen consumption of the giant scallop, \emph{Placopecten magellanicus} ({G}melin)}, ' ...
'journal = {J. Shellfish Reas.}, ' ...
'volume = {7}, ' ...
'number = {1}, ' ...
'pages = {77-82}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];


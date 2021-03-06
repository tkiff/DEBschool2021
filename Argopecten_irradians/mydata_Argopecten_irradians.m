%% mydata_Argopecten_irradians
% Sets referenced data

%%
function [data, auxData, metaData, txtData, weights] = mydata_Argopecten_irradians
  % created by Starrlight Augustine, Bas Kooijman, Dina Lika, Goncalo Marques and Laure Pecquerie 2015/03/31
  % last modified: 2015/07/28 
  
  %% Syntax
  % [data, auxData, metaData, txtData, weights] = <../mydata_my_pet.m *mydata_my_pet*>
  
  %% Description

  
%% set metaData

metaData.phylum     = 'Mollusca'; 
metaData.class      = 'Bivalvia'; 
metaData.order      = 'Pectinida'; 
metaData.family     = 'Pectinidae';
metaData.species    = 'Argopecten_irradians'; % 
metaData.species_en = 'Bay Scallop'; 
metaData.ecoCode.climate = {'MB', 'MB','MC'};
metaData.ecoCode.ecozone = {'MAW', 'MASW','MAg'};
metaData.ecoCode.habitat = {'Mcd'};
metaData.ecoCode.embryo  = {'Mp'};
metaData.ecoCode.migrate = {};
metaData.ecoCode.food    = {'biPp'};
metaData.ecoCode.gender  = {'Hh'};
metaData.ecoCode.reprod  = {'O'}; % Os? can live to second repo event but not often
metaData.T_typical  = C2K(20); % K, body temp
metaData.data_0     = {'ab'; 'ap'; 'am'; 'Lb'; 'Lp'; 'Li'; 'Wdb'; 'Wdp'; 'Wdi'; 'Ri'};  % tags for different types of zero-variate data
metaData.data_1     = {'t-L'; 'L-W'}; % tags for different types of uni-variate data
metaData.data_1     = {'t-L_f'; 'L-W'; 'Wd-JO'; 'T-JO'};

metaData.COMPLETE = 2.5; % using criteria of LikaKear2011
% not set yet

metaData.author   = {'Thomas Kiffney'};                                            % put names as authors as separate strings:  {'FirstName1 LastName2','FirstName2 LastName2'} , with corresponding author in first place 
metaData.date_subm = [2021 05 15];                                                 % [year month day], date at which the entry is submitted
metaData.email    = {'thomas.kiffney@maine.edu'};                                  % e-mail of corresponding author
metaData.address  = {'University of Maine Darling Marine Center, 04573, U.S.A'};   % affiliation, postcode, country of the corresponding author

% uncomment and fill in the following fields when the entry is updated:
% metaData.author_mod_1  = {'FirstName3 LastName3'};          % put names as authors as separate strings:  {'author1','author2'} , with corresponding author in first place 
% metaData.date_mod_1    = [2017 09 18];                      % [year month day], date modified entry is accepted into the collection
% metaData.email_mod_1   = {'myname@myuniv.univ'};            % e-mail of corresponding author
% metaData.address_mod_1 = {'affiliation, zipcode, country'}; % affiliation, postcode, country of the corresponding author

% for curators only ------------------------------
% metaData.curator     = {'FirstName LastName'};
% metaData.email_cur   = {'myname@myuniv.univ'}; 
% metaData.date_acc    = [2015 04 22]; 
%-------------------------------------------------

%% Set Zero-variate data

data.ab   = 1;           units.ab      = 'd'; label.ab      = 'age at birth';         bibkey.ab = 'CastDugg1971';
  temp.ab = C2K(24);      units.temp.ab = 'K'; label.temp.ab = 'temperature';
  % When feeding begains, other bivalve entrys use the D-hinge stage
  % CastDugg1971 - ranged from 18-28 hours with temps from 20-28C
  % older studies report longer times
        % Gutsell 1930, 42 hours @ 25 C
        % Sastry 1965 48 @ 24 C
        % Zheng et al 30 hrs @ 23 deg. C
        % Use average?
data.aj   = 12.2;           units.aj      = 'd'; label.aj      = 'age at metamorphosis'; bibkey.aj = {'LoosDavi1963','Sast1965','CastDugg1971'};
  temp.aj = C2K(23.2);      units.temp.aj = 'K'; label.temp.aj = 'temperature';
  % Loosanoff and Davis 1963, 14 days @ 20-23 C
  % Sastry 1965, 12-13 days @ 24 C
  % Castagna and Duggan 1971, 10 days @ 24 C
  % use average
data.ap   = 365;           units.ap      = 'd'; label.ap      = 'age at puberty';       bibkey.ap = 'Beld1910';
  temp.ap = C2K(12);      units.temp.ap = 'K'; label.temp.ap = 'temperature';
  % Belding et al sexual maturity data from Massachusets
  % average annual ocean temperature from Woods Hole and Boston = 12 C
  % possibly earlier sexual maturity in warmer areas
        % Gutsel 1930, 12 to 18 months pivers island, NC
data.am   = 790;           units.am      = 'd'; label.am      = 'life span';            bibkey.am = 'Beld1910';
  temp.am = C2K(12);      units.temp.am = 'K'; label.temp.am = 'temperature';
  % average lifespan in Mass 20-26 months
  % Shorter in warmer areas sometimes do not live past first spawn at 1 year

data.Lb = 0.0081;      units.Lb = 'cm'; label.Lb = 'shell length at birth';         bibkey.Lb = {'LoosDavi1963','Sast1965','ChanAndr1971'};
    % Prodissoconch I shell length
        % Loosanoff and Davis 1963, 80 um
        % Sastry 1965, 78 um
        % Chanley and Andrews, 85 um
        % use average
data.Lj = 0.0180;      units.Lj = 'cm'; label.Lj = 'shell length at metamorphosis'; bibkey.Lj = {'LoosDavi1963','Sast1965','ChanAndr1971'};
    % Prodissoconch II shell length
        % Loosanoff and Davis 1963, 175 um
        % Sastry 1965, 190 um
        % Chanley and Andrews, 175 um
        % use average
data.Lp = 5.5;      units.Lp = 'cm'; label.Lp = 'shell length at puberty';       bibkey.Lp = 'Guts1930';
    % 55 - 60 mm at age of maturity, data seemed a little lacking, based on...
    % harvest data
data.Li = 9;      units.Li = 'cm'; label.Li = 'ultimate shell length';         bibkey.Li = 'Beld1910';
    % Data from massachuessets

data.Wdb = 8.39e-7;     units.Wdb = 'g'; label.Wdb = 'dry tissue weight at birth';         bibkey.Wdb = {'Guess','FariUria1997'};
    % estimated with allometric realationship of larvae from Argopecten purpuratus AmP entry
    % has a later age at birth (4 d)
data.Wdj = 4.86e-6;     units.Wdj = 'g'; label.Wdj = 'dry tissue weight at metamorphosis'; bibkey.Wdj = {'Guess','FariUria1997'};
    % estimated with allometric realationship of larvae from Argopecten purpuratus AmP entry
    % has a later age at metamorphis (24 days)
data.Wdp = 1.6;     units.Wdp = 'g'; label.Wdp = 'dry tissue weight at puberty';       bibkey.Wdp = {'Guess','BricKrau1992'};
data.Wdi = 5.3;     units.Wdi = 'g'; label.Wdi = 'ultimate dry tissue weight';         bibkey.Wdi = {'Guess','BricKrau1992'};

data.Ri1  = 78e4/365; units.Ri1  = '#/d'; label.Ri1  = 'maximum reprod rate at SL 5.15 cm';     bibkey.Ri1  = 'Zhen2006';   
  temp.Ri1 = C2K(18); units.temp.Ri1 = 'K'; label.temp.Ri1 = 'temperature';
data.Ri2  = 161.1e4/365; units.Ri2  = '#/d'; label.Ri2  = 'maximum reprod rate at SL 5.49 cm';     bibkey.Ri2  = 'Zhen2006';   
  temp.Ri2 = C2K(18); units.temp.Ri2 = 'K'; label.temp.Ri2 = 'temperature';
  
data.GSI  = 0.2; units.GSI  = '-';  label.GSI  = 'gonado somatic index';        bibkey.GSI  = 'guess';   
  temp.GSI = C2K(25);  units.temp.GSI = 'K'; label.temp.GSI = 'temperature';
  comment.GSI = 'GSI = 0.33 for E. arcuatus';

  
% data.Ww0 = 1.28e-7 ; units.Ww0 = 'g';    label.Ww0 = 'wet weight of the egg';             bibkey.Ww0 = 'Peck2016';
%    comment.Ww0 = 'based on egg diameter of 62.5 mum: pi/6*0.00625^3';

%% uni-variate data

% Time since start of study data from aquaculture trials in Finney Creek near VIMS,
% in Virginia, temperature was measured
data.tL1 = [1 1 1 13 14 15 15 29 29 29 29 47 47 47 47 62 62 63 64 73 74 75 75 91 91 91 92 106 106 106 107 121 122 122 122;    % d, time since birth
            14.40 14.40 14.40 18.31 18.87 17.86 18.19 25.30 25.63 25.63 24.74 33.37 34.37 34.03 32.48 39.70 39.59 38.25 37.12 41.49 41.82 40.37 40.92 44.12 45.35 43.79 42.45 45.78 46.89 44.78 43.21 44.88 42.87 44.87 47.42]';  % mm, shell height
data.tL1(:,2) = 0.1 * data.tL1(:,2); % convert mm to cm
units.tL1   = {'d', 'cm'};  label.tL1 = {'time since start of study', 'Shell height'};  bibkey.tL1 = 'Dugg1973';
temp.tL1    = C2K(25);  units.temp.tL1 = 'K'; label.temp.tL1 = 'temperature';
comment.tL1 = 'Animals were spawned in late summer 1970, but overwintered until start of study'; 

% Time since birth in Connecticut
% temperature estimated from recent yearly averages
data.tL2 = [1 27 114 243 286 342 443 616;    % d, time since collection
            1.04 2.65 4.54 4.70 4.99 5.19 6.11 6.46]';  % mm, shell height
units.tL2   = {'d', 'cm'};  label.tL2 = {'Time since start of study', 'Shell height'};  bibkey.tL2 = 'BricKrau1992';
temp.tL2    = C2K(12);  units.temp.tL2 = 'K'; label.temp.tL2 = 'temperature';
comment.tL2 = 'Scallops were collected from the wild, age was recorded but not reported'; 
% times since settlement (yr), somatic wet weight (g)
data.tWd = [1 27 114 243 286 342 443 616;
           0.01 0.25 1.01 1.01 1.56 1.21 3.20 2.95]';    
units.tWd = {'d', 'g'}; label.tWd = {'Time since start of study', 'shell-free wet weight'};
temp.tWd = C2K(12); units.temp.tWd = 'K'; label.temp.tWd = 'temperature';
comment.tWd = ''; 
bibkey.tWd = 'BricKrau1992';

% % Temperature vs. oxygen consumption rate 
% data.TJO = [1.52 7.39 8.63 10.43 11.40 15.67 17.57 20.32 23.05; % ??C, temperature
%             0.067 0.199 0.345 0.367 0.488 1.043 0.931 0.814 1.098]'; % mLO2/h, oxygen consumption rate
% units.TJO = {'??C', 'mL/h'}; label.TJO = {'temperature', 'O_2 consumption rate'}; bibkey.TJO = 'BricEpp1987';

% Dry weight vs. oxygen consumption rate at different temperatures
% Removed for now,predictions way off
% data.WJO = [0.457 0.677 0.675 0.678 0.746 0.912 0.918 0.994 1.113 0.963 0.970 1.064 1.290 0.959 0.960 1.537 1.543 1.510 1.522 1.703 2.024 1.694 2.026 2.254 2.377 2.256 2.540 2.642 2.734 2.717 2.561 3.185 3.183 2.927; % g, dry weight
%             0.124 0.155 0.164 0.176 0.195 0.170 0.158 0.163 0.187 0.195 0.210 0.214 0.234 0.274 0.329 0.350 0.394 0.195 0.238 0.226 0.246 0.274 0.295 0.318 0.335 0.356 0.338 0.318 0.381 0.399 0.413 0.394 0.375 0.486]'; % mLO2/h, oxygen consumption rate
% units.WJO = {'g', 'mL/h'}; label.WJO = {'dry weight', 'O_2 consumption rate'}; bibkey.WJO = 'BricEpp1987';
% temp.WJO = C2K(7.4); units.temp.WJO = 'K'; label.temp.WJO = 'temperature';

% length-GSI
% Removed for now use GSI as Univariate data
% data.LGSI = [3.8 4.5 5.0 5.6 6.1 6.7 7.2; %length (mm),GSI(-) 
%              0.44 0.47 0.51 0.50 0.38 0.34 0.30]';
% units.LGSI= {'cm', 'g'}; label.LGSI = { 'shell length', 'GSI'}; 
% temp.LGSI = C2K(12); units.temp.LGSI = 'K'; label.temp.LGSI = 'temperature'; 
% bibkey.LGSI = {'Morl2018'};
% comment.LGSI = 'data by Rothera Simon';


%% set weights for all real data
weights = setweights(data, []);
% % confident in some early life stage data, lots of hatchery data and sources
weights.aj = 2 * weights.aj;
weights.ab = 2 * weights.ab;
weights.am = 2 * weights.am; % short lived speceis
weights.ab = 2 * weights.Lb;
weights.am = 2 * weights.Lj;
weights.GSI = 5 * weights.GSI;
% 
% % Less confident in dry weights, used another species to guess
% weights.Wdb = 0 * weights.Wdb;
% weights.Wdj = 0 * weights.Wdj;

%% overwriting weights (remove these remarks after editing the file)
% the weights were set automatically with the function setweigths,
% if one wants to ovewrite one of the weights it should always present an explanation example:
%
% zero-variate data:
% weights.Wdi = 100 * weights.Wdi; % Much more confidence in the ultimate dry
%                                % weights than the other data points
% uni-variate data: 
 %weights.tL = 2 * weights.tL;

%% set pseudodata and respective weights
% (pseudo data are in data.psd and weights are in weights.psd)
[data, units, label, weights] = addpseudodata(data, units, label, weights);

%% overwriting pseudodata and respective weights (remove these remarks after editing the file)
% the pseudodata and respective weights were set automatically with the function setpseudodata
% if one wants to overwrite one of the values then please provide an explanation
% example:
% data.psd.p_M = 1000;                      % my_pet belongs to a group with high somatic maint 
% weights.psd.kap = 10 * weights.psd.kap;   % I need to give this pseudo data a higher weights

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
if exist('comment','var')
  txtData.comment = comment;
end

%% group plots
% set1 = {'tL1',}; comment1 = {'Lower and upper Damariscotta River'};
% metaData.grp.sets    = {set1};
% metaData.grp.comment = {comment1};

%% Discussion points
%D1 = 'Author_mod_1: I found information on the number of eggs per female as a function of length in Anon2013 that was much higher than in Anon2015 but chose to not include it as the temperature was not provided';
% optional bibkey: metaData.bibkey.D1 = 'Anon2013';

%metaData.discussion = struct('D1', D1,);

%% Facts
% list facts: F1, F2, etc.
% make sure each fact has a corresponding bib key
% do not put any DEB modelling assumptions here, only relevant information on
% biology and life-cycles etc.
F1 = 'The larval stage lasts 202 days and no feeding occurs';
metaData.bibkey.F1 = 'Wiki'; % optional bibkey
metaData.facts = struct('F1',F1);

%% References
% the following two references should be kept-----------------------------------------------------------
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{http://www.bio.vu.nl/thb/research/bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'LikaKear2011'; type = 'Article'; bib = [ ...  % used for the estimation method
'author = {Lika, K. and Kearney, M.R. and Freitas, V. and van der Veer, H.W. and van der Meer, J. and Wijsman, J.W.M. and Pecquerie, L. and Kooijman, S.A.L.M.},'...
'year = {2011},'...
'title = {The ''''covariation method'''' for estimating the parameters of the standard Dynamic Energy Budget model \textrm{I}: Philosophy and approach},'...
'journal = {Journal of Sea Research},'...
'volume = {66},'...
'number = {4},'...
'pages = {270-277},'...
'DOI = {10.1016/j.seares.2011.07.010},'...
'howpublished = {\url{http://www.sciencedirect.com/science/article/pii/S1385110111001055}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'CastDugg1971'; type = 'Article'; bib = [ ... 
'author = {Castagna, M. and Duggan, J. M.}, ' ... 
'year = {1971}, ' ...
'title = {Rearing the Bay Scallop \emph{Aequipecten irradians}}, ' ...
'journal = {Proceedings of the National Shellfisheries Association}, ' ...
'volume = {61}, ' ...
'number = {}, '...
'pages = {80-85}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'LoosDavi1963'; type = 'Techreport'; bib = [ ... 
'author = {Loosanoff, V. L. and Davis, H. C.}, ' ... 
'year = {1971}, ' ...
'title = {Rearing of Bivalve Mollusks}, ' ...
'institution = {U.S. Bureau of Commercial Fisheries Biological Laboratory}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Sast1965'; type = 'Article'; bib = [ ... 
'author = {Sastry, A. N.}, ' ... 
'year = {1971}, ' ...
'title = {The development and external morphology of pelagic larval and post-larval stages of the Bay scallop \emph{Aequipecten irradians concentricus}, Say, reared in the laboratory}, ' ...
'journal = {Bulletin of Marine Science}, ' ...
'volume = {}, ' ...
'number = {}, '...
'pages = {}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Beld1910'; type = 'Techreport'; bib = [ ... 
'author = {Belding, D. L.}, ' ... 
'year = {1910}, ' ...
'title = {The scallop fishery of Massachusetts, Including an acount of the Natural History of the Common Scallop}, ' ...
'institution = {Commonwealth of Massachusetts}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'ChanAndr1971'; type = 'Article'; bib = [ ... 
'author = {Chanley, P. and Andrews, J. D.}, ' ... 
'year = {1971}, ' ...
'title = {Aids for identification of bivalve larvae of Virginia}, ' ...
'journal = {Malacologia}, ' ...
'volume = {11}, ' ...
'number = {}, '...
'pages = {45-119}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Guts1930'; type = 'Techreport'; bib = [ ... 
'author = {Gutsell, J. S.}, ' ... 
'year = {1930}, ' ...
'title = {Natural History of the Bay Scallop}, ' ...
'institution = {United States Bureau of Fisheries}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'FariUria1997'; type = 'Article'; bib = [ ... 
'author = {Farias, A., Uriarte, I., Castilla. J. C.}, ' ... 
'year = {1997}, ' ...
'title = {A biochemical study of the larval and postlarval stages of Chilean scallop}, ' ...
'journal = {Aquaculture}, ' ...
'volume = {166}, ' ...
'number = {}, '...
'pages = {37-47}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'BricKrau1992'; type = 'Article'; bib = [ ... 
'author = {Bricelj, V. M., Krause, M. K.}, ' ... 
'year = {1992}, ' ...
'title = {Resourse allocation and population genetics of the bay scallop, \emph{Aequipecten irradians irradians}: effects of age and allozyme heterozygosity on reproductive output}, ' ...
'journal = {Marine Biology}, ' ...
'volume = {113}, ' ...
'number = {}, '...
'pages = {253-261}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'BarbDavi1997'; type = 'Article'; bib = [ ... 
'author = {Barber, B. J., Davis, C. V.}, ' ... 
'year = {1992}, ' ...
'title = {Growth and Mortality of cultured bay scallops in the Damariscotta River, Maine (USA)}, ' ...
'journal = {Aquaculture International}, ' ...
'volume = {1997}, ' ...
'number = {}, '...
'pages = {451-460}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'LuBlak1997'; type = 'Article'; bib = [ ... 
'author = {Lu, Y. and Blake, N. J.}, ' ... 
'year = {1997}, ' ...
'title = {The culture of the southern bay scallop in Tampa bay, an Urban Florida estuary}, ' ...
'journal = {Aquaculture International}, ' ...
'volume = {1997}, ' ...
'number = {}, '...
'pages = {439-450}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Oest1998'; type = 'Techreport'; bib = [ ... 
'author = {Oesterling, M. J.}, ' ... 
'year = {1998}, ' ...
'title = {Bay scallop culture}, ' ...
'institution = {Virginia Institute of Marine Science}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Guess'; type = 'Misc'; bib = [...
'note = {Guestimation}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];


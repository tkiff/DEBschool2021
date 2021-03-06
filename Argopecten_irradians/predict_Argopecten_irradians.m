%% predict_my_pet
% Obtains predictions, using parameters and data

%%
function [prdData, info] = predict_Argopecten_irradians(par, data, auxData)
  % created by Starrlight Augustine, Dina Lika, Bas Kooijman, Goncalo Marques and Laure Pecquerie 2015/01/30; 
  % last modified 2015/07/29
  
  %% Syntax
  % [prdData, info] = <../predict_my_pet.m *predict_my_pet*>(par, data, auxData)

  
  %% Remarks
  % Template for use in add_my_pet.
  % The code calls <parscomp_st.html *parscomp_st*> in order to compute
  % scaled quantities, compound parameters, molecular weights and compose
  % matrixes of mass to energy couplers and chemical indices.
  % With the use of filters, setting info = 0, prdData = {}, return, has the effect
  % that the parameter-combination is not selected for finding the
  % best-fitting combination; this setting acts as customized filter.
  
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);
    
  filterChecks = ... % f contrained to not be larger than 1 or negeative
                 f_tL1>1 || f_tL1 < 0 || ... ;
                 f_tL2>1 || f_tL2 < 0;
                 
     %f_WJO>1 || f_WJO < 0 || ... ; f_TJO >1 || f_TJO < 0;
if filterChecks
   info    = 0;
   prdData = {};
   return;
end


  % compute temperature correction factors
  TC_ab  = tempcorr(temp.ab, T_ref, T_A);
  TC_aj  = tempcorr(temp.aj, T_ref, T_A);
  TC_ap  = tempcorr(temp.ap, T_ref, T_A);
  TC_am  = tempcorr(temp.am, T_ref, T_A);
  TC_Ri1  = tempcorr(temp.Ri1, T_ref, T_A);
  TC_Ri2  = tempcorr(temp.Ri2, T_ref, T_A);
  TC_tL1 = tempcorr(temp.tL1, T_ref, T_A);
  TC_tL2 = tempcorr(temp.tL2, T_ref, T_A);
%   TC_TJO   = tempcorr(C2K(TJO(:,1)), T_ref, T_A);
  TC_GSI   = tempcorr(C2K(GSI(:,1)), T_ref, T_A);
%   TC_WJO   = tempcorr(temp.WJO, T_ref, T_A);
%   TC_LGSI   = tempcorr(temp.LGSI, T_ref, T_A);


%% Zero-variate data

  % life cycle
  pars_tj = [g k l_T v_Hb v_Hj v_Hp];
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f);

% %   % initial Nacella_concinna
%   pars_UE0 = [V_Hb; g; k_J ;k_M; v];
%   U_E0 = initial_scaled_reserve(f, pars_UE0); %d.cm2, initial scaled reserve. Fraction des r??serves restantes at birth
%   Ww_0 = U_E0 * p_Am * w_E / mu_E /d_V; % g, initial wet weight
  
  % Birth
  L_b  = L_m * l_b;                 % cm, structural length at birth at f
  Lw_b = L_b / del_Mb;             % cm, physical length at birth at f
  Wd_b = L_b^3 * d_V * (1 + f * w); % g,  dry weight at birth at f (remove d_V for wet weight)
  aT_b = t_b / k_M / TC_ab;         % d,  age at birth at f and T

  % Metamorphosis
  L_j  = L_m * l_j;                 % cm, structural length at metamorphosis at f
  Lw_j = L_j / del_Mb;             % cm, physical length at metamorphosis at f
  Wd_j = L_j^3 * d_V * (1 + f * w); % g,  dry weight at metamorphosis at f (remove d_V for wet weight)
  aT_j = t_j / k_M / TC_aj;         % d,  age at metamorphosis at f and T
  s_M = l_j/ l_b;                   % -, acceleration factor

  % Puberty
  L_p  = L_m * l_p;                 % cm, structural length at puberty at f
  Lw_p = L_p / del_M;               % cm, physical length at puberty at f
  Wd_p = L_p^3 * d_V * (1 + f * w); % g,  dry weight at puberty (remove d_V for wet weight)
  aT_p = t_p / k_M / TC_ap;         % d,  age at puberty at f and T

  % Ultimate
  L_i  = L_m * l_i;                 % cm, ultimate structural length at f
  Lw_i = L_i / del_M;               % cm, ultimate physical length at f
  Wd_i = L_i^3 * d_V * (1 + f * w); % g,  ultimate dry weight (remove d_V for wet weight)

  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
  RT_i1 = TC_Ri1 * reprod_rate_j(5.15*del_M, f, pars_R);              % #/d, ultimate reproduction rate at T
  RT_i2 = TC_Ri2 * reprod_rate_j(5.49*del_M, f, pars_R);              % #/d, ultimate reproduction rate at T
  
% reproduction
% max gonado-somatic index of fully grown individual 
%   that spawns once per year see (4.89) of DEB3
EGSI = 365 * TC_GSI * k_M * g/ f^3/ (f + kap * g * y_V_E);
EGSI = EGSI * ((1 - kap) * f^3 - k_J * U_Hp/ L_m^2/ s_M^2); % mol E_R/ mol W
  
  
  % Life span
  pars_tm = [g; l_T; h_a / k_M^2; s_G]; % compose parameter vector at T_ref
  t_m     = get_tm_s(pars_tm, f, l_b);  % -, scaled mean life span at T_ref
  aT_m    = t_m / k_M / TC_am;          % d, mean life span at T

  % Pack to output
  prdData.ab  = aT_b;
  prdData.aj  = aT_j;
  prdData.ap  = aT_p;
  prdData.am  = aT_m;
  prdData.Lb  = Lw_b;
  prdData.Lj  = Lw_j;
  prdData.Lp  = Lw_p;
  prdData.Li  = Lw_i;
  prdData.Wdb = Wd_b;
  prdData.Wdj = Wd_j;
  prdData.Wdp = Wd_p;
  prdData.Wdi = Wd_i;
  prdData.Ri1  = RT_i1;
  prdData.Ri2  = RT_i2;
  prdData.GSI  = EGSI;
%   prdData.Ww0  = Ww_0;
  
%% uni-variate data

  % Dugg1971
  % 25 Deg. - No known food
  % assuming that metamorphosis is passed (juvenile individuals) so we consider von Bertalanffy growth
  % from Gammarus_pulex, but I added line 129...
  [~, ~, ~, ~, ~, ~, l_i, ~, rho_B] = get_tj(pars_tj, f_tL1);
  kT_M = k_M * TC_tL1; rT_B = rho_B * kT_M; L_i = L_m * l_i;
  L_0  = Lw_0_tL1 * del_M; 
  ELw1 = (L_i - (L_i - L_0) * exp( - rT_B * tL1(:,1)))/ del_M;   % cm, Shell length
  
  % BricKrau1992
  % assuming that metamorphosis is passed (juvenile individuals) so we consider von Bertalanffy growth
  % from Gammarus_pulex, but I added line 137...
   [~, ~, ~, ~, ~, ~, l_i, ~, rho_B] = get_tj(pars_tj, f_tL2);
  kT_M = k_M * TC_tL2; rT_B = rho_B * kT_M; L_i = L_m * l_i;
  L_0  = Lw_0_tL2 * del_M; 
  L = (L_i - (L_i - L_0) * exp( - rT_B * tL2(:,1)));
  ELw2 = (L_i - (L_i - L_0) * exp( - rT_B * tL2(:,1)))/ del_M;   % cm, Shell length
  % time weight data
  % I may be way off here
  EWd = d_V * L.^3 * (1 + f_tL2 * w);                             % g, dry weight
  
%   % Compute parameters for oxygen consumption rate predictions
%   p_ref  = p_Am * L_m^2; % J/d, max assimilation power at max size and T_ref
%   pars_p = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp];
%   
%    % Temperature vs. oxygen consumption rate
%   f = f_TJO; W = Wd0;
%   [~, ~, ~, l_j, l_p, l_b, ~, ~, ~] = get_tj(pars_tj, f);
%   L        = (W / d_V / (1 + f * w)).^(1/3);
%   pACSJGRD = p_ref * scaled_power_j(L, f, pars_p, l_b, l_j, l_p);
%   pADG     = pACSJGRD(:,[1 7 5])';                     % J/d,    assimilation, dissipation, growth power
%   J_O      = eta_O * pADG;                             % mol/d,  fluxes of organics J_X, J_V, J_E, J_P in rows
%   J_M      = -n_M \ n_O * J_O;                         % mol/d,  fluxes of minerals J_C, J_H, J_O, J_N in rows, A, D, G in cols
%   ETJO     = -24.4e3 / 24 * J_M(3,:)' .* TC_TJO / Wd0; % mLO2/h, O2-consumption
  
%   % Dry weight vs. oxygen consumption rate 
%   f = f_WJO; TC = TC_WJO; W = WJO(:,1);
%   [~, ~, ~, l_j, l_p, l_b, ~, ~, ~] = get_tj(pars_tj, f);
%   L        = (W / d_V / (1 + f * w)).^(1/3);
%   [L, rows, occurence] = unique(L); % pulls out unique Length elements in increasing order
%   pACSJGRD = TC * p_ref * scaled_power_j(L, f, pars_p, l_b, l_j, l_p);
%   % exclude contribution from assimilation 
%   % not stated in the study
%   pACSJGRD(:,1) = 0 * pACSJGRD(:,1);   
%   pADG     = pACSJGRD(:,[1 7 5])';     % J/d,    assimilation, dissipation, growth power
%   J_O      = eta_O * pADG;             % mol/d,  fluxes of organics J_X, J_V, J_E, J_P in rows
%   J_M      = -n_M \ n_O * J_O;         % mol/d,  fluxes of minerals J_C, J_H, J_O, J_N in rows, A, D, G in cols
%   WJO     = -24.4e3 / 24 * J_M(3,:)';  % mLO2/h, O2 consumption
%   EWJO = [];
%   for i = 1:length(rows)
%         EWJO = [EWJO; WJO(i) + ones(length(find(occurence == i)),1)];    
%   end
  
%   % length-GSI: max gonad weight and proportion to soma (GSI= gonad weight/ soma weight)
% data from Nacella_concinna
%   pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb;U_Hj; U_Hp]; % compose parameter vector at T
%   L_gsi = LGSI(:,1) .* del_M; % cm, structural length
%   Ww = (L_gsi.^3) .* (1 + f_tL2 * w); % g, wet weight
%   GWW = 365 * TC_LGSI * reprod_rate_j(L_gsi, f_tL2, pars_R)* Ww0 ;
%   EGSI = GWW./ Ww;  % -, GSI
  
  
  % pack to output
  % the names of the fields in the structure must be the same as the data names in the mydata file
  prdData.tL1 = ELw1;
  prdData.tL2 = ELw2;
  prdData.tWd = EWd;
%   prdData.TJO = ETJO;
%   prdData.WJO = EWJO;
%   prdData.LGSI = EGSI;
  
end
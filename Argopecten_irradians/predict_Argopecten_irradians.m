%% predict_my_pet
% Obtains predictions, using parameters and data

%%
function [prdData, info] = predict_Argopecten_irradians(par, data, auxData)
  % created by Starrlight Augustine, Dina Lika, Bas Kooijman, Goncalo Marques and Laure Pecquerie 2015/01/30; 
  % last modified 2015/07/29
  
  %% Syntax
  % [prdData, info] = <../predict_my_pet.m *predict_my_pet*>(par, data, auxData)
  
  %% Description
  % Obtains predictions, using parameters and data
  %
  % Input
  %
  % * par: structure with parameters (see below)
  % * data: structure with data (not all elements are used)
  % * auxData : structure with temp data and other potential environmental data
  %  
  % Output
  %
  % * prdData: structure with predicted values for data
  % * info: identified for correct setting of predictions (see remarks)
  
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
                 f_TJO>1 || f_TJO < 0 || ... ; 
                 f_tL1>1 || f_tL1 < 0 || ... ;
                 f_tL2>1 || f_tL2 < 0 || ... ;
                 f_tL3 >1 || f_tL3 < 0;
   
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
  TC_Ri  = tempcorr(temp.Ri, T_ref, T_A);
  TC_tL1 = tempcorr(temp.tL3, T_ref, T_A);
  TC_tL2 = tempcorr(temp.tL3, T_ref, T_A);
  TC_tL3 = tempcorr(temp.tL3, T_ref, T_A);
  TC_TJO = tempcorr(C2K(TJO(:,1)), T_ref, T_A);
  % TC_WJO = tempcorr(temp.WJO, T_ref, T_A);

%% Zero-variate data

% Life cycle - from Placopecten magellanicus code
 pars_tj = [g k l_T v_Hb v_Hj v_Hp];
 [t_j, t_p, t_b, l_j, l_p, l_b, l_i, ~, ~, info] = get_tj(pars_tj, f); % -, scaled times & lengths at f

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

 % Puberty
L_p  = L_m * l_p;                 % cm, structural length at puberty at f
Lw_p = L_p / del_M;               % cm, physical length at puberty at f
Wd_p = L_p^3 * d_V * (1 + f * w); % g,  dry weight at puberty (remove d_V for wet weight)
aT_p = t_p / k_M / TC_ap;         % d,  age at puberty at f and T

 % Ultimate
L_i  = L_m * l_i;                 % cm, ultimate structural length at f
Lw_i = L_i / del_M;               % cm, ultimate physical length at f
Wd_i = L_i^3 * d_V * (1 + f * w); % g,  ultimate dry weight (remove d_V for wet weight)

 % Reproduction
pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
RT_i   = TC_Ri * reprod_rate_j(L_i, f, pars_R);               % #/d, ultimate reproduction rate at T

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
prdData.Ri  = RT_i;
  
%% uni-variate data
 
%   time-length for the lower damariscotta River (tL1)
%   [t, L] = ode45(@get_L1, tL1(:,1), L_b, [], L_j, L_i, r_j, r_B, T_ref, T_A);
%   ELw1 = L/ del_M; 
  
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL1);
  r_B = rho_B * k_M; L_i = l_i * L_m; L_b = l_b * L_m; 
  t_start = tL1(1,1);
  [t, L] = ode45(@get_L1, [0; tL1(:,1)], L_b, [], r_B, L_i, T_ref, T_A, t_start); 
  ELw1 = L(2:end)/ del_M;
  
% time-length for the upper damariscotta River (tL2)
%   [t, L] = ode45(@get_L2, tL2(:,1), L_b, [], L_j, L_i, r_j, r_B, T_ref, T_A);
%   ELw2 = L/ del_M; 
  
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL2);
  r_B = rho_B * k_M; L_i = l_i * L_m; L_b = l_b * L_m;
  t_start = tL2(1,1);
  [t, L] = ode45(@get_L2, [0; tL2(:,1)], L_b, [], r_B, L_i, T_ref, T_A, t_start); 
  ELw2 = L(2:end)/ del_M;

 
  % Time vs. shell length in Tampa Bay
  f = f_tL3; TC = TC_tL3; tL = tL3;
  [t_j, ~, t_b, l_j, ~, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f);
  rT_j = TC * rho_j * k_M; rT_B = TC * rho_B * k_M;
  L_b  = l_b * L_m; L_j = l_j * L_m; L_i = l_i * L_m;
  tT_j = (t_j - t_b) / k_M / TC;                                   % d,   time since birth at metamorphosis
  t_bj = tL(tL(:,1) < tT_j,1);                                     % d,   select times before metamorphosis
  L_bj = (L_b * exp(t_bj * rT_j / 3)) / del_Mb;                    % cm,  physical length at exponential growth as V1-morph
  t_ji = tL(tL(:,1) >= tT_j,1);                                    % d,   select times after metamorphosis
  L_ji = (L_i - (L_i - L_j) * exp(-rT_B * (t_ji - tT_j))) / del_M; % cm,  physical length at isomorphic growth
  ELw3  = [L_bj; L_ji];                                             % cm,  expected physical length at time

  % Shell length vs. tissue dry weight From Connecticut 
  % f   = f_LWd;
  % EWd = (LWd(:,1) * del_M).^3 * (1 + w * f) * d_V; % g, expected dry weight
 
  % Code for oxygen consumption data from the AmP Placopecten magellanicus entry
  
  % Compute parameters for oxygen consumption rate predictions
  p_ref  = p_Am * L_m^2; % J/d, max assimilation power at max size and T_ref
  pars_p = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp];
   
  % Temperature vs. oxygen consumption rate
  f = f_TJO; W = Wd0;
  [~, ~, ~, l_j, l_p, l_b, ~, ~, ~] = get_tj(pars_tj, f);
  L        = (W / d_V / (1 + f * w)).^(1/3);
  pACSJGRD = p_ref * scaled_power_j(L, f, pars_p, l_b, l_j, l_p);
  pADG     = pACSJGRD(:,[1 7 5])';                     % J/d,    assimilation, dissipation, growth power
  J_O      = eta_O * pADG;                             % mol/d,  fluxes of organics J_X, J_V, J_E, J_P in rows
  J_M      = -n_M \ n_O * J_O;                         % mol/d,  fluxes of minerals J_C, J_H, J_O, J_N in rows, A, D, G in cols
  ETJO     = -24.4e3 / 24 * J_M(3,:)' .* TC_TJO / Wd0; % mLO2/h, O2-consumption
   
  %  Dry weight vs. oxygen consumption rate
  % f = f_WJO; TC = TC_WJO; W = WJO(:,1);
  % [~, ~, ~, l_j, l_p, l_b, ~, ~, ~] = get_tj(pars_tj, f);
  % L        = (W / d_V / (1 + f * w)).^(1/3);
  % pACSJGRD = TC * p_ref * scaled_power_j(L, f, pars_p, l_b, l_j, l_p);
  % pADG     = pACSJGRD(:,[1 7 5])';     % J/d,    assimilation, dissipation, growth power
  % J_O      = eta_O * pADG;             % mol/d,  fluxes of organics J_X, J_V, J_E, J_P in rows
  % J_M      = -n_M \ n_O * J_O;         % mol/d,  fluxes of minerals J_C, J_H, J_O, J_N in rows, A, D, G in cols
  % EJO     = -24.4e3 / 24 * J_M(3,:)'; % mLO2/h, O2 consumption
  

  % pack to output
  % the names of the fields in the structure must be the same as the data names in the mydata file
  prdData.tL1 = ELw1;
  prdData.tL2 = ELw2;
  prdData.tL3 = ELw3;
  % prdData.LWd = EWd;
  prdData.TJO = ETJO;
  % prdData.WJO   = EWJO;
  
end

function dL = get_L1(t, L, r_B, L_i, T_ref, T_A, t_start)
  if t < t_start
      TC = tempcorr(C2K(20), T_ref, T_A);
  else
      TC = tempcorr(C2K(10+8*sin(2*pi*(t+50)/365)), T_ref, T_A);
  end
  dL = TC * r_B * (L_i - L);
end

function dL = get_L2(t, L, r_B, L_i, T_ref, T_A, t_start)
  if t < t_start
      TC = tempcorr(C2K(20), T_ref, T_A);
  else
  TC = tempcorr(C2K(12+10*sin(2*pi*(t+50)/365)), T_ref, T_A);
  end
  dL = TC * r_B * (L_i - L);
end
close all; 
global pets 

pets = {'Argopecten_irradians'};
check_my_pet(pets);

estim_options('default');
estim_options('max_step_number', 5e2);
estim_options('max_fun_evals', 5e3);

estim_options('pars_init_method', 2); 
% 2 reads from pars_init file
% 1 reads from estimation output
estim_options('results_output', 3); 
estim_options('method', 'nm'); 

estim_pars; 
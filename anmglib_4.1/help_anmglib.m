function help_anmglib(str)
if ispc
    ll=ls(['../anmglib_4.1/*',str,'*']);
    disp(ll);
else
    ll=ls(['../anmglib_4.1/*',str,'*']);
    ll=erase(ll,'../anmglib_4.1/');
    disp(ll);
%     fprintf('%s\n',ll);
end
    



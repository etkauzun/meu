function z = final_FP(z0,t,y)
% final_FP finds the root of function z
%
% Call format: z = final_FP(z0,t,y)
%
% input variables:
% z0: z value 
% t: t value
% y value

global g

z_arr = z0;

for n = 1:100
    z = g(t,y,z_arr(n));
    z_arr = [z_arr,z];

end % for loop

z = z_arr(length(z_arr));

end % function
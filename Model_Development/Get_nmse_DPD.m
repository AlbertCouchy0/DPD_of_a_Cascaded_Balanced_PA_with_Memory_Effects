function nmse=Get_nmse_DPD(output_sim,output_act)
% 两者均为列向量
    x = output_sim;
    y = output_act;
    x = x / max(abs(x));
    y = y / max(abs(y));
    error = x - y;
    nmse = 10 * log10(mean((abs(error)).^2)/mean((abs(x)).^2));
end
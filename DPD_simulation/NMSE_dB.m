function nmse = NMSE_dB(x, y)
x = x(:);
y = y(:);
x = x / max(abs(x));
y = y / max(abs(y));
error = x - y;
nmse = 10 * log10(mean((abs(error)).^2)/mean((abs(x)).^2));
end
function Plot_AM(X,Y,name,lg)
y=abs(Y)./max(abs(Y));
x=abs(X)./max(abs(X));

figure()
plot(x,y,'r.');
xlabel('Normalized Input Amplitude');
ylabel('Normalized Output Amplitude');
L=legend(lg);
L.Location='northwest';
title(name);
grid on;grid minor;

end
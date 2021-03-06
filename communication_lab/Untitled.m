global P1 P2 P3 Lambda IL1 IL2 IL3 PF1 PF2 PF3 PLOSS B PLOAD
global P1min P2min P3min P1max P2max P3max
% define Pi_min and Pi_max
P1min = 50;
P2min = 5;
P3min = 15;
P1max = 250;
P2max = 150;
P3max = 100;
% define system load
PLOAD = 190;
% define b-matrix
B = [ 	1.36255*10^(-4) 1.75300*10^(-5) 1.83940*10^(-4);
1.75400*10^(-5) 1.54480*10^(-4) 2.82765*10^(-5);
1.83940*10^(-4) 2.82765*10^(-4) 1.61470*10^(-3)];

% set initial guess of powers and system lambda
% this values are the results from part one of the problem
P10 = 143.9936;
P20 = 11.02567;
P30 = 34.98076;
Lambda0 = 10.17443;
% solve equations in function ednoloss_eqs_p43 using fsolve
z1 = fsolve(@dispatchloss_eqs_p43,...[P10 P20 P30 Lambda0 1 1 1 1 1 1 1 1 1 1 1 1]
    ,optimset('MaxFunEvals',10^2,'1MaxIter',10^2))%,?Display?,?iter?))

% compute cost of scheduling each unit
F1 = 308.125 + 8.6625*P1 + 0.0052500*P1^2;
F2 = 136.9125 + 10.04025*P2 + 0.0060850*P2^2;
F3 = 59.155 + 9.760575*P3 + 0.0059155*P3^2;
FT = F1+F2+F3;
% output

disp('Problem 4.3.')
disp('...................................................................')
disp('Part b - i')
disp('----------')
disp('P1 P2 P3 Lambda')
disp(num2str([z1(1,1) z1(1,2) z1(1,3) z1(1,4)]))
disp(['Cost of Dispatching Unit 1: ' num2str(F1)])
disp(['Cost of Dispatching Unit 2: ' num2str(F2)])
disp(['Cost of Dispatching Unit 3: ' num2str(F3)])
disp(['Total Cost of ED: ' num2str(F1+F2+F3)])
disp('...................................................................')
?
% PART ii of Part B of the Problem
CR1 = Lambda*(1/PF1);
CR2 = Lambda*(1/PF2);
CR3 = Lambda*(1/PF3);
disp('Part b - ii')

disp('-----------')
disp(['Penalty Factor of unit 1:' num2str(PF1)])
disp(['Penalty Factor of unit 2:' num2str(PF2)])
disp(['Penalty Factor of unit 3:' num2str(PF3)])
disp(['Cost Rate of unit 1 :' num2str(CR1)])
disp(['Cost Rate of unit 2 :' num2str(CR2)])
disp(['Cost Rate of unit 3 :' num2str(CR3)])
disp('...................................................................')
disp('Part b - iii')
disp('------------')
P = [z1(1,1); z1(1,2); z1(1,3)];
PLOSS1 = P'*B*P
disp('...................................................................')
disp('Part b - iv')
disp('------------')
disp('Resulting load supplied: Psupplied = Ploss_calculated + Pload')
Psupplied = PLOSS1 + PLOAD



Function File:
function F = dispatchloss_eqs_p43(z)
global P1 P2 P3 Lambda IL1 IL2 IL3 PF1 PF2 PF3 PLOSS B PLOAD
global P1min P2min P3min P1max P2max P3max
% Unknown variables
P1 = z(1);
P2 = z(2);
P3 = z(3);
Lambda = z(4);
IL1 = z(5);
IL2 = z(6);
IL3 = z(7);
PF1 = z(8);
PF2 = z(9);
PF3 = z(10);
PLOSS = z(11);
% bound powers to their limits
if P3 < P3min
P3 = P3min;
else

if P3 > P3max
P3 = P3max;
end
end
if P2 < P2min
P2 = P2min;
else
if P2 > P2max
P2 = P2max;
end
end
if P1 < P1min
P1 = P1min;
else
if P1 > P1max
P1 = P1max;
end
end

IL1 = 2*(B(1,1)*P1 + B(1,2)*P2 + B(1,3)*P3);
IL2 = 2*(B(2,1)*P1 + B(2,2)*P2 + B(2,3)*P3);
IL3 = 2*(B(3,1)*P1 + B(3,2)*P2 + B(3,3)*P3);
PF1 = 1/(1 - IL1);
PF2 = 1/(1 - IL2);
PF3 = 1/(1 - IL3);
PLOSS = (P1^2)*B(1,1) + P1*B(1,2)*P2 + P1*B(1,3)*P3+ ...
P2*B(2,1)*P1 + (P2^2)*B(2,2) + P2*B(2,3)*P3+ ...
P3*B(3,1)*P1 + P3*B(3,2)*P2 + (P32)*B(3,3);
F(1,1) = PF1*(8.6625 + 0.0105*P1) - Lambda;
F(2,1) = PF2*(10.04025 + 0.004*P2) - Lambda;
F(3,1) = PF3*(9.760575 + 0.011831*P3) - Lambda;
F(4,1) = PLOAD + PLOSS - (P1+P2+P3) ;
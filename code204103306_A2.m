clc;
clear all;
N=input('Enter the population size : ') ;                     %population size
crossprob = input('Enter the crossover probability : ') ; 
mutprob = input('Enter the mutation probability : ') ; 

L = 40;                     %length of the string
xmax = 0.5;
xmin = 0.0;
itemax = 300;

for i=1:N
    for j=1:L
        random = rand;
        if(random<=0.5)
            gen(i,j) = 0;
        else
            gen(i,j) = 1;
        end
    end
end



iteration = 0;
while(iteration<itemax)
    

%decoding 
for i=1:N
        dec = decoded(gen(i,1:L/2),L);
        x1r(i) = xmin+(xmax-xmin)*(dec)/((2^(L/2))-1);
        dec = decoded(gen(i,L/2+1:end),L);
        x2r(i) = xmin+(xmax-xmin)*(dec)/((2^(L/2))-1);
end


x1real(iteration+1) = mean(x1r);
x2real(iteration+1) = mean(x2r);


%fitness evaluation
for i=1:N
    fitness(i) = func_eval(x1r(i),x2r(i));
    index(i) = i;
end

%fitnessmin = min(fitness);
%fitnessmax = max(fitness);
%fitnessavg = sum(fitness)/N;



fitnessmin(iteration+1) = min(fitness);
fitnessmax(iteration+1) = max(fitness);
fitnessavg(iteration+1) = sum(fitness)/N;


fitnesss = sum(fitness)./fitness;

for i=2:N
    fitnesss(i) = fitnesss(i)+fitnesss(i-1);
end

a = fitnesss(1);
b = fitnesss(10);
for i=1:N
    random=rand;
    r = (b-a)*random+a;
    dum=1;
    for j=1:N
      if(r<fitnesss(j))
            index(i)=dum;
            break
        end
        dum=dum+1;
    end
end


for i=1:N
    matingpool(i,:) = gen(index(i),:);
end

%crossover

rows = size(matingpool,1);      
U = randperm(rows);
matingp_new = matingpool(U,:);

childg = matingp_new;
%crossprob = 0.98;
for i=1:2:N
    r = rand;
    if r<=crossprob
        ra = randperm(L-1,2);
        if ra(1)<ra(2)
            temp = childg(i,ra(1):ra(2));
            childg(i,ra(1):ra(2)) = childg(i+1,ra(1):ra(2));
            childg(i+1,ra(1):ra(2)) = temp;
        else
            temp = childg(i,ra(2):ra(1));
            childg(i,ra(2):ra(1)) = childg(i+1,ra(2):ra(1));
            childg(i+1,ra(2):ra(1)) = temp;
        end
    end
end

%mutation
%mutprob = 0.01;
for i=1:N
    for j=1:L
        r = rand;
        if r<mutprob
            if childg(i,j) == 0
                childg(i,j) = 1;
            else
                childg(i,j) = 0;
            end
        end
    end
end

gen = childg;
iteration = iteration+1;
end

figure(1)
plot(1:iteration,fitnessavg);
axis([1 itemax -0.6 0]);
xlabel('Generations');
ylabel('Avg fitness');
legend('Average fitness');
title('Average fitness vs No. of generations');
hold off;


figure(2)
plot(1:iteration,fitnessmax);
axis([1 itemax -0.6 0]);
xlabel('Generations');
ylabel('Fitness');
hold on;

plot(1:iteration,fitnessmin);
axis([1 itemax -0.6 0]);
xlabel('Generations');
ylabel('Fitness');
legend('Maximum fitness','Minimum fitness');
title('Minimum fitness and Maximum fitness vs No. of generations');
hold off;

minfunc_val = -mode(fitness)
Value_of_x1 = mode(x1r)
Value_of_x2 = mode(x2r)

figure(3)
plot(1:iteration,x1real);
axis([1 itemax 0 1]);
xlabel('Generations');
ylabel('Variable values');

hold on;

plot(1:iteration,x2real);
axis([1 itemax 0 1]);
xlabel('Generations');
ylabel('Variable values');
legend('X1','X2');
title('Optimal Solution');
hold off;

clear; clc; close all
%Calculo en que el casino no impone un limite maximo a la apuesta
hold off;
hold on;
xlabel('partidas')
ylabel('capital')

%variables
apuesta_min = 1;        %apuesta minima impuesta por el casino
apuesta_max = 1000;        %apuesta maxima permitida por el casino

%parametros
prob_ganar = 18/38;
prob_perder = 1 - prob_ganar;
repeticiones = 6;   %repeticiones del ciclo que se pueden dar segun el riesgo tomado
capital_inicial = apuesta_min*2.^repeticiones;    %capital minimo con el que debo empezar segun la probabilidad de ganar

dias = 1;
dia_ganado = 0;
dia_perdido = 0;
capital_total = 0;

%calculos

%probabilidades generales de ganar (para evaluar un unico dia colocar un 1 en este for)
%para evaluar en mas dias comentar las lineas hold on, hold off, plot, xlabel, ylabel, y los resultados parciales marcados abajo
for i = 1:dias

    capital = capital_inicial;
    capital_max = 0;
    partida_n = 0;
    j = 0;  %eje x para el grafico. No puede ser mayor a 240 que son la cantidad de tiros posibles en 8hs
    plot(0,capital,'r.');

    for n = 1:240   %240 son la cantidad de tiros maximos por dia
        partida = round(rand*37);   %numero aleatorio de la ruleta en cada partida
        j = j+1;

        if capital >= apuesta_min && j <= 240   %revision de capital
            apuesta = apuesta_min;
            while capital >= apuesta && apuesta >= apuesta_min && (rem(partida,2) ~= 0 || partida == 0) %repeticiones al perder
                capital = capital-apuesta;
                plot(j,capital,'r.');
                if apuesta*2 >= apuesta_max   %configuracion nueva apuesta
                    if capital >= apuesta_max
                        apuesta = apuesta_max;
                    else
                        apuesta = capital;
                    end
                else
                    if capital >= apuesta*2
                        apuesta = apuesta*2;
                    else
                        apuesta = capital;
                    end
                end
                partida = round(rand*37);   %nuevo lanzamiento
                j = j+1;
            end
            if rem(partida,2) == 0  %suma de la ganancia
                capital = capital+apuesta;
                if capital >= capital_max    %flag mayor capital obtenido
                    capital_max = capital;
                    partida_j = j;
                end
                plot(j,capital,'r.');
            end
        else
            break
        end
    end
    %comentar estos resultados para evaluar mas de un dia
    capital_con_el_que_arranque = capital_inicial
    partidas_jugadas = j
    capital_final = capital
    capital_maximo_alcanzado = capital_max
    partida_del_capital_maximo = partida_j

    if capital >= capital_inicial
        dia_ganado = dia_ganado+1;
    else
        dia_perdido = dia_perdido+1;
    end
    capital_total = capital_total + capital - capital_inicial;
end
%comentar estos resultados para evaluar un unico dia
%dias_ganados = dia_ganado
%dias_perdidos = dia_perdido
%probabilidad_de_ganancia = dia_ganado/dias*100
%capital_final = capital_total

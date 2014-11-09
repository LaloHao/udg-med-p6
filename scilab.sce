clear
//PORT = "/dev/pts/1"; //Virtual , No tengo arduino :(
PORT = "/dev/ttyACM0"; //Real
offset = 80e-3;

data = [%nan %nan %nan %nan %nan %nan %nan];
//data = [1 2 3 4 5 6 7]; //Test
data2 = [%nan %nan %nan %nan %nan %nan %nan];
//data2 = [1 2 3 4 5 6 7]; //Test
diff = [%nan %nan %nan %nan %nan %nan %nan];
opt = [0 5e-3 10e-3 15e-3 20e-3 25e-3 30e-3];
PORT = x_dialog(['Serial';'Introduzca el puerto'],PORT)
h = openserial(PORT,"9600,n,8,2");
seleccion = 0
while seleccion <> 6
    clc;
    //clf;
    print(%io(2),"1. Calibracion")
    print(%io(2),"2. Lectura de datos (manual)")
    print(%io(2),"3. Lectura de datos (automatico)")
    print(%io(2),"4. Graficar")
    print(%io(2),"5. Guardar datos")
    print(%io(2),"6. Salir")
    menu = input("Seleccione una opcion: ")
    seleccion = menu;
    if seleccion == 1 then
        print(%io(2),"Por favor oculte el sensor de cualquier tipo de luz")
        input("Presione enter para continuar...") 
        print(%io(2),"Balancee el puente de Wheatstone")
        input("Presione enter para continuar...") 
    elseif seleccion == 2 then
        print(%io(2),"Datos manual!")
        print(%io(2),"1. 0 mA")
        print(%io(2),"2. 5 mA")
        print(%io(2),"3. 10 mA")
        print(%io(2),"4. 15 mA")
        print(%io(2),"5. 20 mA")
        print(%io(2),"6. 25 mA")
        print(%io(2),"7. 30 mA")
        comando = input("Seleccione una opcion: ") 
        if (comando >= 1 & comando <= 7)
            readserial(h);
            writeserial(h, string(comando));
            xpause(600000);
            //disp(readserial(h)) //DEBUG??
            data(comando) = strtod(readserial(h));
            xpause(300000);
            //disp(readserial(h)) //SI...
            data2(comando) = strtod(readserial(h));
            diff(comando) = abs(data(comando)-data2(comando))*5/1023 - offset;
            xpause(1000000);
            print(%io(2),"Dato #" + string(comando) + " " + string(data(comando)) + ", " + string(data2(comando)) + " Diff = " + string(diff(comando)) + "v")
        else
            print(%io(2),"Opcion invalida.")
        end
        input("Presione enter para continuar...") 
    elseif seleccion == 3 then
        print(%io(2),"Datos automatico!")
        for i = 1:7
            readserial(h);
            writeserial(h, string(i));
            xpause(600000);
            data(i) = strtod(readserial(h));
            xpause(300000);
            data2(i) = strtod(readserial(h));
            diff(i) = abs(data(i)-data2(i))*5/1023 - offset;
            xpause(1000000);
            print(%io(2),"Dato #" + string(i) + " " + string(data(i)) + ", " + string(data2(i)) + " Diff = " + string(diff(i)) + "v")
        end
        input("Presione enter para continuar...") 
    elseif seleccion == 4 then
        print(%io(2),"Graficas!")
        valid = 0;
        contador = 1;
        while contador <= 7
            if ( isnan(diff(contador)) == %F)
                valid = valid + 1;
            end
            contador = contador + 1 ;
        end
        if valid == 7 then
            clf
            for i = 1:7
              plot(opt(i),diff(i),'bs:');
              drawnow();
            end
            input("Presione enter para continuar...")
        else
          print(%io(2),"No hay datos a graficar!")
          input("Presione enter para continuar...") 
        end
        close();
    elseif seleccion == 5 then
       if getos() == 'Windows' then 
            unix('del data.txt data1.txt diff.txt');
        else 
            unix('rm -f data.txt data1.txt diff.txt'); 
        end
        print(%io(2),"data.txt: Escribiendo datos.")   
        write('data.txt', data)                     //Data (sin conversion)
        print(%io(2),"data.txt: Archivo generado.")   
        print(%io(2),"data2.txt: Escribiendo datos.")   
        write('data2.txt', data2)                   //Data 2 (sin conversion)
        print(%io(2),"data2.txt: Archivo generado.")      
        print(%io(2),"diff.txt: Escribiendo datos.")   
        write('diff.txt', diff)                     //Diferencia
        print(%io(2),"diff.txt: Archivo generado.")        
        input("Presione enter para continuar...")
    elseif seleccion == 6 then
        print(%io(2),"Adios!")
    else
        print(%io(2),"Opcion Invalida.")
        input(" Presione enter para continuar...")
    end
end
closeserial(h);

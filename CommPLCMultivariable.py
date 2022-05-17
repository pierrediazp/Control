import snap7.client as c
from snap7.util import *
from snap7.snap7types import *
import time
import keyboard  # using module keyboard
import os
import math

#Limpieza y actualizacion de la pantalla
clear = lambda: os.system('cls')

#Conexión con el PLC
plc = c.Client()
plc.connect('192.168.0.1',0,1)
print("Conectado")

#Presión 	    IW96
#Flujo		    IW98
#Nivel		    IW100
#Run Bomba	    Q0.5
#Bomba		    QW80
#Válvula H20	QW96

#ESCRIBIR SALIDA BOOLEANA
def escr_sal_bool(byte, bit, valor):
    lectura = plc.ab_read(byte, bit)
    set_bool(lectura, byte, bit, valor)
    plc.ab_write(0, lectura)
    return
#escr_sal_bool(0,1,1)

#ESCRIBIR SALIDA ENTERO
def escr_sal_ent(byte,valor):
    lectura = plc.read_area(areas['PA'], 0, byte, 2) #PA: salidas, 0: bloque de datos, dirección, # bytes.
    set_int(lectura, 0, valor)  # se da formato al valor deseado, en este caso entero
    plc.write_area(areas['PA'], 0, byte, lectura)  # Escribe en la dirección definida
#escr_sal_ent(90,9000)

#LEER SALIDA ENTERO
def leer_sal_ent(byte):
    leer = plc.read_area(areas['PA'],0,byte,2) #Se lee la dirección 10, 2 bytes (este 2 podría ser
    leer_ent = get_int(leer,0) #Comando get_int(_bytearray, byte_index)
    return leer_ent
#lectura = leer_sal_ent(90)
#print(lectura)

#LEER MARCA ENTERA
def leer_ent_ent(byte):
    leer = plc.read_area(areas['PE'],0,byte,2) #PE: entradas, 0: bloque de datos, dirección, # bytes.
    leer_ent = get_int(leer,0) #Comando get_int(_bytearray, byte_index)
    return leer_ent
#lectura = leer_mk_ent(90)
#print(lectura)

#INICIO DEL PROGRAMA

#Activar run de la Bomba (salida Q0.5)
escr_sal_bool(0,5,1) #Habilitar RUN motobomba

#Poner bomba en 60Hz salida QW80
motobombaHz = 0
motobomba = motobombaHz * (22118 / 60) + 5530
escr_sal_ent(80,motobomba)

#Abrir válvula al 100% salida QW96
valvulap = 0
valvula = ((7800 / 71.5) * (valvulap - 7.4)) + 6200
escr_sal_ent(96,valvula)

while True:  # making a loop
    try:  # used try so that if user pressed other than the given key error will not be shown
        if keyboard.is_pressed('q'):  # if key 'q' is pressed
            print('You Pressed Q which means "Exit"!')
            break  # finishing the loop
        elif keyboard.is_pressed('w'):
            motobombaHz += 5
        elif keyboard.is_pressed('s'):
            motobombaHz -= 5
        if motobombaHz > 60:
            motobombaHz = 60
        elif motobombaHz < 0:
            motobombaHz = 0
        elif keyboard.is_pressed('e'):
            valvulap += 10
        elif keyboard.is_pressed('d'):
            valvulap -= 10
        if valvulap > 100:
            valvulap = 100
        elif valvulap < 0:
            valvulap = 0

        # Lectura nivel
        nivelplc = leer_ent_ent(100)
        nivelcm = ((60 / 15105) * (nivelplc - 10125)) + 20

        # Escritura de válvula
        valvula = ((7800 / 71.5) * (valvulap - 7.4)) + 6200
        escr_sal_ent(96, valvula)

        # Escritura bomba
        motobomba = motobombaHz * (22118 / 60) + 5530
        escr_sal_ent(80, motobomba)

    except:
        break
    time.sleep(0.5)
    clear() #Se limpia la pantalla para presentar los datos organizados.
    print("Motobomba: W incrementa, S decrementa -- Valvula: E incrementa, D decremennta -- Q: Salir")
    print("Nivel: {0:.2f}".format(nivelcm))
    print("Motobomba: {0:.2f}".format(motobombaHz))
    print("Valvula: {0:.2f}".format(valvulap))

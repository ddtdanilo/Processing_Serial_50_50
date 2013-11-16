/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

int tam_arreglo = 2501;
int tam = 500; //Tamaño de la pantalla
byte[] Datos_Buffer = new byte[2501]; //Espera tam+1 bytes -> [0] -> linefeed?
Serial myPort;  // Create object from Serial class
byte serial_data;      // Data recibida
int tam_cubo = 10; // 50*50 cubos

void set_cube(float x, float y)
{
  
  rectMode(CENTER);  // Set rectMode to CENTER
  x = map(x,0,50,0,tam);
  y = map(y,0,50,0,tam);
  
  rect(x+5,y+5,tam_cubo,tam_cubo);
  
  
}

void setup() 
{
  
  size(tam,tam,P2D); 
  background(0, 0, 0);
  //set_cube(25,25);
  
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  println(Serial.list()[0]);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName,9600);
  myPort.buffer(tam_arreglo); //[0] es el que indica para empezar
  //set_cube(25,25);
  for(int k = 0 ; k < tam_arreglo ; k++) Datos_Buffer[k] = 0;
  
}

void draw()
{
  //int a = 0;
  //Obtengo el valor de la data del demoqe
  int y = 0;//Empiezo en la fila 0 (y = 0)
  int x = 0;//Empiezo en la fila 0 (y = 0)
  fill(255,255,255); //Coloca el color
  //set_cube(49,49);
  int dato = 1;
  byte col = 0;
  
     for(y = 0; y < 50 ; y++)
     {
       
       for(x = 0; x < 50 ; x++)
         {
          col = Datos_Buffer[dato];
          fill(col,col,col);// 
           set_cube(x,y);
           dato++;
           
         }
       
       
       
     }
 
  dato = 1;

}



void serialEvent(Serial myPort) {  
  Datos_Buffer = myPort.readBytes();  //Guarda el buffer en el arreglo de 
  println("Datos del Buffer: ");
  for(int k = 0 ; k < tam_arreglo ; k++)  println(Datos_Buffer[k]);
  println("Fin del Buffer");
} 

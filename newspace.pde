import ddf.minim.*;
import processing.serial.*;

/*
* newspace
* En esta version vamos a utilizar clases y objetos para desarrollar nuestro juego de space invaders
* Podemos ver que cada elemento principal es ahora un objeto o una instancia de una clase.
* tenemos la nave, el enemigo y la bala
*
*/

Enemigo[][] enemigos = new Enemigo[3][5]; //declaramos un enemigo basado en la clase enemigo, podemos decir que Enemigo es como una estructura que guarda variables, metodos, etc y estamos crando un elemento que hereda esa estructura 
Enemigo enemigo2;

//referencias para los objetos de bala,enemigo nave y menu
Nave nave; //igual hacemos con la nave y con la bala
Bala bala;
Menu menu;

Minim minim;

//declaracion de variables parab el audio 
AudioPlayer laser;
AudioPlayer soundtrack;
AudioPlayer explosion;
AudioPlayer explosionF;

//declaracion de imagenes para el fondo
PImage fondoImagen;
PImage explosionA[] = new PImage[13];

//variables para los enemigos
int numEnemigos = 3;
int numEnemigosH = 5;

//velocidad de los enemigos
int velInicial = 5;

//variables para la explosion 
int contEliminados = 0;
int puntos = 0;
int contador = 0;
int rep = 0;
int cuadros = 13;
boolean ganador = false;

void setup() {
  
  size(900, 1200);
  frameRate(60);
  
  minim = new Minim(this);
  
  laser = minim.loadFile("sounds/disparos.wav");
  soundtrack = minim.loadFile("sounds/fondo1.wav");
  explosion = minim.loadFile("sounds/explosion1.wav");
  explosionF = minim.loadFile("sounds/explosion2.mp3");
  
  soundtrack.play();
  
  fondoImagen = loadImage("img/fondo.jpg");
  fondoImagen.resize(width,height);
  cargarAnimacion();
  
 enemigosPosInicial();
 
  nave = new Nave(); //el constructor de la nave no requiere parametros
  bala = new Bala(nave.getX(), nave.getY()); //el constructor de la bala dice que necesitamos su x y su y
  menu = new Menu();
}

void draw() {
  
  background(fondoImagen);
  
  //funcion menu que recibe los puntos de la nave
  menu.puntuacion(puntos);
  
  //valida el evento 
  if (nave.getReiniciar() == false)
  {
    //se llama a la dfuncion que valida si el enemigo se choca con las paredes
    dibujarEnemigos(); 
   
   //se mueve el enemigo
    moverEnemigos();
   
   //se dibuja la nave
    nave.dibujarNave(); //llamamos al metodo dibujar() que se encuentra en la nave
    //se mueve el enemigo
    nave.moverNave(); //llamamos al metodo mover() que se encuentra en la nave 
    
    //se valida si el enemigo se elimino
    eliminarEnemigos();
  }
    //valida si todos los enemigos se eliminaron
    gameOver();
  
}

//funcion que dibuja a los enemigos en su posicion incial
void enemigosPosInicial()
{
  for (int i = 0; i < numEnemigos; i++)
  {
    for (int j = 0; j< numEnemigosH; j++)
    {
      enemigos[i][j] = new Enemigo(100*(j+1), 100*(i+1), velInicial); //ahora inicializamos al enemigo con los datos requeridos por su constructor
    }
  }
}

//manejador de eventos
void keyPressed() {
  if (keyCode == RIGHT)  // le decimos a la nave que cambie el valor a la izquierda
  {
    nave.setDerecha(true); //le decimos a la nave que cambie el valor de derecha
  }
  else if (keyCode == LEFT)
  {
    nave.setIzquierda(true);//le decimos a la nave que cambie el valor de izquierd
  }
  else if (key == ' '  && nave.getReiniciar() == false) //valida si hubo gameover
  {
    //se recetea los valores inciales
      if ( bala.getDisponible() == true)
      {
        laser.play();

        bala.setDisparar(true); //le decimos a la bala que estamos disparando
        bala.setX(nave.getX());
        bala.setY(nave.getY());
        bala.setDisponible(false);
        
        laser.rewind();
      }
  }
  else if (keyCode == ENTER && nave.getReiniciar() == true) // si gano o perdio lanza el menu y renicia 
  {
    soundtrack.play();
    enemigosPosInicial();
    nave.setReiniciar(false);
    bala = new Bala(nave.getX(), nave.getY());
    puntos = 0;
  }
}

void keyReleased() {
  
  if (keyCode == RIGHT)
  {
    nave.setDerecha(false);
  }
  else if (keyCode == LEFT) 
  {
    nave.setIzquierda(false);
  }

}

void dibujarEnemigos()
{
  for (int h = 0; h < numEnemigos; h++)
  {
    for (int i = 0; i < numEnemigosH; i++)
    {
      if (enemigos[h][i].getVivo() == true )
      {
        if (enemigos[h][i].getPosX() + 25 > width)
        {  
            for(int j = 0; j < numEnemigos; j++)
            {
              for (int k = 0; k < numEnemigosH; k++)
               {
                 enemigos[j][k].setAbajoIzq(true);
               }
            }
         }
         else if (enemigos[h][i].getPosX() - 25 < 0)
         { 
            for(int j = 0; j < numEnemigos; j++)
            {
              for (int k = 0; k < numEnemigosH; k++)
               {
                 enemigos[j][k].setAbajoDer(true);
               }
             }
          }
         
       }
       
      if (enemigos[h][i].getExplosion() == true && enemigos[h][i].getVidas() == 0)
      {
         contador++;  
        
         if (contador%100 == 0) ;
         {
           rep = (rep+1)%cuadros;
           image(explosionA[rep], enemigos[h][i].getPosX(), enemigos[h][i].getPosY());
         }
            
         if (rep == 12)
         {
           enemigos[h][i].setExplosion(false);
           contador = 0;
           rep = 0;
         }
       }  
    }
  }
}

void moverEnemigos()
{
  
  for (int h = 0; h<numEnemigos; h++)
  {
     for (int i = 0; i < numEnemigosH; i++)
     {  if (enemigos[h][i].getVivo() == true)
         {           
           enemigos[h][i].dibujar(); //llamamos al metodo dibujar() que se encuentra en el enemigo
           enemigos[h][i].mover();
         }
     } 
  }  
}

//funcion que verifica si el enemigo se elimino y pone la musica 
void eliminarEnemigos()
{
  if (bala.disparar == true) 
  { //si disparamos
    
    bala.dibujar(); //informamos a la bala que se dibuje
    bala.mover(); //infoprmamos a la bala que se mueva
    
    for (int h = 0; h < numEnemigos; h++)
    {
      for (int i= 0; i < numEnemigosH; i++) 
      {  
        if (bala.elimino(enemigos[h][i]))
         {
           if (enemigos[h][i].getVidas() > 0)
           {
             explosion.play();
           }
           else if (enemigos[h][i].getVidas() == 0)
           {
             explosionF.play();
             puntos += enemigos[h][i].getPuntuacion();
           }
           
           bala.setX(nave.getX());
           bala.setY(nave.getY());
           bala.setDisparar(false);
           
           
           if (enemigos[h][i].getVidas() >= 1)
             explosion.rewind();
           else if (enemigos[h][i].getVidas() < 1)
              explosionF.rewind();
        }
      }
    }
  }
}

//valida si el juego termino
void gameOver()
  {

      for (int i = 0; i < numEnemigos; i++)
      {
        for (int j = 0; j < numEnemigosH; j++)
        {
          if (enemigos[i][j].getPosY()+50 > nave.posY - 40 && enemigos[i][j].getVivo() == true)
          {
              soundtrack.rewind();
              menu.perdedor("!!JUEGO PERDIDO!!");
              nave.setReiniciar(true);
          }
          
          if (enemigos[i][j].getVivo() == false)
          {
              contEliminados++;
            
              if (contEliminados == 15)
              { 
                soundtrack.rewind();
                menu.ganador("!!HAY UN GANADOR!!");
                nave.setReiniciar(true);
              } 
          }
        }
      } 
      contEliminados = 0;
    
  }

//se carga la animacion
 void cargarAnimacion()
  {
    
    explosionA[0] = loadImage("explosion/1.png");
    explosionA[1] = loadImage("explosion/2.png");
    explosionA[2] = loadImage("explosion/3.png");
    explosionA[3] = loadImage("explosion/4.png");    
    explosionA[4] = loadImage("explosion/5.png");
    explosionA[5] = loadImage("explosion/6.png");
    explosionA[6] = loadImage("explosion/7.png");
    explosionA[7] = loadImage("explosion/8.png");
    explosionA[8] = loadImage("explosion/9.png");    
    explosionA[9] = loadImage("explosion/10.png");
    explosionA[10] = loadImage("explosion/11.png");
    explosionA[11] = loadImage("explosion/12.png");
    explosionA[12] = loadImage("explosion/13.png");
    
    for (int i = 0; i<13; i++)
      explosionA[i].resize(50,50);
    
  }
 

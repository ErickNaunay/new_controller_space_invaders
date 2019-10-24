/* clase Bala
* se encarga de crear, dibujar y mover la bala
*/
import ddf.minim.*;

class Bala {
  PImage proyectil; //la imagen de la bala
  float posX; // su posicion x
  float posY; //su posicion y
  float vel = 10; //la velocidad de la bala
  boolean disponible = true; //si hay balas disponibles
  boolean disparar = false; //si se ha disparado

  Bala(float x, float y) { //constructor
    proyectil = loadImage("img/bala.png"); //cargamos la imagen
    posX = x; //asignamos la pos x y y de la bala
    posY = y-50;
    
  }

  void dibujar() {
    image(proyectil, posX, posY); //dibuja la bala - lo llamamos desde newspace
  }
  void mover() {
    if (disparar == true) { //se encarga de mover la bala - lo llamamos de newspace
      posY -=  vel;
      
      if (posY < 0)
      setDisponible(true);

    }
  }

  
  
  boolean elimino( Enemigo enemy)
  {
    if (dist(enemy.getPosX(), enemy.getPosY(), posX, posY) < 25 && enemy.getVivo() == true)
    {
 
      enemy.setVidas(enemy.getVidas()-1);
      
      if (enemy.getVidas() == 0)
      {
         enemy.setPuntuacion(10);
         enemy.setVivo(false);
         enemy.setExplosion(true);
      }
      
      enemy.setPuntuacion(enemy.getPuntuacion() + 10);
      bala.setDisponible(true);
      
      return true;
      
    } else 
      return false;
  }
  
  void setDisparar(boolean d) { //cambia el valor de disparar 
    disparar = d;
  }
  
  void setX(float x){ //asigna el valor de x
    posX = x;
  }
  void setY(float y){ //asigna el valor de y
    posY = y -50;
  }
  
  void setDisponible(boolean disponible)
 {
   this.disponible = disponible;
 }
 
 boolean getDisponible()
 {
  return disponible; 
 }
 
}
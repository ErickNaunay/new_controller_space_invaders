/*clase nave
* crea la nave y da sus propiedas y tiene los metodos necesarios para que se mueva
*/

class Nave {
 
  PImage spaceship = loadImage("img/spaceship.gif");
  float x = width/2;
  boolean derecha = false;
  boolean izquierda = false;
  float vel = 10;
  float posY = height-100;
  boolean reiniciar;
  
  Nave() {
  }
  
  void dibujarNave() {
    imageMode(CENTER);
    image(spaceship, x, posY);
    reiniciar = false;
    
  }
  void moverNave(){
   derecha();
   izquierda();
  }
  //derecha e izquierda
  //dependiendo del boolean derecha o izquierda mueven a la nave
  void derecha() {
    if (derecha && x <width-50) {
      x+=vel;
    }
  }
  void izquierda() {
    if (izquierda && x > 50) {
      x-=vel;
    }
  }
  
  void setDerecha(boolean d) { //asigna valor a deerecha, llamado desde newspace keypress
    derecha = d;
  }

  void setIzquierda(boolean i) { //asigna valor a izquierda, llamado desde newspace keypress
    izquierda = i;
  }
  
  float getX(){ //devuelve la pos x
    return x;
  }
  float getY(){ //devuelve la pos y
   return posY; 
  }
  
  void setReiniciar(boolean re)
  {
    reiniciar = re;
  }
  
  boolean getReiniciar()
  {
    return reiniciar;
  }
}
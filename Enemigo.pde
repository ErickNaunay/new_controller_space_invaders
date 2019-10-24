/* clase enemigo
* crea el enemigo y le da sus caracteristicas
*/

class Enemigo {//nombre de la clase 
  float posX;
  float posY;
  float velX;
  float velY;
  int vidas;
  int puntuacion;
  
  boolean vivo;
  boolean abajoIzq;
  boolean abajoDer;
  boolean explosion;
  
  PImage enemy3;
  PImage enemy2;
  PImage enemy1;
  
  Enemigo(float posX, float posY, float velX) {//constructor
    this.posX = posX;
    this.posY = posY;
    this.velX = velX;
    this.velY = 15;
    
    vivo = true;
    enemy3 = loadImage("img/enemy.png"); //carga la imagen del enemigo
    enemy3.resize(50,50); //le da escala al enemigo
    
    enemy2 = loadImage("img/enemyyellow.png"); //carga la imagen del enemigo
    enemy2.resize(50,50); //le da escala al enemigo
    
    enemy1 = loadImage("img/enemyred.png"); //carga la imagen del enemigo
    enemy1.resize(50,50); //le da escala al enemigo
    
   
    puntuacion = 0;
    
    abajoIzq = false;
    abajoDer= false;
    
    vidas = 3;
    
    explosion = false;
  }
  
  void dibujar() {
    
    if (getVidas() == 3)
      image(enemy3,posX, posY);//dibuja al enemigo
    else if (getVidas() == 2)
      image(enemy2,posX, posY);//dibuja al enemigo
    else if (getVidas() == 1)
    {
      image(enemy1,posX, posY);//dibuja al enemigo
    }
  
  }
  
  void mover(){ //mueve el enemigo
   
   if(abajoIzq == true)
    {
      posY += velY;
      velX *= (-1);
      
      abajoIzq = false;
    }
     else if( abajoDer == true)
    {
      posY += velY;
      velX *= (-1);
      
      abajoDer= false;
    }
  
      posX+=velX;
     
  }
  


  void setPosX(float x) { //asigna la posicion en x
    posX = x;
  } 
  float getPosX() { //devuelve la posicion en x
    return posX;
  }
  void setVelX(float x){//asigna la velocidad
    velX = x;
  }
  
  float getVelX() { //devuelve la posicion en x
    return velX;
  }
  
  float getPosY() { //devuelve la posicion en x
    return posY;
  }
  
  void setVivo(boolean vivo){//asigna la velocidad
    this.vivo = vivo;
  }
  
  void setAbajoIzq(boolean izq)
  {
    this.abajoIzq = izq;
  }
  
  boolean getAbajoIzq()
  {
   return abajoIzq; 
  }
  
  void setAbajoDer(boolean der)
  {
    this.abajoDer= der;
  }
  
  boolean getAbajoDer()
  {
   return abajoDer; 
  }
  
  boolean getVivo()
  {
    return vivo;
  }
  
  boolean getExplosion()
  {
   return explosion; 
  }
  
  void setExplosion(boolean exp)
  {
    explosion = exp;
  }
  
   int getVidas() { //devuelve la posicion en x
    return vidas;
  }
  
  void setVidas(int vidas){//asigna la velocidad
    this.vidas = vidas;
  }
  
   int getPuntuacion() { //devuelve la posicion en x
    return puntuacion;
  }
  
  void setPuntuacion(int puntuacion){//asigna la velocidad
    this.puntuacion = puntuacion;
  }
  
}//termina clase
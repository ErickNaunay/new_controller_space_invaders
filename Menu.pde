class Menu
{
  
  Menu()
  {
  }
  
  
  void ganador(String text)
  {
    rectMode(CENTER);
    fill(#FFFFFF);
    stroke(0);
    strokeWeight(1);
    rect(width/2, height/2 + 10, 300, 85);
    
    textSize(20); 
    fill(#EA4321);
    textAlign(CENTER);
    text(text+ "\n -ENTER para reintentar-", width/2, height/2);
  }
  void perdedor(String text)
  {
    
    rectMode(CENTER);
    fill(#FFFFFF);
    stroke(0);
    strokeWeight(1);
    rect(width/2, height/2 + 10, 300, 85);
    
    textSize(20); 
    fill(#EA4321);
    textAlign(CENTER);
    text(text+ "\n -ENTER para reintentar-", width/2, height/2);
  }
  
  void puntuacion(int puntuacion)
  {
    fill(#CE7070);
    textSize(32);
    textAlign(CENTER);
    text("Puntuacion: " + puntuacion, width/2, 60);
  }

}
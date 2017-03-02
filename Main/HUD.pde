//Heads Up Display class

class HUD
{
  private float health;
  private float stamina;
  private float temperature;
  private int ammo;
  
  HUD(float h, float s, float t, int a)
  {
    this.health = h;
    this.stamina = s;
    this.temperature = t;
    this.ammo = a;
  }
  
  void updateValues(float h, float s, float t, int a)
  {
    this.health = h;
    this.stamina = s;
    this.temperature = t;
    this.ammo = a;
  }
  
  void display()
  {
    pushMatrix();
    
    //Health bar
    rectMode(CORNER);
    noStroke();
    fill(100,100,100,100);
    rect(width/40-2, height/20-2, 4*width/20+4, 2*height/200+4);
    fill(0,255,0,255);
    rect(width/40, height/20, (health/100.0)*4*width/20, 2*height/200);
    
    //Stamina bar
    fill(100,100,100,100);
    rect(width/40-2, height/20 + 5*height/200 -2, 4*width/20+4, 2*height/200+4);
    fill(255,255,0,255);
    rect(width/40, height/20 + 5*height/200 , (stamina/100.0)*4*width/20, 2*height/200);
    
    //temperature bar
    fill(100,100,100,100);
    rect(width/40-2, height/20 + 10*height/200 -2, 4*width/20+4, 2*height/200+4);
    fill(190,38,51,255);
    rect(width/40, height/20 + 10*height/200, (temperature/100.0)*4*width/20, 2*height/200);
    
    //ammo counter
    fill(255);
    textAlign(LEFT,TOP);
    textSize(24);
    text("Ammo: " + this.ammo + "/30", width/40+1, height/20 + 15*height/200 +1);
    fill(0);
    textSize(24);
    text("Ammo: " + this.ammo + "/30", width/40, height/20 + 15*height/200);
    popMatrix();
  }
}
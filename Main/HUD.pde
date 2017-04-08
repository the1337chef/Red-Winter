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
    //Crosshair
    if(mouseY >= 78)
      image(crosshairs, mouseX, mouseY - 78);
    else
      image(crosshairs,mouseX, 0);
    
    //Health bar
    rectMode(CORNER);
    imageMode(CORNER);
    noStroke();
    image(hudHealth, width/40-2, (height/20)-2);
    fill(100,100,100,100);
    rect(2*width/40-2, height/20-2, 5*width/20+4, 5*height/200+4);
    fill(255,0,0,255);
    rect(2*width/40, height/20, (health/100.0)*5*width/20, 5*height/200);
    
    //Stamina bar
    image(hudEnergy, width/40-2, (height/20)-2+32);
    fill(100,100,100,100);
    rect(2*width/40-2, height/20 + -2 + 32, 5*width/20+4, 5*height/200+4);
    fill(0,255,0,255);
    rect(2*width/40, height/20 + 32 , (stamina/100.0)*5*width/20, 5*height/200);
    
    
    //ammo counter
    for(int i = 0; i < this.ammo; i++)
    {
      image(hudAmmo, width/40-2 + i*10, (height/20)-2+64);
    }
    
    popMatrix();
  }
}
//Key class extends Pickup

class Key extends Pickup
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private String identifier;
  private PImage image;
  
  Key(float x, float y, float w, float h, String id)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x, y, w, h, 0, "pickup");
    this.identifier = id;
    this.image = loadImage("Pickups/" + this.identifier + ".png");
  }
  
  void display()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    imageMode(CENTER);
    image(this.image,0,0, this.sizeW, this.sizeH);
    rectMode(CENTER);
    pushMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
    popMatrix();
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }
  
  String getID(){
    return this.identifier;}
  
  void activate()
  {
    switch(this.identifier){
      case "dynamite": dynamite = 1;
                       Hitbox temp = new Hitbox(745,266,200,100,0,"zone_transition");
                       temp.setZone("-1");
                       temp.setNextXPos(355);
                       temp.setNextYPos(324);
                       transitions.add(temp);
                       
                       break;
      case "rope": dynamite = 1;
                       break;
      case "ammo": player.setCurrentAmmo(player.getCurrentAmmo() + 5);
                   if(player.getCurrentAmmo() > 30)
                     player.setCurrentAmmo(30);
                   break;
      case "health": player.setHealth(player.getCurrentHealth() + 25);
                     if(player.getCurrentHealth() > 100)
                       player.setHealth(100);
                     break;
      case "bow": activeWeapon = bow;
                  player.setCurrentAmmo(5);
                  playerTop = bowTop;
                  previousWeapon = none;
                  break;
      case "kayak":
           Hitbox temp2 = new Hitbox(845,151,90,90,0,"zone_transition");
           temp2.setZone("-1");
           temp2.setNextXPos(355); /// may this be the aurora music bug area??
           temp2.setNextYPos(324);
           transitions.add(temp2);
           break;
      default: println("INVALID KEY TYPE, DUMMY");
                       break;
    }
  }
  
  Hitbox getHitbox(){
    return this.hBox;}
  float getDirection(){
    return 0;}
}
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
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
  }
  
  String getID(){
    return this.identifier;}
  
  void activate()
  {
    switch(this.identifier){
      case "dynamite": dynamite = 1;
                       Hitbox temp = new Hitbox(745,266,200,100,0,"zone_transition");
                       temp.setZone("-1");
                       temp.setNextXPos(43);
                       temp.setNextYPos(250);
                       transitions.add(temp);
                       break;
      case "rope": dynamite = 1;
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
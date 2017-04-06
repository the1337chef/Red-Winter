//Pickup superclass

class Pickup
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  
  Pickup()
  {
    
    this.xPos = 0;
    this.yPos = 0;
    this.sizeW = 32;
    this.sizeH = 32;
    this.hBox = new Hitbox(0, 0, 32, 32, 0, "pickup");
  }
  
  Pickup(float x, float y, float w, float h)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x, y, w, h, 0, "pickup");
  }
  void activate(){
  }
  
  void display(){
    pushMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
  }
  
  String getID(){
    return "pickup";}
  Hitbox getHitbox(){
    return this.hBox;}
  float getDirection(){
    return 0;}
}
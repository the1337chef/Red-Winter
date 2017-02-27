//Pickup superclass

class Pickup
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  
  Pickup(float x, float y, float w, float h)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x, y, w, h, 0, "pickup");
  }
}
//Key class extends Pickup

class Key extends Pickup
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private String identifier;
  
  Key(float x, float y, float w, float h, String id)
  {
    super(x,y,w,h);
    this.identifier = id;
  }
  
  void display()
  {
    pushMatrix();
    translate(this.xPos,this.yPos);
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CENTER);
    //image(this.identifier + ".png", this.sizeW, this.sizeH);
    rect(0,0, this.sizeW, this.sizeH);
    popMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
  }
  
  void activate()
  {
    zoneKeyAdd();
  }
}
//Projectile class

class Projectile
{
  private float xPos;
  private float yPos;
  private float damage;
  private float speed;
  private float xVector;
  private float yVector;
  private float sizeW;
  private float sizeH;
  private String type;
  private Hitbox hBox;
  
  Projectile()
  {
    this.xPos = 0;
    this.yPos = 0;
    this.damage = 0;
    this.speed = 1;
    this.xVector = 1;
    this.yVector = 0;
    this.sizeW = 10;
    this.sizeH = 10;
    this.type = "neutral";
    this.hBox = new Hitbox(this.xPos, this.yPos, this.sizeW, this.sizeH, 0, this.type);
  }
  
  
  Projectile(float x, float y, float d, float s, float xV, float yV, float w, float h, String t)
  {
    this.xPos = x;
    this.yPos = y;
    this.damage = d;
    this.speed = s;
    this.xVector = xV;
    this.yVector = yV;
    this.sizeW = w;
    this.sizeH = h;
    this.type = t;
    this.hBox = new Hitbox(this.xPos, this.yPos, this.sizeW, this.sizeH, 0, this.type);
  }
  
  //Display projectile
  void display()
  {
    pushMatrix();
    translate((width*(this.xPos-cameraX)/512), height*(this.yPos-cameraY)/288);
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
    this.xPos = this.xPos + this.xVector*this.speed;
    this.yPos = this.yPos + this.yVector*this.speed;
    noStroke();
    fill(100);
    ellipseMode(CENTER);
    ellipse(0,0, this.sizeW, this.sizeH);
    if(hitBoxMode)
      this.hBox.displayBox();
    popMatrix();
  }
  
  //GETTERS AND SETTERS
  float getXPos(){
    return this.xPos;}
  float getYPos(){
    return this.yPos;}
  float getXVector(){
    return this.xVector;}
  float getYVector(){
    return this.yVector;}
  Hitbox getHitbox(){
    return this.hBox;}
}
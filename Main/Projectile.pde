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
    this.speed = 3.5;
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
    ellipseMode(CENTER);
    noStroke();
    fill(100);
    if(this.type.equals("hostile_damage"))
    {
      imageMode(CENTER);
      translate(0,-64);
      rotate(atan2(this.yVector,this.xVector));
      image(bullet, 0,0, bullet.width*scaler*.5, bullet.height*scaler*.5);
      
      //fill(255,100,0);
      //ellipse(0,-64, this.sizeW*scaler, this.sizeH*scaler);
    }
    if(this.type.equals("friendly_damage"))
    {
      imageMode(CENTER);
      translate(0, -60);
      rotate(atan2(this.yVector,this.xVector));
      image(arrow, 0, 0, arrow.width*scaler*.75, arrow.height*scaler*.75);
    }
    
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
  String getType(){
    return this.type;}
  float getDamage(){
    return this.damage;}
}
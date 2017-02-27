//Player subclass

class Player extends Character
{
  private float xPos;
  private float yPos;
  private float direction;
  private float maxHealth;
  private float currentHealth;
  private float maxStamina;
  private float currentStamina;
  private float temperature;
  private float ammo;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  private boolean invincible;
  private float invTimer;
  private float invTime;
  
  Player(float x, float y, float dir, int h, float wi, float hi, String type)
  {
    //Default constructor
    this.xPos = x;
    this.yPos = y;
    this.direction = dir;
    this.maxHealth = h;
    this.currentHealth = h;
    this.maxStamina = 100;
    this.currentStamina = 100;
    this.temperature = 100;
    this.ammo = 0;
    this.sizeW = wi;
    this.sizeH = hi;
    this.hBox = new Hitbox(x, y, wi, hi, dir, type);
    this.invincible = false;
    this.invTimer = 0;
    this.invTime = 1000;
  }
  
  //Player display
  void display()
  {
    //Sprites instead of squares
    pushMatrix();
    translate(this.xPos, this.yPos);
    rotate(this.direction);
    stroke(0);
    strokeWeight(2);
    fill(100);
    rectMode(CENTER);
    rect(0, 0, this.sizeW, this.sizeH);
    popMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
  }
  
  //Player movement
  void movement(float xChange, float yChange)
  {
    //Wall collision and correction
    for(int i = 0; i < walls.size(); i++)
    {
      if(xCollision(walls.get(i).getHitbox(), this.hBox, xChange))
        xChange = 0;
      if(yCollision(walls.get(i).getHitbox(), this.hBox, yChange))
        yChange = 0;
    }
    
    //Map boundary collision and correction
    if(this.xPos + xChange > width-(this.sizeW/2) || this.xPos + xChange < (this.sizeW/2))
      xChange = 0;
    if(this.yPos + yChange > height-(this.sizeH/2) || this.yPos + yChange < (this.sizeH/2))
      yChange = 0;
    this.xPos += xChange;
    this.yPos += yChange;
    
    //Pickups
    
    //Hitbox placement
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
  }
  
  //GETTERS AND SETTERS
  float getXPos(){
    return this.xPos;}
  float getYPos(){
    return this.yPos;}
  float getDir(){
    return this.direction;}
  float getWidth(){
    return this.sizeW;}
  float getHeight(){
    return this.sizeH;}
  float getMaxHealth(){
    return this.maxHealth;}
  float getCurrentHealth(){
    return this.currentHealth;}
  float getMaxStamina(){
    return this.maxStamina;}
  float getCurrentStamina(){
    return this.currentStamina;}
  float getCurrentTemp(){
    return this.temperature;}
  float getCurrentAmmo(){
    return this.ammo;}
  Hitbox getHitbox(){
    return this.hBox;}
    
  void setDir(float dir){
    this.hBox.setDir(dir);
    this.direction = dir;}
}
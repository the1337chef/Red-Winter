//Character Class

class Character
{
  private float xPos;
  private float yPos;
  private float direction;
  private float maxHealth;
  private float currentHealth;
  private float sizeW;
  private float sizeH;
  private Hitbox hBox;
  
  Character()
  {
    this.xPos = 0;
    this.yPos = 0;
    this.direction = 0;
    this.maxHealth = 100;
    this.currentHealth = 100;
    this.hBox = new Hitbox(0, 0, 10, 10, 0, "default");
  }
  
  //Character constructor
  Character(float x, float y, float dir, int h, float wi, float hi, String type)
  {
    this.xPos = x;
    this.yPos = y;
    this.direction = dir;
    this.maxHealth = h;
    this.currentHealth = h;
    this.hBox = new Hitbox(x, y, wi, hi, dir, type);
  }
  
  //Generic display for characters
  //Overwritten by player and enemies
  void display()
  {
    pushMatrix();
    translate(this.xPos, this.yPos);
    rotate(this.direction);
    stroke(0);
    strokeWeight(1);
    fill(100);
    rectMode(CENTER);
    rect(0, 0, this.sizeW, this.sizeH);
    popMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
  }
  
  //Reduce Health
  void reduceHealth(int damage)
  {
    this.currentHealth -= damage;
  }
  
  //Add Health
  void addHealth(int healing)
  {
    this.currentHealth += healing;
    if(this.currentHealth > this.maxHealth)
      this.currentHealth = this.maxHealth;
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
  Hitbox getHitbox(){
    return this.hBox;}
    
  void setDir(float dir){
    this.direction = dir;}
}
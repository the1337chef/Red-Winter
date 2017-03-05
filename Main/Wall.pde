//Wall class

class Wall
{
  private float xPos;
  private float yPos;
  private float sizeW;
  private float sizeH;
  private float direction;
  private Hitbox hBox;
  
  Wall(float x, float y, float w, float h, float dir)
  {
    this.xPos = x;
    this.yPos = y;
    this.sizeW = w;
    this.sizeH = h;
    this.hBox = new Hitbox(x,y,w,h, dir, "wall");
    this.direction = dir;
  }
  
  //Displays the wall
  void displayWall()//redundant cause they are shown when you press h
  {
    pushMatrix();
    
    translate(this.xPos*scaler-cameraX*scaler,this.yPos*scaler-cameraY*scaler);
    rotate(this.direction);
    this.hBox.setXPos(this.xPos);
    this.hBox.setYPos(this.yPos);
    rectMode(CENTER);
    fill(0); //black
    noStroke();
    
    rect(0, 0,this.sizeW*scaler,this.sizeH*scaler);
    
    popMatrix();
    if(hitBoxMode)
      this.hBox.displayBox();
  }
  
  //GETTERS AND SETTERS
  float getXPos(){
    return this.xPos;}
  float getYPos(){
    return this.yPos;}
  float getWidth(){
    return this.sizeW;}
  float getHeight(){
    return this.sizeH;}
  Hitbox getHitbox(){
    return this.hBox;}
  
  void setXPos(float x){
    this.xPos = x;}
  void setYPos(float y){
    this.yPos = y;}
}
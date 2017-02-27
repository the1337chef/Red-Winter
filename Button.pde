//Button class

class Button
{
  private float xPos;
  private float yPos;
  private float bWidth;
  private float bHeight;
  private String text;
  private boolean active;
  private boolean highlight;
  
  Button(float x, float y, float w, float h, String words, boolean a)
  {
    this.xPos = x;
    this.yPos = y;
    this.bWidth = w;
    this.bHeight = h;
    this.text = words;
    this.active = a;
    this.highlight = false;
  }
  
  //Display button
  void display()
  {
    //Box
    if(this.active)
    {
      if( (mouseX <= xPos+(bWidth/2)) && (mouseX >= xPos-(bWidth/2)) &&
        (mouseY <= yPos+(bHeight/2)) && (mouseY >= yPos-(bHeight/2)))
      {
        fill(255,0,0);
        this.highlight = true;
      }
      else
      {
        fill(255);
        this.highlight = false;
      }
      stroke(0);
    }
    else
    {
      fill(150);
      stroke(50);
    }
    strokeWeight(4);
    rect(this.xPos,this.yPos,this.bWidth,this.bHeight);
    
    //Text
    if(this.active)
      fill(0);
    else
      fill(50);
    rectMode(CENTER);
    textSize(36);
    textAlign(CENTER,CENTER);
    text(text,this.xPos, this.yPos);
  }
  
  //GETTERS
  float getXPos(){
    return this.xPos;}
  float getYPos(){
    return this.yPos;}
  float getWidth(){
    return this.bWidth;}
  float getHeight(){
    return this.bHeight;}
  boolean getHighlight(){
    return this.highlight;}
}
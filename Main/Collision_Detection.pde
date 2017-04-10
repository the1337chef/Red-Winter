//COLLISION DETECTION
//X-AXIS
PVector collision(Hitbox hBox1, Hitbox hBox2, float xChange,float yChange, float collide, float hBox2Angle)
{
  PVector change = new PVector(xChange, yChange, collide);
  
  //NOT ROTATED
  if(hBox2Angle == 0)
  {
    //X-COLLISION
    if(hBox2.getHeight() > hBox1.getHeight())        //Adjustment for size difference between hitboxes
    {
      Hitbox temp = hBox1;
      hBox1 = hBox2; //did you switch so the one with the larger height is hBox1
      hBox2 = temp;
      //xChange = -xChange;
    }
    //the above will affect the xchange because it is assigned to the wrong box
    if((hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2) && //top of first is bigger than the bottom of second
      (hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2) && //bottom of first is smaller than the top of the second
      (hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 + xChange) && //right of first is larger than left of second with change
      (hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2 + xChange)) //left of first will be smaller than right of second with change 
      {
        change.x = 0;
        change.z = 1;
      }
  
    //Y-COLLISION
    if(hBox2.getWidth() > hBox1.getWidth())        //Adjustment for size difference between hitboxes
    {
      Hitbox temp = hBox1;
      hBox1 = hBox2;
      hBox2 = temp;
      //yChange = -yChange;
    }
    if((hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 &&
      hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2) &&
      (hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2 + yChange &&
      hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2 + yChange))
      {
        change.y = 0;
        change.z = 1;
      }
  }
  else
  {
    float diagonal = sqrt(pow(hBox1.getWidth()/2,2)+pow(hBox1.getHeight()/2,2));
    //X-CORNER-COLLISION
    if(hBox2.getYPos() == hBox1.getYPos() &&
      hBox1.getXPos() + hBox1.getWidth()/2 >= hBox2.getXPos() - hBox2.getWidth()/2 + xChange &&
      hBox1.getXPos() - hBox1.getWidth()/2 <= hBox2.getXPos() + hBox2.getWidth()/2 + xChange)
      {
        change.x = 0;
        change.z = 1;
      }
    //Y-CORNER-COLLISION
    if(hBox2.getXPos() == hBox1.getXPos() &&
      hBox1.getYPos() + hBox1.getHeight()/2 >= hBox2.getYPos() - hBox2.getHeight()/2 + yChange &&
      hBox1.getYPos() - hBox1.getHeight()/2 <= hBox2.getYPos() + hBox2.getHeight()/2 + yChange)
      {
        change.y = 0;
        change.z = 1;
      }
    //NE-COLLISION
    if(abs((hBox2.getXPos() - hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() + hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x+0.5*speed;
        change.y = change.y-0.5*speed;
        change.z = 1;
      }
    //NW-COLLISION
    if(abs((hBox2.getXPos() + hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() + hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x-0.5*speed;
        change.y = change.y-0.5*speed;
        change.z = 1;
      }
    //SW-COLLISION
    if(abs((hBox2.getXPos() + hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() - hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x-0.5*speed;
        change.y = change.y+0.5*speed;
        change.z = 1;
      }
    //SE-COLLISION
    if(abs((hBox2.getXPos() - hBox2.getWidth()/2 + xChange) - hBox1.getXPos()) +
      abs((hBox2.getYPos() - hBox2.getHeight()/2 + yChange) - hBox1.getYPos()) < diagonal)
      {
        change.x = change.x+0.5*speed;
        change.y = change.y+0.5*speed;
        change.z = 1;
      }
  }
  return change;
}
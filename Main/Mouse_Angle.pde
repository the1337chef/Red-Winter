//Returns the angle in radians between the player and the current mouse position
float mouseAngle()
{
  float yVar;
  if(player.getYPos() < 144)
    yVar = height/2 - (((144-player.getYPos())/144) * height/2);
  else if(player.getYPos() > 410)
    yVar = height/2 + (((player.getYPos()-410)/144) * height/2);
  else
    yVar = height/2;
    
  float xVar;
  if(player.getXPos() < 256)
    xVar = width/2 - ((width/2) * ((256-player.getXPos())/256));
  else if(player.getXPos() > 864)
    xVar = width/2 + ((width/2) * ((player.getXPos()-864)/256));
  else
    xVar = width/2;
  return atan2(mouseY-yVar, mouseX-xVar);
}
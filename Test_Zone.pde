//Test Zone Method

void testZone()
{
  //Art
  zoneGround = loadImage("testZone.png");
  
  //Walls
  walls.clear();
  Wall forestWall1 = new Wall(176, 64, 352, 128, 0);
  Wall forestWall2 = new Wall(432, 48, 160, 96, 0);
  walls.add(forestWall1);
  walls.add(forestWall2);
  
  //Enemies
  
  //Pickups
  
  chapterKeys = 0;
  reqKeys = 1;
  
}
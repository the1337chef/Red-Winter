//Test Zone Method

void testZone2()
{
  //Art
  zoneGround = loadImage("zone_test_2.png");
  
  //Player position
  player.setX(560);
  player.setY(500);
  
  //Camera position
  //cameraX = (560-256);    //player position - 1/2 screen width
  //cameraY = (266);
  
  //Walls
  walls.clear();
  Wall forestWall1 = new Wall(176*scaler, 64*scaler, 352*scaler, 128*scaler, 0);
  //Wall forestWall2 = new Wall(432*scaler, 48*scaler, 160*scaler, 96*scaler, 0);
  walls.add(forestWall1);
  //walls.add(forestWall2);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
//reqKeys = 1;
  
}
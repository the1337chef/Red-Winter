//Test Zone Method

void testZone()
{
  //Art
  zoneGround = loadImage("zone_test_3.png");
  //Entance position
  
    //Player position
  player.setX(515);
  player.setY(538);
  player.movement(0,0); //recalculate the camera position because of new player location
  
  //Walls
  walls.clear();
  //Wall forestWall1 = new Wall(176*scaler, 64*scaler, 352*scaler, 128*scaler, 0);
  //Wall forestWall2 = new Wall(432*scaler, 48*scaler, 160*scaler, 96*scaler, 0);
  //walls.add(forestWall1);
  //walls.add(forestWall2);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
  //reqKeys = 1;
  
}
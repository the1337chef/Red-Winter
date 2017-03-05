//Test Zone Method

void testZone()
{
  //Art
  zoneGround = loadImage("zone_test_3.png");
  //Entance position
  
    //Player position
  player.setX(550);
  player.setY(500);
  player.movement(0,0); //recalculate the camera position because of new player location
  
  //Walls
  walls.clear();
  Wall forestWall1 = new Wall(176, 64, 352, 128, 0);
  //Wall forestWall2 = new Wall(432*scaler, 48*scaler, 160*scaler, 96*scaler, 0);
  walls.add(forestWall1);
  //walls.add(forestWall2);
  
  //Zone Transitions
  transitions.clear();
  Hitbox zone = new Hitbox(7, 288, 50, 100, 1, "Zone_Transition");
  zone.setZone("2");
  transitions.add(zone);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
  //reqKeys = 1;
  
}
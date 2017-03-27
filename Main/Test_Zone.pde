//Test Zone Method

void testZone()
{
  //Update game state
  gameState = 0;
  saveCompleted = false;
  
  //Art
  horizonView = loadImage("Ch1/Zones/horizon.png");
  zoneGround = loadImage("zone_test_3.png");
  background = loadImage("Ch1/Zones/zone1A_Background.png");
  foreground = loadImage("Ch1/Zones/zone1A_Foreground.png");
  
  
  
  //Update currentZone
  currentZone = "test";
  //Entance position
  
    //Player position
  if( pause == false){
    player.setX(96);
    player.setY(480);
    player.movement(0,0); //recalculate the camera position because of new player location
  }
  pause = false;
  
  //Walls
  walls.clear();
  Wall forestWall1 = new Wall(176, 64, 352, 128, 0);
  //Wall forestWall2 = new Wall(432*scaler, 48*scaler, 160*scaler, 96*scaler, 0);
  walls.add(forestWall1);
  //walls.add(forestWall2);
  
  //Zone Transitions
  transitions.clear();
  Hitbox zone = new Hitbox(7, 288, 50, 100, 0, "Zone_Transition");
  zone.setZone("2");
  transitions.add(zone);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
  //reqKeys = 1;
  
}
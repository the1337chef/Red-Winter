//Test Zone Method

void testZone2()
{
  //Update game state
  gameState = 0;
  saveCompleted = false;
  
  //Art
  zoneGround = loadImage("zone_test_2.png");
  horizonView = loadImage("Ch1/Zones/horizon.png");
  background = loadImage("Ch1/Zones/zone1B_Background.png");
  foreground = loadImage("Ch1/Zones/zone1B_Foreground.png");
  
  
  //Update currentZone
  currentZone = "test_2";
  
  if(pause == false){//only update at the start of a game
  //Player position
  player.setX(165);
  player.setY(46);
  player.movement(0,0); //recalculate the camera position because of new player location
  }
  pause = false;
  //Camera position
  //cameraX = (560-256);    //player position - 1/2 screen width
  //cameraY = (266);
  
  //Walls
  walls.clear();
  Wall forestWall1 = new Wall(130, 225, 150, 150, PI/4.0);
  //println(176*scaler + " " + 64*scaler + " " + 352*scaler + " " + 128*scaler);
  //Wall forestWall2 = new Wall(432*scaler, 48*scaler, 160*scaler, 96*scaler, 0);
  walls.add(forestWall1);
  //walls.add(forestWall2);
  

  //Test Zone Transition Hitboxes
  transitions.clear();
  Hitbox testTransitionZone = new Hitbox(1060, 415, 200, 200, 0, "Zone_Transition");
  testTransitionZone.setZone("1");
  transitions.add(testTransitionZone);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
//reqKeys = 1;
  
}
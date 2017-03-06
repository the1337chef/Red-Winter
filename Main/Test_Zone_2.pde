//Test Zone Method

void testZone2()
{
  //Art
  zoneGround = loadImage("zone_test_2.png");
  
  //Update currentZone
  currentZone = "test_2";
  
  //Player position
  player.setX(63);
  player.setY(289);
  player.movement(0,0); //recalculate the camera position because of new player location
  
  //Camera position
  //cameraX = (560-256);    //player position - 1/2 screen width
  //cameraY = (266);
  
  //Walls
  walls.clear();
  Wall forestWall1 = new Wall(100, 100, 100, 100, PI/4);
  //println(176*scaler + " " + 64*scaler + " " + 352*scaler + " " + 128*scaler);
  //Wall forestWall2 = new Wall(432*scaler, 48*scaler, 160*scaler, 96*scaler, 0);
  walls.add(forestWall1);
  //walls.add(forestWall2);
  

  //Test Zone Transition Hitboxes
  transitions.clear();
  Hitbox testTransitionZone = new Hitbox(494, 526, 100, 50, 0, "Zone_Transition");
  testTransitionZone.setZone("1");
  transitions.add(testTransitionZone);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
//reqKeys = 1;
  
}
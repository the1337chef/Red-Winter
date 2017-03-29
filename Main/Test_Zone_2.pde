//Test Zone Method

float pi4 = PI/4.0;

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
  Wall forestWall1 = new Wall(120, 235, 150, 150, pi4);
  Wall forestWall2 = new Wall(263, 0, 75, 75, pi4);
  Wall forestWall3 = new Wall(326, 27, 127, 55, 0);
  Wall forestWall4 = new Wall(542, 0, 290, 290, pi4);
  Wall forestWall5 = new Wall(622, 177, 163, 56, 0);
  Wall forestWall6 = new Wall(800, 194, 150, 150, pi4);
  Wall forestWall7 = new Wall(863, 275, 126, 49, 0);
  Wall forestWall8 = new Wall(960, 296, 50, 50, pi4);
  Wall forestWall9 = new Wall(15, 20, 30, 50, 0);
  Wall forestWall10 = new Wall(20, 70, 60, 60, pi4);
  Wall forestWall11 = new Wall(40, 93, 45, 45, 0);
  Wall forestWall12 = new Wall(61, 132, 45, 45, pi4);
  Wall forestWall13 = new Wall(100, 149, 40, 40, 0);
  Wall forestWall14 = new Wall(245, 250, 80, 40, 0);
  Wall forestWall15 = new Wall(285, 272, 60, 60, pi4);
  Wall forestWall16 = new Wall(345, 282, 80, 40, 0);
  Wall forestWall17 = new Wall(384, 290, 40, 40, pi4);
  Wall forestWall18 = new Wall(420, 305, 50, 30, 0);
  Wall forestWall19 = new Wall(445, 330, 50, 50, pi4);
  Wall forestWall20 = new Wall(515, 340, 120, 30, 0);
  Wall forestWall21 = new Wall(575, 354, 40, 40, pi4);
  Wall forestWall22 = new Wall(630, 375, 80, 40, 0);
  Wall forestWall23 = new Wall(670, 383, 40, 40, pi4);
  Wall forestWall24 = new Wall(712, 405, 40, 40, 0);
  Wall forestWall25 = new Wall(731, 448, 85, 85, pi4);
  Wall forestWall26 = new Wall(809, 471, 40, 40, 0);
  Wall forestWall27 = new Wall(830, 478, 40, 40, pi4);
  Wall forestWall28 = new Wall(910, 500, 120, 40, 0);
  walls.add(forestWall1);
  walls.add(forestWall2);
  walls.add(forestWall3);
  walls.add(forestWall4);
  walls.add(forestWall5);
  walls.add(forestWall6);
  walls.add(forestWall7);
  walls.add(forestWall8);
  walls.add(forestWall9);
  walls.add(forestWall10);
  walls.add(forestWall11);
  walls.add(forestWall12);
  walls.add(forestWall13);
  walls.add(forestWall14);
  walls.add(forestWall15);
  walls.add(forestWall16);
  walls.add(forestWall17);
  walls.add(forestWall18);
  walls.add(forestWall19);
  walls.add(forestWall20);
  walls.add(forestWall21);
  walls.add(forestWall22);
  walls.add(forestWall23);
  walls.add(forestWall24);
  walls.add(forestWall25);
  walls.add(forestWall26);
  walls.add(forestWall27);
  walls.add(forestWall28);

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
  
void loadZone(){
  switch(nextZone){
    case "1":
      testZone();
      break;
    case "2":
      testZone2();
      break;
    default:
      println("ERROR: nextZone == NULL");
      break;
  }
  
  
  
   //Update game state
  //gameState = 0;
  //saveCompleted = false;
  
  //Art
  //horizonView = loadImage("Ch1/Zones/horizon.png");
  //zoneGround = loadImage("zone_test_3.png");
  //background = loadImage("Ch1/Zones/zone1A_Background.png");
  //foreground = loadImage("Ch1/Zones/zone1A_Foreground.png");
  
  
  
  //Update currentZone
  //currentZone = "1";
  //Entance position
  
    //Player position
  //if( pause == false){
  //  player.setX(96);
  //  player.setY(480);
  //  player.movement(0,0); //recalculate the camera position because of new player location
  //}
  //pause = false;
  
  //Walls
  //walls.clear();
  //Wall forestWall1 = new Wall(563, 403, 610, 70, 0);
  //Wall forestWall2 = new Wall(995, 441, 200, 60, 0);
  //Wall forestWall3 = new Wall(897, 426, 60, 60, PI/4.0);
  //Wall forestWall4 = new Wall(258, 389, 70, 70, PI/4.0);
  //Wall forestWall5 = new Wall(127, 385, 70, 20, 0);
  //Wall forestWall6 = new Wall(193, 379, 70, 70, PI/4.0);
  //Wall forestWall7 = new Wall(43, 395, 73, 73, PI/4.0);
  //Wall forestWall8 = new Wall(43, 550, 140, 140, PI/4.0);
  //Wall forestWall9 = new Wall(1100, 472, 50, 50, PI/4.0);
  //walls.add(forestWall1);
  //walls.add(forestWall2);
  //walls.add(forestWall3);
  //walls.add(forestWall4);
  //walls.add(forestWall5);
  //walls.add(forestWall6);
  //walls.add(forestWall7);
  //walls.add(forestWall8);
  //walls.add(forestWall9);
  
  //Zone Transitions
  //transitions.clear();
  //Hitbox zone = new Hitbox(1034, 534, 180, 50, 0, "Zone_Transition");
  //zone.setZone("2");
  //transitions.add(zone);
  
  //Enemies
  
  //Pickups
  
  //chapterKeys = 0;
  //reqKeys = 1;
}
  
void loadZone(){
  if(nextZone.equals("null")){
    println("ERROR: nextZone == NULL");
  }
  else if(nextZone.equals("-1")){//Zone to Cutscene
    gameState = 1;
    nextZoneChanged = false;

  }
  else if(nextZone.equals("-2")){//zone to next chapter's zone
    //playerNextX = xpos
    //ypos
    //println("nextzone is -2");
    last_cutscene = "-1";
    currentChapter = Integer.toString(Integer.parseInt(currentChapter) + 1);
    //println("currentChapter is " + currentChapter);
    nextZone = "1";
    //println("Next zone is 1 from loadzone->else if");
    gameState = 0;
    nextZoneChanged = false;
    loadZone();
    
  }
  else{
    //println("next zone is " + nextZone);
    //Update game state
    gameState = 0;
    
    saveCompleted = false;
    
    //Landscape
    horizonView = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Horizon.png");
    background = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Background.png");
    foreground = loadImage("Ch" + currentChapter + "/Zones/" + nextZone + "_Foreground.png");
    
    currentZone = nextZone;
   
    
    //Walls
    walls.clear();
    int currentCh = Integer.parseInt(currentChapter);
    int nextZ = Integer.parseInt(nextZone);
    Chapter thisChapter = chapters.get(currentCh-1);
    
    
    Zone thisZone = thisChapter.getZones().get(nextZ - 1);
    ArrayList <Wall> thisWall =  thisZone.getWalls();
    
    for(int i = 0; i < thisWall.size(); i++){
      walls.add(thisWall.get(i));
    }

    //transitions
    transitions.clear();
    ArrayList <Hitbox> thisTransitions = thisZone.getTransitionZones();
    for(int i = 0; i < thisTransitions.size(); i++){
      transitions.add(thisTransitions.get(i));
    }
    
    //Enemies
  
    //Pickups
    pickups.clear();
    ArrayList <Pickup> thisPickup = thisZone.getPickups();
    for(int i = 0; i < thisPickup.size(); i++){
      pickups.add(thisPickup.get(i));
    }
    
    //chapterKeys = 0;
    //reqKeys = 1;
    
        //Player position
    if( pause == false){
      player.setX(nextPlayerX);
      player.setY(nextPlayerY);
      player.movement(0,0); //recalculate the camera position because of new player location
    }
    pause = false;

  }

}

  
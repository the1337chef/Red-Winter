//Configure Chapter
ArrayList<Chapter> chapters = new ArrayList<Chapter>();
Chapter chapter1 = new Chapter("1");
Chapter chapter2 = new Chapter("2");

void configureChapter(Chapter chapter) {

  //loadreader for scene configure
  BufferedReader reader = createReader("Ch" + chapter.getId() + "/" + "sceneConfigure.txt");

  try
  {
    String line1 = reader.readLine().substring(13);
    int numOfCutScenes = Integer.parseInt(line1);




    for (int i = 0; i < numOfCutScenes; i++) { //For each cutscene
      //skip comment
      reader.readLine();
      String sceneNum = Integer.toString(i+1);
      String nextZone = reader.readLine().substring(9);
      float nextXPos = Float.parseFloat(reader.readLine().substring(12));
      float nextYPos = Float.parseFloat(reader.readLine().substring(12));
      int subScenes = Integer.parseInt(reader.readLine().substring(13));
      CutScene cutscene = new CutScene( sceneNum, subScenes, nextZone);
      cutscene.setNextXPos(nextXPos);
      cutscene.setNextYPos(nextYPos);
      chapter.addCutScene(cutscene);

      //skip comment
      reader.readLine();

      //layers
      for (int j = 0; j < subScenes; j++) {
        String line = reader.readLine().substring(0);
        int layer = Integer.parseInt(line);
        chapter.cutScenes.get(i).addLayer(layer);
      }

      //skip comment
      reader.readLine();

      //sounds
      for (int j = 0; j < subScenes; j++) {
        int sound = Integer.parseInt(reader.readLine().substring(0));
        chapter.cutScenes.get(i).addSound(sound);
      }

      //skip comment
      reader.readLine();

      //duration
      for (int k = 0; k < subScenes; k++) {
        float duration = Float.parseFloat(reader.readLine().substring(0));
        chapter.cutScenes.get(i).addDuration(duration);
      }
    }

    //skip line
    reader.readLine();
  }
  catch(IOException e)
  {
    println("Failed to load scenes");
    e.printStackTrace();
  }
  
  //loadreader for zoneConfigure
  reader = createReader("Ch" + chapter.getId() + "/" + "zoneConfigure.txt");

  try
  {
    String line1 = reader.readLine().substring(9); //#ofzones
    int numOfZones = Integer.parseInt(line1);

    for (int i = 0; i < numOfZones; i++) { //For each zone
      String zoneNum = Integer.toString(i+1);
      Zone newZone = new Zone(zoneNum);
      
      //skip comment
      reader.readLine();
      int numOfTransitions = Integer.parseInt(reader.readLine().substring(15));
      

      //transitions
      for (int j = 0; j < numOfTransitions; j++) {
        //skip comment transition #
        reader.readLine();
        String line = reader.readLine().substring(2);
        int x = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        int y = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        int w = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        int h = Integer.parseInt(line);
        line = reader.readLine().substring(2);
        float r;
        if(line.equals("pi4")){
          r = PI/4.0;
        }
        else{
          r = Float.parseFloat(line);
        }
        line = reader.readLine().substring(9);//nextzone
        String transitionToZone = line;
        line = reader.readLine().substring(12);//nextPlayerX
        float nextPlayerXPosition = Integer.parseInt(line);
        line = reader.readLine().substring(12);//nextPlayerY
        float nextPlayerYPosition = Integer.parseInt(line);
        Hitbox newTransition = new Hitbox(x,y,w,h,r, "zone_transition");
        newTransition.setZone(transitionToZone);
        newTransition.setNextXPos(nextPlayerXPosition);
        newTransition.setNextYPos(nextPlayerYPosition);
        newZone.addTransitionZone(newTransition);
      }
      //walls

      //skip comment walls
      reader.readLine();
      
      int numOfWalls = Integer.parseInt(reader.readLine().substring(9));
      
      for (int j = 0; j < numOfWalls; j++) {
        //skip comment walls
        reader.readLine();
        int x =  Integer.parseInt(reader.readLine().substring(2));
        int y =  Integer.parseInt(reader.readLine().substring(2));
        int w =  Integer.parseInt(reader.readLine().substring(2));
        int h =  Integer.parseInt(reader.readLine().substring(2));
        String line = reader.readLine().substring(2);
        float r;
        if(line.equals("pi4")){
          r = PI/4.0;
        }
        else{
          r = Float.parseFloat(line);
        }
        Wall newWall = new Wall( x, y, w, h, r);
        newZone.addWall(newWall);
      }
      
      //Pickups
      
      //skip comment pickups
      reader.readLine();
      
      int numOfPickups = Integer.parseInt(reader.readLine().substring(11));
      
      for(int j = 0; j < numOfPickups; j++){
        //skip comment pickup
        reader.readLine();
        int x =  Integer.parseInt(reader.readLine().substring(2));
        int y =  Integer.parseInt(reader.readLine().substring(2));
        int w =  Integer.parseInt(reader.readLine().substring(2));
        int h =  Integer.parseInt(reader.readLine().substring(2));
        String line = reader.readLine().substring(3);
        
        Key newKey = new Key(x, y, w, h, line);
        newZone.addPickup(newKey);
      }
      
      //Enemies
      
      //skip comment enemies
      reader.readLine();
      
      int numOfEnemies = Integer.parseInt(reader.readLine().substring(11));
      for(int j = 0; j < numOfEnemies; j++){
        //skip comment enemy
        reader.readLine();
        int x =  Integer.parseInt(reader.readLine().substring(2));
        int y =  Integer.parseInt(reader.readLine().substring(2));
        int p =  Integer.parseInt(reader.readLine().substring(2));
        
        Enemy newEnemy = new Enemy(x, y, 0, 100, peopleSize/2, peopleSize/2, PI/2, 150, p);
        newZone.addEnemy(newEnemy);
      }
      chapter.addZone(newZone);
    }
    
    //int size = chapter.getZones().size();
    //for(int i = 0; i < size; i++){
    //  chapter.getZones().get(i).print();
    //}
    
  }
  catch(IOException e)
  {
    println("Failed to load zones");
    e.printStackTrace();
  }
  chapters.add(chapter);
}

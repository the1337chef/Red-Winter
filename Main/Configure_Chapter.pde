//Configure Chapter

Chapter chapter1 = new Chapter("1", 0);

void configureChapter(Chapter chapter) {

  //loadreader
  BufferedReader reader = createReader("Ch" + chapter.getId() + "/Ch" + chapter.getId() + "configure.txt");

  try
  {
    String line1 = reader.readLine().substring(13);
    int numOfCutScenes = Integer.parseInt(line1);

    int zones = Integer.parseInt(reader.readLine().substring(9));
    chapter.setZones(zones);

    //skip comment
    reader.readLine();

    for (int i = 0; i < numOfCutScenes; i++) { //For each cutscene
      String sceneNum = Integer.toString(i+1);
      String nextZone = reader.readLine().substring(9);
      int subScenes = Integer.parseInt(reader.readLine().substring(13));
      CutScene cutscene = new CutScene( sceneNum, subScenes, nextZone);
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
    println("Try Catch failed");
    e.printStackTrace();
  }
}
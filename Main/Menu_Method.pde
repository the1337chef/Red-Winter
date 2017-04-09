//Main menu method

void mainMenu()
{
  //Display background/ background animation
  background(200);
  //Display buttons
  cursor(ARROW);
  newGame.display();
  continueGame.display();
  quitGame.display();
  saveGame.display();
  printSave(saveCompleted); //Prints if recently saved
}
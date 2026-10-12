function showInstructions(loadedFrom)
{
   hideWholeMenu();
   instructionsLoadedFrom = loadedFrom;
   mainMenu.instructionsHolder.attachMovie("instructionsMenu","instructionsMenuIn",15000);
   mainMenu.instructionsHolder._alpha = 0;
   mainMenu.instructionsHolder.alphaTo(100,1.2,"easeOutSine");
}
function loadFromInstructions()
{
   switch(instructionsLoadedFrom)
   {
      case "mainMenu":
         loadWholeMenuNow();
         return;
      case "options":
         return;
      default:
         return;
   }
}

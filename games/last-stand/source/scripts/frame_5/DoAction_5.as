function endGame()
{
   trace("PLAY THE ENDING!");
   pauseGame();
   hideCrosshairs();
   _root.attachMovie("endingAnimation","endingAnim",999002);
   endingAnim._y = 11;
}

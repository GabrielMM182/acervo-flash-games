function endGame()
{
   hideCrosshairs();
   if(levelUp > 39)
   {
      _root.attachMovie("ending2_badEnding","endingAnim",999002);
      _root.endingAnim.gotoAndPlay(1);
   }
   else
   {
      _root.attachMovie("ending2_goodEnding","endingAnim",999002);
      _root.endingAnim.gotoAndPlay(1);
   }
}

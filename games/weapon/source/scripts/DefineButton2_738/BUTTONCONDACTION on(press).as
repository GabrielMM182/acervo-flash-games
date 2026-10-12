on(press){
   if(_root.g36buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 7800)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 7800 && _root.g36buy == 0)
   {
      _root.g36buy = 1;
      _root.credits -= 7800;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("g36");
   }
}

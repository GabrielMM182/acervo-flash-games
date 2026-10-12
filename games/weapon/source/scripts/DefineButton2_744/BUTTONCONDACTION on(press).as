on(press){
   if(_root.m14buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 9400)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 9400 && _root.m14buy == 0)
   {
      _root.m14buy = 1;
      _root.credits -= 9400;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("m14");
   }
}

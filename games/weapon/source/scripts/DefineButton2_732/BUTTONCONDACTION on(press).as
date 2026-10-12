on(press){
   if(_root.m4buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 7200)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 7200 && _root.m4buy == 0)
   {
      _root.m4buy = 1;
      _root.credits -= 7200;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("m4");
   }
}

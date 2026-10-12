on(press){
   if(_root.kimberbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 2900)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 2900 && _root.kimberbuy == 0)
   {
      _root.kimberbuy = 1;
      _root.credits -= 2900;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("kimber");
   }
}

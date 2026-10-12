on(press){
   if(_root.scarbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 8200)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 8200 && _root.scarbuy == 0)
   {
      _root.scarbuy = 1;
      _root.credits -= 8200;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("scar");
   }
}

on(press){
   if(_root.glockhibuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 600)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 600 && _root.glockhibuy == 0)
   {
      _root.glockhibuy = 1;
      _root.credits -= 600;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("glock");
   }
}

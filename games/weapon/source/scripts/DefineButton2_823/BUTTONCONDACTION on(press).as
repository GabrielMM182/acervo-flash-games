on(press){
   if(_root.tmphibuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 600)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 600 && _root.tmphibuy == 0)
   {
      _root.tmphibuy = 1;
      _root.credits -= 600;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("tmp");
   }
}

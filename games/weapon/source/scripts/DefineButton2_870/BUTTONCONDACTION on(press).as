on(press){
   if(_root.l85barrelbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 300)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 300 && _root.l85barrelbuy == 0)
   {
      _root.l85barrelbuy = 1;
      _root.credits -= 300;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("L85");
   }
}

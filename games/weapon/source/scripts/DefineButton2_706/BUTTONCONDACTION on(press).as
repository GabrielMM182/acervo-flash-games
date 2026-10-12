on(press){
   if(_root.pbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 3000)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 3000 && _root.pbuy == 0)
   {
      _root.pbuy = 1;
      _root.credits -= 3000;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("p");
   }
}

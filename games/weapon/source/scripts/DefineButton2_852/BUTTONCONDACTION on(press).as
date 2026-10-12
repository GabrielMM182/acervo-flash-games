on(press){
   if(_root.mp5navybuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 200)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 200 && _root.mp5navybuy == 0)
   {
      _root.mp5navybuy = 1;
      _root.credits -= 200;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("mp5");
   }
}

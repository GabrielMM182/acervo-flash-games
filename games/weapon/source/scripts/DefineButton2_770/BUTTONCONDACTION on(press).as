on(press){
   if(_root.belt1buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 550)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 550 && _root.belt1buy == 0)
   {
      _root.belt1buy = 1;
      _root.credits -= 550;
      _root.creditflash.gotoAndPlay(2);
   }
}

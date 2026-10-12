on(press){
   if(_root.l85buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 7500)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 7500 && _root.l85buy == 0)
   {
      _root.l85buy = 1;
      _root.credits -= 7500;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("l85");
   }
}

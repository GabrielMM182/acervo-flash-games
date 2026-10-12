on(press){
   if(_root.ak2buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 6000)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 6000 && _root.ak2buy == 0)
   {
      _root.ak2buy = 1;
      _root.credits -= 6000;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("ak2");
   }
}

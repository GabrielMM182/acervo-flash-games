on(press){
   if(_root.tmpbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 3600)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 3600 && _root.tmpbuy == 0)
   {
      _root.tmpbuy = 1;
      _root.credits -= 3600;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("tmp");
   }
}

on(press){
   if(_root.credits < 5000)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 5000)
   {
      _root.a10s++;
      _root.credits -= 5000;
      _root.creditflash.gotoAndPlay(2);
   }
}

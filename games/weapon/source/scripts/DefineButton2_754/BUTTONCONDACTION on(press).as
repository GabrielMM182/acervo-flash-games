on(press){
   if(_root.credits < 200)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 200)
   {
      _root.grenades++;
      _root.credits -= 200;
      _root.creditflash.gotoAndPlay(2);
   }
}

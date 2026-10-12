on(press){
   if(_root.credits >= 400)
   {
      _root.credits -= 400;
      _root.smags += 3;
      _root.mags += 3;
      _root.pauses = false;
      gotoAndStop(1);
   }
}

on(release){
   pressing = false;
   if(pressed)
   {
      _parent.clipHolder.stop();
      _parent.go = false;
      _parent.pausePlay.gotoAndStop(2);
   }
   else if(_parent.go)
   {
      _parent.clipHolder.play();
      _parent.pausePlay.gotoAndStop(1);
   }
   else
   {
      _parent.clipHolder.stop();
      _parent.pausePlay.gotoAndStop(2);
   }
}

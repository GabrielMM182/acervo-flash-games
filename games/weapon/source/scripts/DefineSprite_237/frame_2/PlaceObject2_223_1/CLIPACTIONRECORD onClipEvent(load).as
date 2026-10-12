onClipEvent(load){
   if(_parent.shotStart == true && _parent.rocket == true)
   {
      this.gotoAndPlay(10);
   }
   else if(_parent.shotStart == true && _parent.rocket == false)
   {
      this.gotoAndPlay(50);
   }
   else
   {
      this.gotoAndPlay(1);
   }
}

onClipEvent(enterFrame){
   if(_root.mp5rail == false)
   {
      this.gotoAndStop(1);
   }
   else
   {
      this.gotoAndStop(2);
   }
}

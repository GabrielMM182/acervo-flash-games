onClipEvent(enterFrame){
   if(_root.ak2laser == false)
   {
      this.gotoAndStop(1);
   }
   else
   {
      this.gotoAndStop(2);
   }
}

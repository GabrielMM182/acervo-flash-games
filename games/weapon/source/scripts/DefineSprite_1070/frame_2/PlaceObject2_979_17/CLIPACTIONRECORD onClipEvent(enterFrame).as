onClipEvent(enterFrame){
   if(_root.m4sil == true && _root.m4barrel == false)
   {
      this.gotoAndStop(2);
   }
   else if(_root.m4sil == true && _root.m4barrel == true)
   {
      this.gotoAndStop(3);
   }
   else
   {
      this.gotoAndStop(1);
   }
}

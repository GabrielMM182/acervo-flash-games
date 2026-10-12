onClipEvent(enterFrame){
   if(_root.m14sil == true && _root.m14socom == true)
   {
      this.gotoAndStop(3);
   }
   else if(_root.m14sil == true && _root.m14socom == false)
   {
      this.gotoAndStop(2);
   }
   else if(_root.m14sil == false)
   {
      this.gotoAndStop(1);
   }
}

onClipEvent(enterFrame){
   if(_root.l85sil == true && _root.l85vgrip == false)
   {
      this.gotoAndStop(2);
   }
   else if(_root.l85sil == true && _root.l85vgrip == true)
   {
      this.gotoAndStop(3);
   }
   else
   {
      this.gotoAndStop(1);
   }
}

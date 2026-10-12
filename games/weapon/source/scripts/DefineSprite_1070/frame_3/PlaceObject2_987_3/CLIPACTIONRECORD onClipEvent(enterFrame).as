onClipEvent(enterFrame){
   if(_root.mp5grip == 0)
   {
      this.gotoAndStop(1);
   }
   else if(_root.mp5grip == 1)
   {
      this.gotoAndStop(2);
   }
   else if(_root.mp5grip == 2)
   {
      this.gotoAndStop(3);
   }
}

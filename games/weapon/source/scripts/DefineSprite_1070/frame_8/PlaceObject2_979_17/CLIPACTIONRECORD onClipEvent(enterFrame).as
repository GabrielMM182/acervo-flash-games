onClipEvent(enterFrame){
   if(_root.scarsil == true && _root.scarbarrel == false)
   {
      this.gotoAndStop(2);
   }
   else if(_root.scarsil == true && _root.scarbarrel == true)
   {
      this.gotoAndStop(3);
   }
   else
   {
      this.gotoAndStop(1);
   }
}

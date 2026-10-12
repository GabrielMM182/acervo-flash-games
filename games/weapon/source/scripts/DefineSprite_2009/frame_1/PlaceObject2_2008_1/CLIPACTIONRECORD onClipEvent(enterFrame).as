onClipEvent(enterFrame){
   this.health.gotoAndStop(_root.deltahealth * 4);
   if(_root.deltahealth <= 0 && _root.deltaon == true)
   {
      this.gotoAndStop("death");
   }
}

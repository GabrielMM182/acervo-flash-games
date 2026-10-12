onClipEvent(enterFrame){
   this.health = _root.health;
   if(_root.health <= 0)
   {
      _root.gotoAndStop("ending");
   }
}

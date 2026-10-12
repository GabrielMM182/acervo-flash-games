onClipEvent(enterFrame){
   if(_root.Scene.Cook._currentFrame > 31 or _root.DishReady)
   {
      _visible = true;
      gotoAndStop(_root.Scene.Cook.Type);
   }
   else
   {
      _visible = false;
   }
   if(_root.DishReady)
   {
      Wait._visible = false;
   }
   else
   {
      Wait._visible = true;
   }
}

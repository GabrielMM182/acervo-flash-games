onClipEvent(enterFrame){
   if(Key.isDown(81))
   {
      if(_root.primary == "empty")
      {
         _root.hud.gundisplay.play();
         _root.gun.gotoAndStop(_root.secondary);
      }
      if(_root.secondary == "empty")
      {
         _root.hud.gundisplay.play();
         _root.gun.gotoAndStop(_root.primary);
      }
   }
}

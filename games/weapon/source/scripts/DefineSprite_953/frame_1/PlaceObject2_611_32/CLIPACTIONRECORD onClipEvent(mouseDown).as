onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.uspbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeusp");
      }
      else
      {
         _root.loadout.store.gotoAndStop("usp");
      }
   }
}

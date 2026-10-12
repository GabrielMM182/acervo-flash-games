onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.scarbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storescar");
      }
      else
      {
         _root.loadout.store.gotoAndStop("scar");
      }
   }
}

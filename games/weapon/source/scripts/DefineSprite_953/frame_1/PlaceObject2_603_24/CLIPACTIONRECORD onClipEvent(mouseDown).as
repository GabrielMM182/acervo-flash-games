onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glockbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeglock");
      }
      else
      {
         _root.loadout.store.gotoAndStop("glock");
      }
   }
}

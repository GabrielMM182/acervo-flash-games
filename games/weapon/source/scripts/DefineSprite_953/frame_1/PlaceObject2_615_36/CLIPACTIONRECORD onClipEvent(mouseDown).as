onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.mp5buy == 0)
      {
         _root.loadout.store.gotoAndStop("storemp5");
      }
      else
      {
         _root.loadout.store.gotoAndStop("mp5");
      }
   }
}

onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.umpbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeump");
      }
      else
      {
         _root.loadout.store.gotoAndStop("ump");
      }
   }
}

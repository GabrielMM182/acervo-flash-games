onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.tmpbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storetmp");
      }
      else
      {
         _root.loadout.store.gotoAndStop("tmp");
      }
   }
}

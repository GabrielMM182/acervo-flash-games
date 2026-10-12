onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.macbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storemac");
      }
      else
      {
         _root.loadout.store.gotoAndStop("mac");
      }
   }
}

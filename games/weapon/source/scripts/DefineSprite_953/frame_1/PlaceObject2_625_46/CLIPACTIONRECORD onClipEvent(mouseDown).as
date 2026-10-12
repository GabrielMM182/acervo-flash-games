onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.l85buy == 0)
      {
         _root.loadout.store.gotoAndStop("storel85");
      }
      else
      {
         _root.loadout.store.gotoAndStop("l85");
      }
   }
}

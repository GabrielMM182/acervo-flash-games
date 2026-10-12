onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.ak2buy == 0)
      {
         _root.loadout.store.gotoAndStop("storeak2");
      }
      else
      {
         _root.loadout.store.gotoAndStop("ak2");
      }
   }
}

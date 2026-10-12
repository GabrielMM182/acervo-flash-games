onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.g36buy == 0)
      {
         _root.loadout.store.gotoAndStop("storeg36");
      }
      else
      {
         _root.loadout.store.gotoAndStop("g36");
      }
   }
}

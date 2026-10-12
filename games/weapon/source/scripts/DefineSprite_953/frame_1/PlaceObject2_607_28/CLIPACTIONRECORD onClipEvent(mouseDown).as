onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.kimberbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storekimber");
      }
      else
      {
         _root.loadout.store.gotoAndStop("kimber");
      }
   }
}

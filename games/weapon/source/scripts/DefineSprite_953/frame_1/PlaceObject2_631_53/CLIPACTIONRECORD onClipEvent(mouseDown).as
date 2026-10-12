onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.m14buy == 0)
      {
         _root.loadout.store.gotoAndStop("storem14");
      }
      else
      {
         _root.loadout.store.gotoAndStop("m14");
      }
   }
}

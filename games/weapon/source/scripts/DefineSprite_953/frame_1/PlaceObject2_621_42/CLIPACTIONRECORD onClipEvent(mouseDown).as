onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.m4buy == 0)
      {
         _root.loadout.store.gotoAndStop("storem4");
      }
      else
      {
         _root.loadout.store.gotoAndStop("m4");
      }
   }
}

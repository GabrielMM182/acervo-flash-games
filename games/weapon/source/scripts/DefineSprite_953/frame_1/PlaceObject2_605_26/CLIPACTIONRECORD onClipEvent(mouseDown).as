onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.m9buy == 0)
      {
         _root.loadout.store.gotoAndStop("storem9");
      }
      else
      {
         _root.loadout.store.gotoAndStop("m9");
      }
   }
}

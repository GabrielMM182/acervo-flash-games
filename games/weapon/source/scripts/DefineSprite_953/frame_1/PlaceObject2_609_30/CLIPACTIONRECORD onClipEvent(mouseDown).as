onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.pbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storep");
      }
      else
      {
         _root.loadout.store.gotoAndStop("p");
      }
   }
}

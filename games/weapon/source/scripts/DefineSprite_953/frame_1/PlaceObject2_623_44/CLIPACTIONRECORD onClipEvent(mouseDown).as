onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.akbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeak");
      }
      else
      {
         _root.loadout.store.gotoAndStop("ak");
      }
   }
}

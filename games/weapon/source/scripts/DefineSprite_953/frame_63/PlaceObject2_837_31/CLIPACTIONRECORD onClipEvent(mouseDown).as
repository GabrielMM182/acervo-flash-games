onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.gripbuy == 1)
      {
         if(_root.scarvgrip == false)
         {
            _root.scarvgrip = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.scarvgrip == true)
         {
            _root.scarvgrip = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.gripbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storegrip");
      }
   }
}

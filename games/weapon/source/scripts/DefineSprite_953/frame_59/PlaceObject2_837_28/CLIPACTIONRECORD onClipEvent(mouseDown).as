onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.gripbuy == 1)
      {
         if(_root.akvgrip == false)
         {
            _root.akvgrip = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.akvgrip == true)
         {
            _root.akvgrip = false;
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

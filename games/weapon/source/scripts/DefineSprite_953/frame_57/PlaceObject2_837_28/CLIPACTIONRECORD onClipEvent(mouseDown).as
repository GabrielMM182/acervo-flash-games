onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.gripbuy == 1)
      {
         if(_root.umpvgrip == false)
         {
            _root.umpvgrip = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.umpvgrip == true)
         {
            _root.umpvgrip = false;
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

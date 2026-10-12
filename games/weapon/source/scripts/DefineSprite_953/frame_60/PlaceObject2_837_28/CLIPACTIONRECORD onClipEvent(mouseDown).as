onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.gripbuy == 1)
      {
         if(_root.m4grip == false)
         {
            _root.m4grip = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m4grip == true)
         {
            _root.m4grip = false;
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

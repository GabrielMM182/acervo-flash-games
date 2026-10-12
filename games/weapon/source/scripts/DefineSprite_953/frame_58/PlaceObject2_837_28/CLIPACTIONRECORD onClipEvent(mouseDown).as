onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.gripbuy == 1)
      {
         if(_root.ak2vgrip == false)
         {
            _root.ak2vgrip = true;
            _root.ak2grip = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.ak2vgrip == true)
         {
            _root.ak2vgrip = false;
            _root.ak2grip = false;
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

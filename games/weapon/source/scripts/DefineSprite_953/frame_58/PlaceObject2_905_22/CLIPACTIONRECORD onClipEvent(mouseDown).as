onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.aimpointbuy == 1)
      {
         if(_root.ak2sight !== 3)
         {
            _root.ak2sight = 3;
            _root.ak2rail = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.ak2sight == 3)
         {
            _root.ak2sight = 0;
            _root.ak2rail = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.aimpointbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeaimpoint");
      }
   }
}

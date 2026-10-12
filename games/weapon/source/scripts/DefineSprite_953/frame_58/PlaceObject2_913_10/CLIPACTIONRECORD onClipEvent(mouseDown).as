onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.acogbuy == 1)
      {
         if(_root.ak2sight !== 2)
         {
            _root.ak2sight = 2;
            _root.ak2rail = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.ak2sight == 2)
         {
            _root.ak2sight = 0;
            _root.ak2rail = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.acogbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeacog");
      }
   }
}

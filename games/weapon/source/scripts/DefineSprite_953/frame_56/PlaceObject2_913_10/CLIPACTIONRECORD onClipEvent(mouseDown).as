onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.acogbuy == 1)
      {
         if(_root.mp5sight !== 2)
         {
            _root.mp5sight = 2;
            _root.mp5rail = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.mp5sight == 2)
         {
            _root.mp5sight = 0;
            _root.mp5rail = false;
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

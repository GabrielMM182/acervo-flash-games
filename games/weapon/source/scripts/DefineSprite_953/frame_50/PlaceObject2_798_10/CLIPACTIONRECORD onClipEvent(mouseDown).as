onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glocklambuy == 1)
      {
         if(_root.glocklam == false)
         {
            _root.glocklam = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.glocklam == true)
         {
            _root.glocklam = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.glocklambuy == 0)
      {
         _root.loadout.store.gotoAndStop("storepistollam");
      }
   }
}

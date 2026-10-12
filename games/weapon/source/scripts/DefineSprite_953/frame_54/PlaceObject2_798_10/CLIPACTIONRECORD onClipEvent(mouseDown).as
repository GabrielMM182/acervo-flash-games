onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glocklambuy == 1)
      {
         if(_root.usplam == false)
         {
            _root.usplam = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.usplam == true)
         {
            _root.usplam = false;
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

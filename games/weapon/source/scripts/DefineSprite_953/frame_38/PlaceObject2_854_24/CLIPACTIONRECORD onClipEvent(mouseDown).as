onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.mp5navybuy == 1)
      {
         if(_root.grip !== 1)
         {
            _root.mp5grip = 1;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.mp5grip == 1)
         {
            _root.mp5grip = 0;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.mp5navybuy == 0)
      {
         _root.loadout.store.gotoAndStop("storemp5navy");
      }
   }
}

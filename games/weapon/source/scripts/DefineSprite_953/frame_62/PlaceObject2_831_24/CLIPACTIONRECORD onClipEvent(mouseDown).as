onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.tmplaserbuy == 1)
      {
         if(_root.g36laser == false)
         {
            _root.g36laser = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.g36laser == true)
         {
            _root.g36laser = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.tmplaserbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storelaser");
      }
   }
}

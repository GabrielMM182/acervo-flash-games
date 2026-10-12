onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.tmplaserbuy == 1)
      {
         if(_root.umplaser == false)
         {
            _root.umplaser = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.umplaser == true)
         {
            _root.umplaser = false;
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

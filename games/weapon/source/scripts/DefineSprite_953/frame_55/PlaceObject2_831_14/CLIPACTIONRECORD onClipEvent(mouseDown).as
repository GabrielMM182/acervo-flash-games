onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.tmplaserbuy == 1)
      {
         if(_root.tmplaser == false)
         {
            _root.tmplaser = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.tmplaser == true)
         {
            _root.tmplaser = false;
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

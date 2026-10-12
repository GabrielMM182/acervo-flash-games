onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.tmplaserbuy == 1)
      {
         if(_root.ak2laser == false)
         {
            _root.ak2laser = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.ak2laser == true)
         {
            _root.ak2laser = false;
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

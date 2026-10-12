onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.reflexbuy == 1 && _root.mp5sight !== 4)
      {
         _root.mp5sight = 4;
         _root.mp5rail = true;
         equip = new Sound();
         equip.attachSound("equip");
         equip.start();
      }
      else if(_root.reflexbuy == 1 && _root.mp5sight == 4)
      {
         _root.mp5sight = 0;
         _root.mp5rail = false;
         equip = new Sound();
         equip.attachSound("equip");
         equip.start();
      }
      else if(_root.reflexbuy == 0 && _root.mp5sight == 0)
      {
         _root.loadout.store.gotoAndStop("storereflex");
      }
   }
}

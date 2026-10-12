onClipEvent(mouseDown){
   if(thisover == true)
   {
      _root.glockbuy = 1;
      _root.secondary = "glock";
      _root.loadout.gotoAndStop(2);
      _root.loadout.store.gotoAndStop("glock");
      equip = new Sound();
      equip.attachSound("equip");
      equip.start();
      _root.callsign = _root.messages.callsigner.callsign;
      _root.messages.gotoAndStop(11);
   }
}

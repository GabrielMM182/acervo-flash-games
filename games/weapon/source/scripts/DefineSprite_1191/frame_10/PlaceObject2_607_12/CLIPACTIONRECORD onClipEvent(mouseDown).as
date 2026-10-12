onClipEvent(mouseDown){
   if(thisover == true)
   {
      _root.kimberbuy = 1;
      _root.secondary = "kimber";
      _root.loadout.gotoAndStop(2);
      _root.loadout.store.gotoAndStop("kimber");
      equip = new Sound();
      equip.attachSound("equip");
      equip.start();
      _root.callsign = _root.messages.callsigner.callsign;
      _root.messages.gotoAndStop(11);
   }
}

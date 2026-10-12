onClipEvent(load){
   targeted = _root.depthNum;
   ammo = 20;
   newguy = false;
   if(_root.deltaon == true && _root.deltahealth > 0)
   {
      this.gotoAndStop(1);
   }
   else
   {
      this.gotoAndStop(4);
   }
}

onClipEvent(enterFrame){
   _root.accuracy = Math.round(_root.mhits / _root.shots * 100);
   if(_root.accuracy > 100)
   {
      _root.accuracy = 100;
   }
   if(_root.automatic == true)
   {
      _root.selector = "AUTO";
   }
   else
   {
      _root.selector = "SEMI";
   }
   if(_root.health < 0)
   {
      _root.health = 0;
   }
   if(_root.health > 1000)
   {
      _root.health = 1000;
   }
   this.magimg.gotoAndStop(_root.mag + 1);
   this.magsimg.gotoAndStop(_root.mags + 1);
   this.smagsimg.gotoAndStop(_root.smags + 1);
   this.shellsimg.gotoAndStop(_root.ammo12 + 1);
   this.gundisplay.gundisplayprimary.img.gotoAndStop(_root.primary);
   this.gundisplay.gundisplaysecondary.img.gotoAndStop(_root.secondary);
}

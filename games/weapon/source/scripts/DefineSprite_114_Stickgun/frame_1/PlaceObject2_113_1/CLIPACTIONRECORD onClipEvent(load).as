onClipEvent(load){
   thishealth = 3;
   speed = 0.6 + Math.random();
   xmax = random(300) + 250;
   xmaxed = false;
   ammo = 30;
   shotStart = false;
   gonum = 1 + random(2);
   if(gonum == 1)
   {
      this.gotoAndStop(1);
   }
   else
   {
      this.gotoAndStop(7);
   }
}

onClipEvent(enterFrame){
   num++;
   if(num == delay)
   {
      num = 0;
      this.attachMovie("blackhawkSmoke","blackhawkSmoke" + this.getNextHighestDepth(),this.getNextHighestDepth(),{_x:5 - random(10),_y:5 - random(10),_rotation:random(15)});
   }
}

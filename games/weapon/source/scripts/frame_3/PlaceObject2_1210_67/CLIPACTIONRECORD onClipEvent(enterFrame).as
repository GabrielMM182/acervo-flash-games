onClipEvent(enterFrame){
   this.percent = Math.round(_root.mhits / _root.mshots * 100);
   if(this.percent > 100)
   {
      this.percent = 100;
   }
}

onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      getURL("http://www.armorgames.com/", "_blank");
   };
}

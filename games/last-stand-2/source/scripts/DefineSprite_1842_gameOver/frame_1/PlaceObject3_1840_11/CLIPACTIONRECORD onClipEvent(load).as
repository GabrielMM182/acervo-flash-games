onClipEvent(load){
   this.butLabel.text = this._name;
   this.onRelease = function()
   {
      _root.mainBlackOut._visible = true;
      _root.mainBlackOut.alphaTo(100,2,"easeOutSine",0,_root.removeParentGameOverRetry);
   };
}

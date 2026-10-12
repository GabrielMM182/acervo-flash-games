onClipEvent(load){
   this.butLabel.text = "EVIL-LIVES.COM";
   this.onRelease = function()
   {
      getURL("http://www.evil-lives.com/", "_blank");
   };
}

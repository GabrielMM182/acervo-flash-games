onClipEvent(enterFrame){
   if(_parent.SendData)
   {
      getURL("http://www.sugar-free-games.com/thewaitresstopscore.php","_blank","POST");
      _parent.SendData = false;
   }
}

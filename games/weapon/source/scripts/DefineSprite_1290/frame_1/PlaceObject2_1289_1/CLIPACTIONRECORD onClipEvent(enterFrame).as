onClipEvent(enterFrame){
   if(Key.isDown(70) && _root.automatic == false)
   {
      _root.automatic = true;
      _root.gun.switcher.play();
      _root.gun.gunsel.glock.glockslide.switcher.play();
   }
   else if(Key.isDown(70) && _root.automatic == true)
   {
      _root.automatic = false;
      _root.gun.switcher.play();
      _root.gun.gunsel.glock.glockslide.switcher.play();
   }
}

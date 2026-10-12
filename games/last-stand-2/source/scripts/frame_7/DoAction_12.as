function moveCharacter()
{
   if(!Key.isDown(65) && !Key.isDown(68) && !Key.isDown(87) && !Key.isDown(83) && !Key.isDown(37) && !Key.isDown(39) && !Key.isDown(38) && !Key.isDown(40))
   {
      characterWalkAnim("idle");
   }
   if((Key.isDown(65) || Key.isDown(37)) && !blockFront.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._x -= hero.speed;
      characterWalkAnim("forward");
   }
   if((Key.isDown(68) || Key.isDown(39)) && !blockBack.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._x += hero.speed;
      characterWalkAnim("backward");
   }
   if((Key.isDown(87) || Key.isDown(38)) && !blockTop.hitTest(mainChar._x + 90,mainChar._y + 100,true) && !blockBack.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._y -= hero.speed;
      if(Key.isDown(68))
      {
         characterWalkAnim("backward");
      }
      else if(Key.isDown(65))
      {
         characterWalkAnim("forward");
      }
      else
      {
         characterWalkAnim("up");
      }
   }
   if((Key.isDown(83) || Key.isDown(40)) && !blockFront.hitTest(mainChar._x + 90,mainChar._y + 100,true) && !blockBottom.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._y += hero.speed;
      if(Key.isDown(68) || Key.isDown(39))
      {
         characterWalkAnim("backward");
      }
      else if(Key.isDown(65) || Key.isDown(37))
      {
         characterWalkAnim("forward");
      }
      else
      {
         characterWalkAnim("down");
      }
   }
   if(Key.isDown(82))
   {
      if(reloading == false && ammoInMag != _root[currentWeapon].magazineCapacity)
      {
         reloadWeapon();
      }
      if(Key.isDown(49))
      {
         _root.swapWeapon("pistol");
      }
   }
}
function characterWalkAnim(currentDirection)
{
   _root.mainChar.legs.gotoAndStop(currentDirection);
}
hero = new Object();
hero.health = 100;
hero.speed = 5;
hero.isAlive = true;
mainChar.depthSwappedWith5 = false;
keyListener = new Object();
keyListener.onKeyDown = function()
{
   if(Key.isDown(32) && switchingWeapons == false && firing == false && secondaryWeapon != null)
   {
      switchWeapons();
      handlingSound = new Sound(stageBG);
      handlingSound.attachSound("sound_switchWeapons");
      handlingSound.setVolume(100);
      handlingSound.start(0,1);
      if(_root[currentWeapon].name == "chainsaw")
      {
         chainsawSound = new Sound(stageBG);
         chainsawSound.attachSound("sound_chainsawIdle");
         chainsawSound.setVolume(100);
         chainsawSound.start(0,999);
      }
   }
   if(Key.isDown(27))
   {
      loadOptions();
   }
};
keyListener.onKeyUp = function()
{
   if(switchingWeapons == true && Key.isDown(32) == false)
   {
      switchingWeapons = false;
   }
};
Key.addListener(keyListener);
_root.mainChar.onEnterFrame = moveCharacter;

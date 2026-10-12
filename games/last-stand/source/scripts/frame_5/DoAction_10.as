function moveCharacter()
{
   if(!Key.isDown(65) && !Key.isDown(68) && !Key.isDown(87) && !Key.isDown(83))
   {
      characterWalkAnim("idle");
   }
   if(Key.isDown(65) && !blockFront.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._x -= hero.speed;
      characterWalkAnim("forward");
   }
   if(Key.isDown(68) && !blockBack.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._x += hero.speed;
      characterWalkAnim("backward");
   }
   if(Key.isDown(87) && !blockTop.hitTest(mainChar._x + 90,mainChar._y + 100,true) && !blockBack.hitTest(mainChar._x + 90,mainChar._y + 100,true))
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
   if(Key.isDown(83) && !blockFront.hitTest(mainChar._x + 90,mainChar._y + 100,true) && !blockBottom.hitTest(mainChar._x + 90,mainChar._y + 100,true))
   {
      this._y += hero.speed;
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
         trace(" ************** 1 KEY **********");
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
   if(Key.isDown(32))
   {
      switchWeapons();
   }
   if(Key.isDown(27))
   {
      trace("********** ESCAPE KEY!! **********");
      loadOptions();
   }
};
Key.addListener(keyListener);
_root.mainChar.onEnterFrame = moveCharacter;

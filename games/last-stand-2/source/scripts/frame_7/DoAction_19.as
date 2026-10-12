function chargeThrow()
{
   throwCharge++;
}
function thrownWeapon(weaponName)
{
   var _loc3_;
   var _loc4_;
   if(ammoInMag >= 1 && reloading == false)
   {
      clearInterval(chargingThrow);
      ammoInMag -= 1;
      if(_root.throwCharge >= _root.throwChargeMax)
      {
         _root.throwCharge = _root.throwChargeMax;
      }
      thrownNumber++;
      _loc3_ = _root.attachMovie(_root[currentWeapon].name,"thrown" + thrownNumber,thrownNumber + 37000);
      thrownWeaponsOnScreen.push({ref:_root["thrown" + _loc3_]});
      _loc4_ = new Object();
      _loc4_.x = mainGunRef.barrelEnd._x;
      _loc4_.y = mainGunRef.barrelEnd._y;
      mainGunRef.localToGlobal(_loc4_);
      _loc3_.grenadeGraph._rotation = random(360);
      _loc3_._x = _loc4_.x - random(50);
      _loc3_._y = _loc4_.y;
      _loc3_.angle = currentAngle - random(_root[currentWeapon].accuracy);
      _loc3_._rotation = round.angle;
      _loc3_.initGravity = false;
      _loc3_.thrownWeaponTimer = 0;
      _loc3_.onEnterFrame = function()
      {
         this.thrownWeaponTimer = this.thrownWeaponTimer + 1;
         if(this.initGravity == false)
         {
            this.ySpeed = _root.ySpeed;
            this.xSpeed = - _root.throwCharge;
            this.gravity = _root.gravity;
            this.bounce = _root.bounce;
            this.ground = _root.mainChar._y + 100;
            this.initGravity = true;
            _root.throwCharge = _root.throwChargeMin;
         }
         if(this._y < this.ground)
         {
            this.ySpeed += this.gravity;
         }
         else if(this.ySpeed > this.gravity * 4)
         {
            this._y = this.ground;
            this.ySpeed *= - this.bounce;
         }
         else
         {
            this.ySpeed = 0;
            this._y = this.ground;
         }
         this._y += this.ySpeed;
         if(this.xSpeed < 2)
         {
            this._x += this.xSpeed;
            this.xSpeed *= 0.95;
            this.grenadeGraph._rotation += random(4) + 3;
         }
         if(this.thrownWeaponTimer >= _root[currentWeapon].timer)
         {
            explosionNumber++;
            _root.attachMovie("explosion_grenade","grensplosion" + explosionNumber,explosionNumber + 48000);
            _root["grensplosion" + explosionNumber]._x = this._x;
            _root["grensplosion" + explosionNumber]._y = this._y;
            _root["grensplosion" + explosionNumber].play;
            this.thrownWeaponTimer = 0;
            _root.spawnFragments(_root[currentWeapon].frags,this._x,this._y,_root[currentWeapon].fragDistance,"frag",_root[currentWeapon].damage);
            delete this.onEnterFrame;
            removeMovieClip(this);
         }
      };
   }
}
function blowThisZombie(zombieToExplode)
{
   zombieToExplode.gotoAndPlay("exploded1");
}
thrownNumber = 0;
explosionNumber = 0;
zombieExplodeCount = 0;
throwCharge = 0;
throwChargeMin = 15;
throwChargeMax = 50;
ySpeed = -15;
xSpeed = -32;
gravity = 3;
bounce = 0.5;
ground = _root.mainChar._y + 100;

function chargeThrow()
{
   throwCharge++;
}
function thrownWeapon(weaponName)
{
   var _loc4_;
   var _loc5_;
   if(ammoInMag >= 1 && reloading == false)
   {
      clearInterval(chargingThrow);
      ammoInMag -= 1;
      if(_root.throwCharge >= _root.throwChargeMax)
      {
         _root.throwCharge = _root.throwChargeMax;
      }
      thrownNumber++;
      _loc4_ = _root.attachMovie(_root[currentWeapon].name,"thrown" + thrownNumber,thrownNumber + 37000);
      thrownWeaponsOnScreen.push({ref:_root["thrown" + _loc4_]});
      _loc5_ = new Object();
      _loc5_.x = mainGunRef.barrelEnd._x;
      _loc5_.y = mainGunRef.barrelEnd._y;
      mainGunRef.localToGlobal(_loc5_);
      _loc4_.grenadeGraph._rotation = random(360);
      _loc4_._x = _loc5_.x - random(50);
      _loc4_._y = _loc5_.y;
      _loc4_.angle = currentAngle - random(_root[currentWeapon].accuracy);
      _loc4_._rotation = round.angle;
      _loc4_.initGravity = false;
      _loc4_.thrownWeaponTimer = 0;
      _loc4_.onEnterFrame = function()
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
         var _loc3_;
         if(this.thrownWeaponTimer >= _root[currentWeapon].timer)
         {
            explosionNumber++;
            _root.attachMovie("explosion_grenade","grensplosion" + explosionNumber,explosionNumber + 48000);
            _root["grensplosion" + explosionNumber]._x = this._x;
            _root["grensplosion" + explosionNumber]._y = this._y;
            _root["grensplosion" + explosionNumber].play;
            this.thrownWeaponTimer = 0;
            for(s in aliveZombies)
            {
               zombieExplodeCount++;
               _loc3_ = Math.round(Math.sqrt((aliveZombies[s].ref._x - this._x) * (aliveZombies[s].ref._x - this._x) + (aliveZombies[s].ref._y + 20 - this._y) * (aliveZombies[s].ref._y + 20 - this._y)));
               aliveZombies[s].ref.zombieGrenProx.text = _loc3_;
               if(_loc3_ < 105)
               {
                  aliveZombies[s].health -= 1000;
                  if(aliveZombies[s].health <= 0 && aliveZombies[s].dead == false && aliveZombies[s].beingExploded == false)
                  {
                     aliveZombies[s].ref.stopTween();
                     aliveZombies[s].dead = true;
                     aliveZombies[s].beingExploded = true;
                     trace("===========================\rZOMBIE EXPLODED\r------------------------");
                     trace("Name: " + aliveZombies[s].ref);
                     trace("Dead?: " + aliveZombies[s].dead);
                     trace("BeingExploded: " + aliveZombies[s].beingExploded);
                     aliveZombies[s].ref.gotoAndPlay("exploded1");
                     trace("Name AfterAnimCall: " + aliveZombies[s].ref);
                     deathSound = new Sound(stageBG);
                     if(aliveZombies[s].type == "zombieDog")
                     {
                        deathSound.attachSound("sound_dogDeath_" + (random(5) + 1));
                     }
                     else
                     {
                        deathSound.attachSound("sound_zombieDeath_" + (random(11) + 1));
                     }
                     deathSound.setVolume(100);
                     deathSound.start(0,1);
                     zombiesKilled++;
                     aliveZombies[s].dead = true;
                     aliveZombies[s].ref.gotoAndPlay("exploded1");
                     aliveZombies.splice(s,1);
                  }
               }
            }
            delete this.onEnterFrame;
            removeMovieClip(this);
         }
      };
   }
}
function blowThisZombie(zombieToExplode)
{
   trace("BOOOM! " + zombieToExplode);
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

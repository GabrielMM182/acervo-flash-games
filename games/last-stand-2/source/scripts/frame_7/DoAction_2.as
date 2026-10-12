function addHeroToSurvivorArray()
{
   friendliesOnScreen.push({ref:mainChar,depth:mainChar._y});
   survivorOnScreenCount++;
   survivors++;
}
function gameStopStart(butName)
{
   _root[butName].onEnterFrame = function()
   {
      _root.turretControl();
      _root.collisionTest();
      _root.survivorFindTarget();
      _root.survivorWeaponFire();
      _root.checkHitsOnSurvivors();
      _root.depthSortFriendlies();
   };
}
function enemyStopStart(butName)
{
   _root[butName].onEnterFrame = function()
   {
      theZombieDirector(currentZombieThreat);
   };
}
function pauseGame()
{
   if(gamePaused == true)
   {
      if(reloading == true)
      {
         mainChar.mainGun.play();
      }
      gameStopStart("game");
      enemyStopStart("makeEnemy");
      fireButton("stageBG");
      mainChar.onEnterFrame = moveCharacter;
      gamePaused = false;
      timeClock = setInterval(passingTime,1000);
      startTimer(location[currentTownLocation].levelTime);
      for(v in aliveZombies)
      {
         aliveZombies[v].ref.play();
      }
   }
   else
   {
      if(reloading == true)
      {
         mainChar.mainGun.stop();
      }
      delete game.onEnterFrame;
      delete mainChar.onEnterFrame;
      delete makeEnemy.onEnterFrame;
      delete stageBG.onPress;
      delete stageBG.onRelease;
      gamePaused = true;
      clearInterval(timeClock);
      mainChar.legs.gotoAndStop("idle");
      for(v in aliveZombies)
      {
         aliveZombies[v].ref.stop();
      }
      stopFire();
   }
}
function cleanUpZombies()
{
   for(i in deadZombies)
   {
      deadZombies[i].ref.removeMovieClip();
      deadZombies.splice(i,1);
      deadZombieCount = 0;
   }
   for(o in enemyOnScreen)
   {
      enemyOnScreen[o].ref.removeMovieClip();
      enemyOnScreen.splice(o,1);
   }
   for(p in aliveZombies)
   {
      aliveZombies[p].ref.removeMovieClip();
      aliveZombies.splice(p,1);
   }
}
function cleanUpScreen()
{
   _root.stopMusic();
   cleanUpSurvivors();
   removeMapOverlay();
   for(p in enemyOnScreen)
   {
      enemyOnScreen[p].ref.removeMovieClip();
      enemyOnScreen.splice(p,1);
   }
   for(i in deadZombies)
   {
      deadZombies[i].ref.removeMovieClip();
      deadZombies.splice(i,1);
      deadZombieCount = 0;
   }
   for(e in roundsOnScreen)
   {
      roundsOnScreen[e].ref.removeMovieClip();
      roundsOnScreen.splice(e,1);
   }
   for(p in aliveZombies)
   {
      aliveZombies[p].ref.removeMovieClip();
      aliveZombies.splice(p,1);
   }
}
function startNextLevel()
{
   removeMovieClip(_root.timeManager);
   _root.mainBlackOut._visible = true;
   _root.mainBlackOut.alphaTo(100,0);
   _root.mainBlackOut.alphaTo(0,2,"easeOutSine",0.1,hideBlackOut);
   timeManagerOpen = false;
   currentLevel = "day_" + _root.levelUp;
   zombiesKilled = 0;
   zombiesCreated = 0;
   bullet = 0;
   x = 0;
   resetSunRise();
   fillWeaponMagazines();
   pauseGame();
   timeClock = setInterval(passingTime,700);
   mainChar.gotoAndStop("alive");
   startTimer(location[currentTownLocation].levelTime);
   setupLighting();
   if(_root[currentWeapon].name == "chainsaw")
   {
      chainsawSound = new Sound(stageBG);
      chainsawSound.attachSound("sound_chainsawIdle");
      chainsawSound.setVolume(100);
      chainsawSound.start(0,999);
   }
   else
   {
      chainsawSound.stop("sound_chainsawIdle");
   }
}
function playChainsawIdle()
{
   chainsawSound = new Sound(stageBG);
   chainsawSound.attachSound("sound_chainsawIdle");
   chainsawSound.setVolume(100);
   chainsawSound.start(0,999);
}
function playChainsawPullSound()
{
   chainsawPullSound = new Sound(stageBg);
   chainsawPullSound.attachSound("sound_chainsawPull");
   chainsawPullSound.volumeTo(100);
   chainsawPullSound.start(0,1);
}
function playChainsawOffSound()
{
   chainsawPullSound = new Sound(stageBg);
   chainsawPullSound.attachSound("sound_chainsawOff");
   chainsawPullSound.volumeTo(100);
   chainsawPullSound.start(0,1);
}
function fireButton(butName)
{
   _root[butName].onPress = function()
   {
      _root.fire();
   };
   _root[butName].onRelease = function()
   {
      _root.stopFire();
   };
}
function swapWeapon(weaponName)
{
   currentWeapon = weaponName;
   mainGunRef.gotoAndStop(weaponName);
   if(_root[currentWeapon].name != "chainsaw")
   {
      chainsawSound.stop("sound_chainsawIdle");
   }
}
function stopChainsawIdle()
{
   chainsawSound.stop("sound_chainsawWorking");
   chainsawSound.stop("sound_chainsawIdle");
}
function fire()
{
   if(ammoInMag > 0 && reloading == false && pumping == false)
   {
      if(_root[currentWeapon].fireMode == "auto" && firing == false)
      {
         firing = true;
         attachRound("hero");
         automaticFire = setInterval(attachRound,_root[currentWeapon].weaponRPM,"hero");
         if(_root[currentWeapon].name == "chainsaw")
         {
            chainsawSound = new Sound(stageBG);
            chainsawSound.attachSound("sound_chainsawWorking");
            chainsawSound.setVolume(20);
            chainsawSound.start(0,999);
         }
      }
      else
      {
         if(_root[currentWeapon].fireMode == "thrown" && reloading == false)
         {
            throwingAWeapon = true;
            chargingThrow = setInterval(chargeThrow,20);
         }
         else
         {
            firing = true;
            attachRound("hero");
         }
         if(_root[currentWeapon].pumpWeapon == true)
         {
            pumpWeapon();
         }
      }
      mainGunRef.muzzleFlash.play();
   }
   else if(reloading == false && ammoInMag <= 0 && _root[currentWeapon].fireMode != "auto")
   {
      reloadWeapon();
   }
   else if(_root[currentWeapon].name == "shotgun" && reloading && !interruptingReload && ammoInMag >= 1)
   {
      interruptingReload = true;
      reloadAnimPlaying = false;
      bringBackWeapon = setInterval(raiseWeapon,800);
      mainGunRef.gotoAndPlay("shogtun_bringUpWeapon");
   }
}
function stopFire()
{
   if(_root[currentWeapon].fireMode == "thrown" && throwingAWeapon == true)
   {
      throwingAWeapon = false;
      thrownWeapon();
   }
   firing = false;
   mainGunRef.muzzleFlash.gotoAndStop("off");
   if(_root[currentWeapon].name == "flameThrower")
   {
      mainGunRef.muzzleFlash.gotoAndPlay("off");
   }
   clearInterval(automaticFire);
   if(_root[currentWeapon].name == "chainsaw")
   {
      chainsawSound.stop("sound_chainsawWorking");
      chainsawSound = new Sound(stageBG);
      chainsawSound.attachSound("sound_chainsawEnd");
      chainsawSound.setVolume(60);
      chainsawSound.start(0,1);
   }
}
function reloadWeapon()
{
   _root[currentWeapon].recoiling = false;
   stopFire();
   clearInterval(reloadinTime);
   if(_root[currentWeapon].name == "shotgun")
   {
      shellsToLoad = shotgun.magazineCapacity - ammoInMag;
      totalReloadTime = _root[currentWeapon].reloadTime * shellsToLoad + 800;
      reloading = true;
      pumping = false;
      mainGunRef.gotoAndPlay(_root[currentWeapon].name + "_Reloading");
      clearInterval(pumpTime);
   }
   else
   {
      clearInterval(pumpTime);
      reloading = true;
      playReloadSound();
      mainGunRef.gotoAndPlay(_root[currentWeapon].name + "_Reloading");
      reloadAnimPlaying = true;
   }
}
function reloadEmptyWeapon()
{
   if(_root[currentWeapon].reloadType == "auto" && ammoInMag <= 0 && !autoReloading)
   {
      autoReloading = true;
      reloadWeapon();
   }
}
function playReloadSound()
{
   reloadingSound = new Sound(stageBG);
   reloadingSound.attachSound("sound_" + _root[currentWeapon].name + "Reload");
   reloadingSound.setVolume(100);
   reloadingSound.start(0,1);
}
function reloadMagazine()
{
   autoReloading = false;
   reloading = false;
   pumping = false;
   ammoInMag = ammoInMag;
   if(_root[currentWeapon].name != "shotgun")
   {
      ammoInMag = _root[currentWeapon].magazineCapacity;
   }
   clearInterval(reloadinTime);
   clearInterval(pumpTime);
}
function pumpWeapon()
{
   pumping = true;
   reloading = false;
   interruptingReload = false;
   clearInterval(reloadinTime);
   mainGunRef.gotoAndPlay(_root[currentWeapon].name + "_Pumping");
   pumpTime = setInterval(pumpedWeapon,_root[currentWeapon].pumpTime);
}
function pumpedWeapon()
{
   pumping = false;
   reloading = false;
   clearInterval(pumpTime);
   clearInterval(reloadinTime);
}
function raiseWeapon()
{
   reloading = false;
   autoReloading = false;
   pumping = false;
   interruptingReload = false;
   clearInterval(pumpTime);
   clearInterval(reloadinTime);
   clearInterval(bringBackWeapon);
}
function pumpWeaponSound()
{
   pumpSound = new Sound(stageBG);
   pumpSound.attachSound("sound_" + _root[currentWeapon].name + "Pump");
   pumpSound.setVolume(100);
   pumpSound.start(0,1);
}
function shellReloadSound()
{
   shellSound = new Sound(stageBG);
   shellSound.attachSound("sound_" + _root[currentWeapon].name + "ShellReload");
   shellSound.setVolume(100);
   shellSound.start(0,1);
}
function bowReloadSound()
{
   shellSound = new Sound(stageBG);
   shellSound.attachSound("sound_bowDraw");
   shellSound.setVolume(100);
   shellSound.start(0,1);
}
function attachRound(ownerName)
{
   bullet++;
   ammoInMag--;
   if(ammoInMag <= 0)
   {
      stopFire();
   }
   if(_root[currentWeapon].recoilAnimated == true && _root[currentWeapon].recoiling == false && !reloading)
   {
      _root[currentWeapon].recoiling = true;
      mainGunRef.gotoAndPlay(_root[currentWeapon].name + "_Recoil");
   }
   firing = true;
   firingSound = new Sound(stageBG);
   firingSound.attachSound("sound_" + _root[currentWeapon].name + "Fire");
   firingSound.setVolume(100);
   firingSound.start(0,1);
   var _loc3_ = new Object();
   _loc3_.x = mainGunRef.barrelEnd._x;
   _loc3_.y = mainGunRef.barrelEnd._y;
   mainGunRef.localToGlobal(_loc3_);
   var _loc5_;
   if(_root[currentWeapon].shotsPerRound > 1)
   {
      bullet++;
      shellCasing = random(4) + 1;
      if(_root[currentWeapon].name == "shotgun")
      {
         mainGunRef.ejectionPort.attachMovie("shellcasing_Shotgun" + shellCasing,"casing" + bullet,bullet + 98);
      }
      else
      {
         mainGunRef.ejectionPort.attachMovie("shellcasing_noPumpShotgun" + shellCasing,"casing" + bullet,bullet + 98);
      }
      roundsToFire = _root[currentWeapon].shotsPerRound;
      while(roundsToFire > -1)
      {
         bullet++;
         var round = _root.attachMovie("round","round" + bullet,bullet + 350000);
         if(_root[currentWeapon].showTracers == true)
         {
            randomlyShowATracer = random(2) + 1;
            if(randomlyShowATracer > 1)
            {
               round.gotoAndPlay("on");
            }
            else
            {
               round.gotoAndStop("off");
            }
         }
         else
         {
            round.gotoAndStop("off");
         }
         round._x = _loc3_.x - random(50);
         round._y = _loc3_.y;
         round.angle = currentAngle - random(_root[currentWeapon].accuracy);
         round._rotation = round.angle;
         round.onEnterFrame = function()
         {
            this.x = Math.cos(this.angle * 3.141592653589793 / 180) * _root[currentWeapon].roundSpeed;
            this.y = Math.sin(this.angle * 3.141592653589793 / 180) * _root[currentWeapon].roundSpeed;
            this._x -= this.x;
            this._y -= this.y;
         };
         roundsOnScreen.push({ref:_root["round" + bullet],damage:_root[currentWeapon].damage,headShotDamage:_root[currentWeapon].headShotDamage,owner:ownerName});
         roundsToFire--;
      }
   }
   else
   {
      if(_root[currentWeapon].casingEject == true)
      {
         shellCasing = random(3) + 1;
         mainGunRef.ejectionPort.attachMovie("shellcasing_" + _root[currentWeapon].weaponGroup + "_" + shellCasing,"casing" + bullet,bullet + 98);
      }
      if(_root[currentWeapon].name == "flameThrower" && ownerName == "hero")
      {
         _loc5_ = _root.attachMovie("flameParticle","flame" + bullet,bullet + 320000);
         _loc5_._x = _loc3_.x;
         _loc5_._y = _loc3_.y;
         _loc5_._xscale = _loc5_._yscale = random(40) + 65;
         _loc5_._rotation += random(10) - 5;
         roundsOnScreen.push({ref:_root["flame" + bullet],penetrateCount:0,damage:_root[currentWeapon].damage,headShotDamage:_root[currentWeapon].headShotDamage,owner:ownerName,range:_root[currentWeapon].range,type:_root[currentWeapon].type,originX:_loc3_.x,originY:_loc3_.y,proximity:0});
      }
      else
      {
         var round = _root.attachMovie("round","round" + bullet,bullet + 350000);
      }
      if(_root[currentWeapon].showTracers == true && ownerName == "hero")
      {
         if(_root[currentWeapon].name == "RPG")
         {
            round.gotoAndPlay("RPG");
         }
         else if(_root[currentWeapon].name == "compoundBow")
         {
            round.gotoAndPlay("compoundBow");
         }
         else
         {
            randomlyShowATracer = random(2) + 1;
            if(randomlyShowATracer > 1)
            {
               round.gotoAndPlay("on");
            }
            else
            {
               round.gotoAndStop("off");
            }
         }
      }
      else
      {
         round.gotoAndStop("off");
      }
      round._x = _loc3_.x;
      round._y = _loc3_.y;
      round.angle = currentAngle - random(_root[currentWeapon].accuracy);
      round._rotation = round.angle;
      round.onEnterFrame = function()
      {
         var _loc4_ = Math.cos(round.angle * 3.141592653589793 / 180) * _root[currentWeapon].roundSpeed;
         var _loc3_ = Math.sin(round.angle * 3.141592653589793 / 180) * _root[currentWeapon].roundSpeed;
         this._x -= _loc4_;
         this._y -= _loc3_;
      };
      roundsOnScreen.push({ref:_root["round" + bullet],penetrateCount:0,damage:_root[currentWeapon].damage,headShotDamage:_root[currentWeapon].headShotDamage,owner:ownerName,range:_root[currentWeapon].range,type:_root[currentWeapon].type,originX:_loc3_.x,originY:_loc3_.y,proximity:0});
   }
}
function sortZombieDepths()
{
   var _loc2_ = new Array();
   for(var _loc1_ in enemyOnScreen)
   {
      if(enemyOnScreen[_loc1_].ref != null)
      {
         enemyOnScreen[_loc1_].depth = enemyOnScreen[_loc1_].ref._y + 71651;
         _loc2_.push(enemyOnScreen[_loc1_]);
      }
   }
   _loc2_.sortOn("depth",Array.NUMERIC,Array.DESCENDING);
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc2_[_loc1_].ref.swapDepths(_loc1_ + 71651);
      _loc1_ = _loc1_ + 1;
   }
}
function sortDeadCats()
{
   var _loc2_ = new Array();
   for(var _loc1_ in deadZombies)
   {
      if(deadZombies[_loc1_].ref != null)
      {
         deadZombies[_loc1_].ref.depth = deadZombies[_loc1_].ref._y + 2124;
         _loc2_.push(deadZombies[_loc1_]);
      }
   }
   _loc2_.sortOn("depth",Array.NUMERIC);
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc2_[_loc1_].ref.swapDepths(_loc1_ + 2124);
      _loc1_ = _loc1_ + 1;
   }
}
function collisionTest()
{
   reloadEmptyWeapon();
   sortZombieDepths();
   hud.ammoCountHud.debug_ammoCount.text = ammoInMag;
   hud.dayNumber.text = "NIGHT " + levelUp;
   deathToll.text = zombiesKilled;
   hud.wallHealthIndicator.wallhealth.text = Math.round(wall.health / 100);
   zombieProximityCheck();
   zombieProximitySort();
   for(i in roundsOnScreen)
   {
      if(roundsOnScreen[i].ref._x < -150 || roundsOnScreen[i].ref._x > 900 || roundsOnScreen[i].ref._y < -50)
      {
         roundsOnScreen[i].ref.removeMovieClip();
         roundsOnScreen.splice(i,1);
      }
      if(roundsOnScreen[i].type == "frag" || roundsOnScreen[i].type == "melee")
      {
         currentRoundProx = Math.round(Math.sqrt((roundsOnScreen[i].originX - roundsOnScreen[i].ref._x) * (roundsOnScreen[i].originX - roundsOnScreen[i].ref._x) + (roundsOnScreen[i].originY - roundsOnScreen[i].ref._y) * (roundsOnScreen[i].originY - roundsOnScreen[i].ref._y)));
         if(currentRoundProx >= roundsOnScreen[i].range)
         {
            roundsOnScreen[i].ref.removeMovieClip();
            roundsOnScreen.splice(i,1);
         }
      }
   }
   var _loc5_;
   var _loc2_;
   var _loc3_;
   for(j in aliveZombies)
   {
      if(aliveZombies[j].ref == null || aliveZombies[j].ref == undefined)
      {
         aliveZombies.splice(j,1);
      }
      enemyOnScreen[j].ref.zombieHealth.text = enemyOnScreen[j].health;
      enemyOnScreen[j].ref.zombieDead.text = enemyOnScreen[j].dead;
      if(aliveZombies[j].dead == false)
      {
         for(t in activeTraps)
         {
            if(activeTraps[t].ref.collisionFeet.hitTest(aliveZombies[j].ref.collisionFeet))
            {
               if(activeTraps[t].type == "bearTrap")
               {
                  aliveZombies[j].trapped = true;
                  bearTrapCloseSound = new Sound(stageBG);
                  bearTrapCloseSound.attachSound("sound_trapShut");
                  bearTrapCloseSound.setVolume(100);
                  bearTrapCloseSound.start(0,1);
                  zombieTrapScream = new Sound(stageBG);
                  zombieTrapScream.attachSound("sound_zombieFast");
                  zombieTrapScream.setVolume(100);
                  zombieTrapScream.start(0,1);
                  activeTraps[t].ref.gotoAndStop("snap");
                  aliveZombies[j].ref.gotoAndPlay("trapped");
                  removeTrapOnMapFromExplosion(activeTraps[t].location);
                  activeTraps.splice(t,1);
               }
               else if(activeTraps[t].type == "mine")
               {
                  spawnFragments(30,activeTraps[t].ref._x,activeTraps[t].ref._y + 60,activeTraps[t].range,"frag",activeTraps[t].damage);
                  explosionNumber++;
                  _root.attachMovie("explosion_grenade","grensplosion" + explosionNumber,explosionNumber + 88213);
                  _root["grensplosion" + explosionNumber]._x = activeTraps[t].ref._x;
                  _root["grensplosion" + explosionNumber]._y = activeTraps[t].ref._y + 60;
                  _root["grensplosion" + explosionNumber].play;
                  removeTrapOnMapFromExplosion(activeTraps[t].location);
                  activeTraps[t].ref.removeMovieClip();
                  activeTraps.splice(t,1);
               }
            }
         }
         if(aliveZombies[j].trapped)
         {
            aliveZombies[j].health -= random(0.5) + 0.1;
            if(aliveZombies[j].health <= 0 && aliveZombies[j].beingExploded == false)
            {
               deathSound = new Sound(stageBG);
               deathSound.attachSound("sound_zombieDeath_" + (random(11) + 1));
               deathSound.setVolume(100);
               deathSound.start(0,1);
               deadZombies.push({ref:aliveZombies[j].ref});
               randomDeath = random(3) + 1;
               aliveZombies[j].ref.gotoAndPlay("fallBackwards" + randomDeath);
               zombiesKilled++;
               overallDeadZombies++;
               deadZombieCount++;
               currentZombieThreat -= aliveZombies[j].threat;
               aliveZombies[j].dead = true;
               aliveZombies.splice(j,1);
               liveZombieCount--;
            }
         }
         if(aliveZombies[j].ref._x > 520 + aliveZombies[j].ref._y * 20 / 100 && !aliveZombies[j].idle == true && aliveZombies[j].dead == false)
         {
            aliveZombies[j].ref.gotoAndPlay("idlestop1");
            aliveZombies[j].idle = true;
         }
         else if(aliveZombies[j].idle == true && !wall.destroyed && aliveZombies[j].dead == false)
         {
            if(aliveZombies[j].ref.attackingWall == false)
            {
               aliveZombies[j].ref.gotoAndPlay("attackWall" + random(2));
            }
            if(aliveZombies[j].armed)
            {
               wall.health -= aliveZombies[j].damage * 1.5 * zombieDamageMultiplier;
            }
            else
            {
               wall.health -= aliveZombies[j].damage * zombieDamageMultiplier;
            }
            checkWallStatus();
            if(wall.health <= -1)
            {
               wall.destroyed = true;
            }
         }
         else if(aliveZombies[j].idle == false && aliveZombies[j].dead == false && aliveZombies[j].beingExploded == false && aliveZombies[j].trapped == false)
         {
            aliveZombies[j].ref._x += aliveZombies[j].speed;
            aliveZombies[j].directionCount--;
            if(aliveZombies[j].directionCount < 0)
            {
               _loc5_ = "direction" + (random(3) + 1);
               aliveZombies[j].directionCount = aliveZombies[j].directionCountMax;
               switch(_loc5_)
               {
                  case "direction1":
                     aliveZombies[j].currentDirection = "up";
                     break;
                  case "direction2":
                     aliveZombies[j].currentDirection = "down";
                     break;
                  case "direction3":
                     aliveZombies[j].currentDirection = "straight";
                     break;
                  default:
                     aliveZombies[j].currentDirection = "straight";
               }
            }
            if(aliveZombies[j].ref._y > 120 && aliveZombies[j].ref._y < 300)
            {
               switch(aliveZombies[j].currentDirection)
               {
                  case "straight":
                     break;
                  case "up":
                     aliveZombies[j].ref._y -= aliveZombies[j].speed / 3.5;
                     break;
                  case "down":
                     aliveZombies[j].ref._y += aliveZombies[j].speed / 3.5;
               }
            }
         }
         else if(wall.destroyed && aliveZombies[j].idle == true && aliveZombies[j].dead == false)
         {
            wall.health = 0;
            if(aliveZombies[j].animating == false && aliveZombies[j].type != "zombieDog")
            {
               aliveZombies[j].ref.gotoAndPlay(random(10) + 25);
               aliveZombies[j].animating = true;
            }
            else if(aliveZombies[j].type == "zombieDog" && aliveZombies[j].animating == false)
            {
               aliveZombies[j].ref.gotoAndPlay("walk1");
               aliveZombies[j].animating = true;
            }
            if(aliveZombies[j].ref._x <= _root.mainChar._x + 39 && !aliveZombies[j].eating)
            {
               aliveZombies[j].ref._xscale = 100;
               aliveZombies[j].ref._x += 1;
            }
            if(aliveZombies[j].ref._x >= _root.mainChar._x + 40 && !aliveZombies[j].eating)
            {
               aliveZombies[j].ref._xscale = -100;
               aliveZombies[j].ref._x -= 1;
            }
            if(aliveZombies[j].ref._y <= _root.mainChar._y + 40 && !aliveZombies[j].eating)
            {
               aliveZombies[j].ref._y += 1;
            }
            if(aliveZombies[j].ref._y >= _root.mainChar._y + 40 && !aliveZombies[j].eating)
            {
               aliveZombies[j].ref._y -= 1;
            }
            if(aliveZombies[j].ref.reach.hitTest(_root.mainChar._x + 70,_root.mainChar._y + 10,true))
            {
               if(hero.isAlive)
               {
                  aliveZombies[j].eating = true;
                  _root.mainChar.gotoAndPlay("dead");
                  aliveZombies[j].ref.gotoAndPlay("lunge");
                  _root.attachMovie("gameOver","gameOver",993900);
                  if(levelUp == 1)
                  {
                     gameOver.gameOverDays.gameOverDaysText.text = "AFTER SURVIVING " + levelUp + " DAY";
                  }
                  else
                  {
                     gameOver.gameOverDays.gameOverDaysText.text = "AFTER SURVIVING " + levelUp + " DAYS";
                  }
                  gameOver._alpha = 0;
                  gameOver.alphaTo(100,8,"easeOutSine");
                  hideCrosshairs();
                  hero.isAlive = false;
                  delete mainChar.onEnterFrame;
                  delete stageBG.onPress;
                  delete stageBG.onRelease;
               }
               else if(!hero.isAlive)
               {
                  aliveZombies[j].eating = true;
                  aliveZombies[j].ref.gotoAndPlay("bendDown");
               }
            }
         }
      }
      for(k in roundsOnScreen)
      {
         randomBloodPack = random(3) + 1;
         randomBloodAnim = random(fx_totalBloodAnims) + 1;
         randomBloodAnimHead = random(fx_totalBloodAnimsHead) + 1;
         randomBloodAnimChainsaw = random(fx_totalBloodAnimsChainsaw) + 1;
         if(roundsOnScreen[k].type == "impactExplosive")
         {
            for(v in aliveZombies)
            {
               if((aliveZombies[v].ref.head.hitTest(roundsOnScreen[k].ref.collision) || aliveZombies[v].ref.torso.hitTest(roundsOnScreen[k].ref.collision) || aliveZombies[v].ref.legs.hitTest(roundsOnScreen[k].ref.collision)) && aliveZombies[v].dead == false)
               {
                  _loc2_ = new Object();
                  _loc2_.x = roundsOnScreen[k].ref.collision._x + 70;
                  _loc2_.y = roundsOnScreen[k].ref.collision._y;
                  roundsOnScreen[k].ref.localToGlobal(_loc2_);
                  roundsOnScreen[k].ref.removeMovieClip();
                  roundsOnScreen.splice(k,1);
                  spawnFragments(30,_loc2_.x,_loc2_.y,_root[currentWeapon].range,"frag",_root[currentWeapon].damage);
                  explosionNumber++;
                  _root.attachMovie("explosion_grenade","grensplosion" + explosionNumber,explosionNumber + 163040);
                  _root["grensplosion" + explosionNumber]._x = _loc2_.x;
                  _root["grensplosion" + explosionNumber]._y = _loc2_.y;
                  _root["grensplosion" + explosionNumber]._rotation = -90;
                  _root["grensplosion" + explosionNumber].play;
               }
            }
         }
         for(t in activeTraps)
         {
            if(activeTraps[t].ref.collision.hitTest(roundsOnScreen[k].ref.collision) && activeTraps[t].type == "gasCylinder" && roundsOnScreen[k].owner == "hero")
            {
               spawnFragments(30,activeTraps[t].ref._x,activeTraps[t].ref._y + 60,activeTraps[t].range,"frag",activeTraps[t].damage);
               explosionNumber++;
               _root.attachMovie("explosion_grenade","grensplosion" + explosionNumber,explosionNumber + 142300);
               _root["grensplosion" + explosionNumber]._x = activeTraps[t].ref._x;
               _root["grensplosion" + explosionNumber]._y = activeTraps[t].ref._y + 60;
               _root["grensplosion" + explosionNumber].play;
               removeTrapOnMapFromExplosion(activeTraps[t].location);
               activeTraps[t].ref.removeMovieClip();
               activeTraps.splice(t,1);
               roundsOnScreen[k].ref.removeMovieClip();
               roundsOnScreen.splice(k,1);
            }
         }
         for(v in aliveZombies)
         {
            if(roundsOnScreen[k].ref._x - aliveZombies[v].ref._x < 100 && roundsOnScreen[k].ref._y - aliveZombies[v].ref._y < 100)
            {
               if(aliveZombies[v].ref.head.hitTest(roundsOnScreen[k].ref.collision) && aliveZombies[v].dead == false)
               {
                  hitHelmet = random(5);
                  if(hitHelmet <= 2 && (aliveZombies[v].type == "zombieSoldier" || aliveZombies[v].type == "zombieSoldierSprint"))
                  {
                     hitBodySound = new Sound(stageBG);
                     hitBodySound.attachSound("zombie_hitBody2");
                     hitBodySound.setVolume(100);
                     hitBodySound.start(0,1);
                     aliveZombies[v].ref["thudPackHead" + randomBloodPack].gotoAndPlay("base1");
                     roundsOnScreen[k].ref.removeMovieClip();
                     roundsOnScreen.splice(k,1);
                  }
                  else
                  {
                     aliveZombies[v].health -= roundsOnScreen[k].headShotDamage + random(3);
                     if(roundsOnScreen[k].owner == "hero")
                     {
                        switch(_root[currentWeapon].name)
                        {
                           case "chainsaw":
                              aliveZombies[v].ref["bloodPackHead" + randomBloodPack].gotoAndPlay("chainsaw" + randomBloodAnimChainsaw);
                              hitBodySound = new Sound(stageBG);
                              hitBodySound.attachSound("sound_hitChainsaw" + (random(2) + 1));
                              hitBodySound.setVolume(100);
                              hitBodySound.start(0,1);
                              _loc3_ = new Object();
                              _loc3_.x = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._x;
                              _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y + 45;
                              aliveZombies[v].ref["bloodPackHead" + randomBloodPack].localToGlobal(_loc3_);
                              if(aliveZombies[v].type == "zombieDog")
                              {
                                 _loc3_.x = aliveZombies[v].ref.head._x + 5;
                                 _loc3_.y = aliveZombies[v].ref.head._y + 5;
                                 aliveZombies[v].ref.head.localToGlobal(_loc3_);
                              }
                              zombieChainsawBloodParticle(_loc3_.x,_loc3_.y);
                              break;
                           case "compoundBow":
                              hitBodySound = new Sound(stageBG);
                              hitBodySound.attachSound("sound_hitHead" + (random(2) + 1));
                              hitBodySound.setVolume(100);
                              hitBodySound.start(0,1);
                              aliveZombies[v].ref["bloodPackHead" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                              aliveZombies[v].arrowsStuckHead++;
                              aliveZombies[v].ref.dummyHead.head.arrowPack.gotoAndStop("arrow" + aliveZombies[v].arrowsStuckHead);
                              _loc3_ = new Object();
                              _loc3_.x = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._x;
                              _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y + 45;
                              if(aliveZombies[v].type == "zombieDog")
                              {
                                 _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y;
                              }
                              aliveZombies[v].ref["bloodPackHead" + randomBloodPack].localToGlobal(_loc3_);
                              zombieBloodParticle(_loc3_.x,_loc3_.y);
                              break;
                           case "flameThrower":
                              aliveZombies[v].burnDamageCountHead++;
                              if(aliveZombies[v].burnDamageCountHead > roundsBeforeBurn)
                              {
                                 aliveZombies[v].ref.dummyHead.head.flamepack.play();
                              }
                              break;
                           default:
                              aliveZombies[v].ref["bloodPackHead" + randomBloodPack].gotoAndPlay("head" + randomBloodAnimHead);
                              hitBodySound = new Sound(stageBG);
                              hitBodySound.attachSound("sound_hitHead1");
                              hitBodySound.setVolume(100);
                              hitBodySound.start(0,1);
                              _loc3_ = new Object();
                              _loc3_.x = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._x;
                              _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y + 45;
                              if(aliveZombies[v].type == "zombieDog")
                              {
                                 _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y;
                              }
                              aliveZombies[v].ref["bloodPackHead" + randomBloodPack].localToGlobal(_loc3_);
                              zombieHeadBloodParticle(_loc3_.x,_loc3_.y);
                        }
                     }
                     else
                     {
                        hitBodySound = new Sound(stageBG);
                        hitBodySound.attachSound("sound_hitHead" + (random(2) + 1));
                        hitBodySound.setVolume(100);
                        hitBodySound.start(0,1);
                        aliveZombies[v].ref["bloodPackHead" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                     }
                     aliveZombies[v].ref._x -= 1;
                     aliveZombies[v].ref.prevFrame;
                     checkPenetration();
                     if(aliveZombies[v].health <= 0 && aliveZombies[v].beingExploded == false)
                     {
                        deathSound = new Sound(stageBG);
                        if(aliveZombies[v].type == "zombieDog")
                        {
                           deathSound.attachSound("sound_dogDeath_" + (random(5) + 1));
                        }
                        else
                        {
                           deathSound.attachSound("sound_zombieDeath_" + (random(11) + 1));
                        }
                        deathSound.setVolume(100);
                        deathSound.start(0,1);
                        deadZombies.push({ref:aliveZombies[v].ref});
                        if(_root[currentWeapon].name == "compoundBow")
                        {
                           randomDeath = random(2) + 1;
                        }
                        else
                        {
                           randomDeath = random(3) + 1;
                        }
                        if(aliveZombies[v].ref._x > 450)
                        {
                           aliveZombies[v].ref.gotoAndPlay("fallBackwards" + randomDeath);
                           zombiesKilled++;
                           overallDeadZombies++;
                           deadZombieCount++;
                           currentZombieThreat -= aliveZombies[v].threat;
                           aliveZombies[v].dead = true;
                           aliveZombies.splice(v,1);
                           liveZombieCount--;
                        }
                        else
                        {
                           aliveZombies[v].ref.gotoAndPlay("fallHead" + randomDeath);
                           zombiesKilled++;
                           overallDeadZombies++;
                           deadZombieCount++;
                           currentZombieThreat -= aliveZombies[v].threat;
                           aliveZombies[v].dead = true;
                           aliveZombies.splice(v,1);
                           liveZombieCount--;
                        }
                     }
                  }
               }
               if(aliveZombies[v].ref.torso.hitTest(roundsOnScreen[k].ref.collision) && aliveZombies[j].dead == false)
               {
                  if(aliveZombies[v].type == "zombieSoldier" || aliveZombies[v].type == "zombieSoldierSprint" || aliveZombies[v].type == "zombieSWAT" || aliveZombies[v].type == "zombieSWATSprint")
                  {
                     hitBodySound = new Sound(stageBG);
                     hitBodySound.attachSound("zombie_hitBody2");
                     hitBodySound.setVolume(100);
                     hitBodySound.start(0,1);
                     aliveZombies[v].ref["thudPackTorso" + randomBloodPack].gotoAndPlay("base1");
                     roundsOnScreen[k].ref.removeMovieClip();
                     roundsOnScreen.splice(k,1);
                  }
                  else
                  {
                     aliveZombies[v].health -= roundsOnScreen[k].damage + random(2);
                     if(roundsOnScreen[k].owner == "hero")
                     {
                        switch(_root[currentWeapon].name)
                        {
                           case "chainsaw":
                              aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].gotoAndPlay("chainsaw" + randomBloodAnimChainsaw);
                              hitBodySound = new Sound(stageBG);
                              hitBodySound.attachSound("sound_hitChainsaw" + (random(2) + 1));
                              hitBodySound.setVolume(100);
                              hitBodySound.start(0,1);
                              _loc3_ = new Object();
                              _loc3_.x = aliveZombies[v].ref["bloodPackTorso" + randomBloodPack]._x;
                              _loc3_.y = aliveZombies[v].ref["bloodPackTorso" + randomBloodPack]._y;
                              if(aliveZombies[v].type == "zombieDog")
                              {
                                 _loc3_.x = aliveZombies[v].ref.torso._x - 30;
                                 _loc3_.y = aliveZombies[v].ref.torso._y - 30;
                              }
                              aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].localToGlobal(_loc3_);
                              zombieChainsawBloodParticle(_loc3_.x,_loc3_.y);
                              break;
                           case "flameThrower":
                              aliveZombies[v].burnDamageCountTorso++;
                              if(aliveZombies[v].burnDamageCountTorso > roundsBeforeBurn)
                              {
                                 aliveZombies[v].ref.flamePackTorso.play();
                              }
                              break;
                           case "compoundBow":
                              hitBodySound = new Sound(stageBG);
                              hitBodySound.attachSound("sound_hitBody" + (random(2) + 1));
                              hitBodySound.setVolume(100);
                              hitBodySound.start(0,1);
                              aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                              aliveZombies[v].arrowsStuckTorso++;
                              aliveZombies[v].ref.dummyTorso.torso.arrowPack.gotoAndStop("arrow" + aliveZombies[v].arrowsStuckTorso);
                              _loc3_ = new Object();
                              _loc3_.x = aliveZombies[v].ref["bloodPackTorso" + randomBloodPack]._x;
                              _loc3_.y = aliveZombies[v].ref["bloodPackTorso" + randomBloodPack]._y;
                              if(aliveZombies[v].type == "zombieDog")
                              {
                                 _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y;
                              }
                              aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].localToGlobal(_loc3_);
                              zombieBloodParticle(_loc3_.x,_loc3_.y);
                              break;
                           default:
                              hitBodySound = new Sound(stageBG);
                              hitBodySound.attachSound("sound_hitBody" + (random(2) + 1));
                              hitBodySound.setVolume(100);
                              hitBodySound.start(0,1);
                              aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                              _loc3_ = new Object();
                              _loc3_.x = aliveZombies[v].ref["bloodPackTorso" + randomBloodPack]._x;
                              _loc3_.y = aliveZombies[v].ref["bloodPackTorso" + randomBloodPack]._y;
                              if(aliveZombies[v].type == "zombieDog")
                              {
                                 _loc3_.y = aliveZombies[v].ref["bloodPackHead" + randomBloodPack]._y;
                              }
                              aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].localToGlobal(_loc3_);
                              zombieBloodParticle(_loc3_.x,_loc3_.y);
                        }
                     }
                     else
                     {
                        hitBodySound = new Sound(stageBG);
                        hitBodySound.attachSound("sound_hitBody" + (random(2) + 1));
                        hitBodySound.setVolume(100);
                        hitBodySound.start(0,1);
                        aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                     }
                     currentRoundType = roundsOnScreen[k].type;
                     checkPenetration();
                     aliveZombies[v].ref._x -= _root[currentWeapon].knockBack;
                     aliveZombies[v].ref.prevFrame;
                     if(aliveZombies[v].health <= 0 && aliveZombies[v].beingExploded == false)
                     {
                        deathSound = new Sound(stageBG);
                        if(aliveZombies[v].type == "zombieDog")
                        {
                           deathSound.attachSound("sound_dogDeath_" + (random(5) + 1));
                        }
                        else
                        {
                           deathSound.attachSound("sound_zombieDeath_" + (random(11) + 1));
                        }
                        deathSound.setVolume(100);
                        deathSound.start(0,1);
                        deadZombies.push({ref:enemyOnScreen[j].ref});
                        randomDeath = random(3) + 1;
                        if(currentRoundType == "frag" && randomDeath > 1)
                        {
                           aliveZombies[v].ref.gotoAndPlay("exploded1");
                        }
                        else
                        {
                           aliveZombies[v].ref.gotoAndPlay("fallBackwards" + randomDeath);
                        }
                        zombiesKilled++;
                        overallDeadZombies++;
                        deadZombieCount++;
                        currentZombieThreat -= aliveZombies[v].threat;
                        aliveZombies[v].dead = true;
                        aliveZombies.splice(v,1);
                        liveZombieCount--;
                        sunRiseCheck();
                     }
                  }
               }
               if(aliveZombies[v].ref.legs.hitTest(roundsOnScreen[k].ref.collision) && aliveZombies[j].dead == false)
               {
                  aliveZombies[v].health -= roundsOnScreen[k].damage + random(1);
                  if(roundsOnScreen[k].owner == "hero")
                  {
                     switch(_root[currentWeapon].name)
                     {
                        case "chainsaw":
                           aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].gotoAndPlay("chainsaw" + randomBloodAnimChainsaw);
                           hitBodySound = new Sound(stageBG);
                           hitBodySound.attachSound("sound_hitChainsaw" + (random(2) + 1));
                           hitBodySound.setVolume(100);
                           hitBodySound.start(0,1);
                           break;
                        case "flameThrower":
                           aliveZombies[v].burnDamageCountLegs++;
                           if(aliveZombies[v].burnDamageCountLegs > roundsBeforeBurn)
                           {
                              aliveZombies[v].ref.burnDamageCountLegs.play();
                           }
                           break;
                        case "compoundBow":
                           hitBodySound = new Sound(stageBG);
                           hitBodySound.attachSound("sound_hitBody" + (random(2) + 1));
                           hitBodySound.setVolume(100);
                           hitBodySound.start(0,1);
                           aliveZombies[v].ref["bloodPackLegs" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                           aliveZombies[v].arrowsStuckLegs++;
                           aliveZombies[v].ref.dummyFrontUpperLeg.arrowPack.gotoAndStop("arrow" + aliveZombies[v].arrowsStuckLegs);
                           break;
                        default:
                           aliveZombies[v].ref["bloodPackLegs" + randomBloodPack].play();
                           hitLegSound = new Sound(stageBG);
                           hitLegSound.attachSound("sound_hitBody1");
                           hitLegSound.setVolume(100);
                           hitLegSound.start(0,1);
                           _loc3_ = new Object();
                           _loc3_.x = aliveZombies[v].ref["bloodPackLegs" + randomBloodPack]._x;
                           _loc3_.y = aliveZombies[v].ref["bloodPackLegs" + randomBloodPack]._y;
                           aliveZombies[v].ref["bloodPackLegs" + randomBloodPack].localToGlobal(_loc3_);
                           zombieLegBloodParticle(_loc3_.x,_loc3_.y);
                     }
                  }
                  else
                  {
                     hitBodySound = new Sound(stageBG);
                     hitBodySound.attachSound("sound_hitBody" + (random(2) + 1));
                     hitBodySound.setVolume(100);
                     hitBodySound.start(0,1);
                     aliveZombies[v].ref["bloodPackLegs" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                  }
                  checkPenetration();
                  aliveZombies[v].ref._x -= 2;
                  aliveZombies[v].ref.prevFrame;
                  if(aliveZombies[v].health <= 0 && aliveZombies[v].beingExploded == false)
                  {
                     deathSound = new Sound(stageBG);
                     if(aliveZombies[v].type == "zombieDog")
                     {
                        deathSound.attachSound("sound_dogDeath_" + (random(5) + 1));
                     }
                     else
                     {
                        deathSound.attachSound("sound_zombieDeath_" + (random(11) + 1));
                     }
                     deathSound.setVolume(100);
                     deathSound.start(0,1);
                     randomDeath = random(3) + 1;
                     if(aliveZombies[v].ref._x > 450)
                     {
                        aliveZombies[v].ref.gotoAndPlay("fallBackwards" + randomDeath);
                        zombiesKilled++;
                        overallDeadZombies++;
                        deadZombieCount++;
                        liveZombieCount--;
                        currentZombieThreat -= aliveZombies[v].threat;
                        aliveZombies[v].dead = true;
                        aliveZombies.splice(v,1);
                     }
                     else
                     {
                        aliveZombies[v].ref.gotoAndPlay("fallForward" + randomDeath);
                        zombiesKilled++;
                        overallDeadZombies++;
                        deadZombieCount++;
                        liveZombieCount--;
                        currentZombieThreat -= aliveZombies[v].threat;
                        aliveZombies[v].dead = true;
                        aliveZombies.splice(v,1);
                        sunRiseCheck();
                     }
                  }
               }
            }
         }
      }
   }
}
function ceaseFire()
{
   firing = false;
   clearInterval(weaponDelay);
   mainGunRef.muzzleFlash.gotoAndStop(1);
}
function turretControl()
{
   var _loc2_ = new Object();
   _loc2_.x = mainGunRef._x;
   _loc2_.y = mainGunRef._y;
   mainGunRef._parent.localToGlobal(_loc2_);
   var _loc4_ = _loc2_.x - _root._xmouse;
   var _loc3_ = _loc2_.y - _root._ymouse;
   var _loc5_ = Math.atan2(_loc3_,_loc4_) * 57.29577951308232;
   currentAngle = _loc5_;
   if(currentAngle > 15)
   {
      currentAngle = 15;
   }
   if(currentAngle < -10)
   {
      currentAngle = -10;
   }
   mainGunRef._rotation = currentAngle;
}
stop();
var overallDeadZombies = 0;
delete game.onEnterFrame;
delete mainChar.onEnterFrame;
delete makeEnemy.onEnterFrame;
delete stageBG.onPress;
delete stageBG.onRelease;
fscommand("allowscale",false);
enemyStopStart("makeEnemy");
if(_quality != "MEDIUM" && _quality != "LOW")
{
   _quality = "medium";
}
mouseInitialised = "notyet";
_root.attachMovie("blackOut","mainBlackOut",999788);
_root.mainBlackOut.alphaTo(0,1.5,"easeOutSine",0.5,hideBlackOut);
_root.mainBlackOut.depth = 994000;
_root.attachMovie("hud","hud",894351);
_root.hud._x = 660;
_root.hud._y = 335.4;
_root.attachMovie("mainCharacter","mainChar",97500);
mainChar._x = 605;
mainChar._y = 175;
setupSurvivorSlots();
setupSurvivors();
assignSurvivorWeapons();
addHeroToSurvivorArray();
bullet = 0;
bulletLevel = 1;
projectile = 0;
smokePuff = 0;
firstRound = true;
reloading = false;
reloadAnimPlaying = false;
autoReloading = false;
pumping = false;
firing = false;
interruptingReload = false;
wall_health = 1000;
currentLevel = "day_1";
levelUp = 1;
zombiesKilled = 0;
chainsawSoundPlaying = false;
optionsLoaded = false;
zombiesAnimating = false;
gamePaused = false;
endGameStarted = false;
currentZombieThreat = 0;
switchingWeapons = false;
currentTownLocation = "glenDale";
createTownMapOverlay(currentTownLocation);
setupLighting();
delay = 6;
roundsOnScreen = new Array();
enemyOnScreen = new Array();
deadZombies = new Array();
aliveZombies = new Array();
x = 1;
zombiesCreated = 0;
var bodysOnScreenTime = 50;
showCrosshairs();
startTimer(location[currentTownLocation].levelTime);
mainGunRef = mainChar.mainGun;

function gameStopStart(butName)
{
   _root[butName].onEnterFrame = function()
   {
      _root.turretControl();
      _root.collisionTest();
   };
}
function enemyStopStart(butName)
{
   _root[butName].onEnterFrame = function()
   {
      _root.enemyGenerator();
   };
}
function pauseGame()
{
   if(gamePaused == true)
   {
      if(reloadAnimPlaying == true)
      {
         mainChar.mainGun.play();
      }
      gameStopStart("game");
      enemyStopStart("makeEnemy");
      fireButton("stageBG");
      mainChar.onEnterFrame = moveCharacter;
      gamePaused = false;
      timeClock = setInterval(passingTime,1000);
      for(v in aliveZombies)
      {
         aliveZombies[v].ref.play();
      }
   }
   else
   {
      if(reloadAnimPlaying == true)
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
         trace("STOPPING:" + aliveZombies[v].ref);
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
   trace("------------------------------------------------------>>>>>>>>>>");
   trace("                      SCREEN CLEAN UP");
   trace("------------------------------------------------------>>>>>>>>>>");
   _root.stopMainMusic();
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
   trace(">>>>>>>>>>>>>>>>>>> STARTING " + _root.currentLevel + "<<<<<<<<<<<<<<<<<<");
   zombiesKilled = 0;
   zombiesCreated = 0;
   bullet = 0;
   x = 0;
   resetSunRise();
   fillWeaponMagazines();
   pauseGame();
   timeClock = setInterval(passingTime,700);
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
         attachRound();
         automaticFire = setInterval(attachRound,_root[currentWeapon].weaponRPM);
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
            attachRound();
         }
         if(_root[currentWeapon].pumpWeapon == true)
         {
            pumpWeapon();
         }
      }
      mainGunRef._rotation = currentAngle + _root[currentWeapon].recoil;
      mainGunRef.muzzleFlash.play();
   }
   else if(reloading == false && ammoInMag <= 0 && !autoReloading)
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
   clearInterval(reloadinTime);
   if(_root[currentWeapon].name == "shotgun")
   {
      shellsToLoad = shotgun.magazineCapacity - ammoInMag;
      totalReloadTime = _root[currentWeapon].reloadTime * shellsToLoad + 800;
      reloading = true;
      pumping = false;
      reloadinTime = setInterval(reloadMagazine,totalReloadTime);
      mainGunRef.gotoAndPlay(_root[currentWeapon].name + "_Reloading");
      reloadAnimPlaying = true;
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
   if(_root[currentWeapon].reloadType == "auto" && ammoInMag <= 0 && !autoReloading && !reloading)
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
   trace("** RELOADED **");
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
function attachRound()
{
   bullet++;
   ammoInMag--;
   if(ammoInMag <= 0)
   {
      stopFire();
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
   if(_root[currentWeapon].shotsPerRound > 1)
   {
      bullet++;
      shellCasing = random(2) + 1;
      mainGunRef.ejectionPort.attachMovie("shellcasing_Shotgun" + shellCasing,"casing" + bullet,bullet + 98);
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
         if(ammoInMag <= 0 && _root[currentWeapon].reloadType == "auto")
         {
            if(reloading == false)
            {
               reloadWeapon();
            }
         }
         roundsOnScreen.push({ref:_root["round" + bullet],damage:_root[currentWeapon].damage,headShotDamage:_root[currentWeapon].headShotDamage});
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
      if(ammoInMag <= 0 && _root[currentWeapon].reloadType == "auto")
      {
         if(reloading == false)
         {
            reloadWeapon();
         }
      }
      roundsOnScreen.push({ref:_root["round" + bullet],penetrateCount:0,damage:_root[currentWeapon].damage,headShotDamage:_root[currentWeapon].headShotDamage});
   }
}
function sortZombieDepths()
{
   var _loc2_ = new Array();
   for(var _loc1_ in enemyOnScreen)
   {
      if(enemyOnScreen[_loc1_].ref != null)
      {
         enemyOnScreen[_loc1_].ref.depth = enemyOnScreen[_loc1_].ref._y * 1000;
         _loc2_.push(enemyOnScreen[_loc1_]);
      }
   }
   _loc2_.sortOn("depth",Array.NUMERIC);
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc2_[_loc1_].ref.swapDepths(_loc1_ * 1000);
      _loc1_ = _loc1_ + 1;
   }
}
function sortDeadZombies()
{
   var _loc2_ = new Array();
   for(var _loc1_ in deadZombies)
   {
      if(deadZombies[_loc1_].ref != null)
      {
         trace(deadZombies[_loc1_].ref._y);
         deadZombies[_loc1_].ref.depth = deadZombies[_loc1_].ref._y * 100;
         _loc2_.push(deadZombies[_loc1_]);
      }
   }
   _loc2_.sortOn("depth",Array.NUMERIC);
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc2_[_loc1_].ref.swapDepths(_loc1_ * 100);
      _loc1_ = _loc1_ + 1;
   }
}
function collisionTest()
{
   sortZombieDepths();
   reloadEmptyWeapon();
   if(zombiesKilled >= _root[currentLevel].zombiePool)
   {
      reloadAnimPlaying = false;
      loadTimeManager();
      trace(">>>>>>>>>>>>>>> ALL DEAD. TOTAL KILLED: " + zombiesKilled + " <<<<<<<<<<<<<<<");
   }
   if(currentLevel == "day_20")
   {
      if(zombiesKilled >= 70 && endGameStarted == false)
      {
         reloadAnimPlaying = false;
         endGameStarted = true;
         endGame();
      }
   }
   ammoCountHud.debug_ammoCount.text = ammoInMag;
   dayNumber.text = "NIGHT " + currentLevel;
   deathToll.text = zombiesKilled;
   wallHealthIndicator.wallhealth.text = Math.round(wall.health / 100);
   zombieProximityCheck();
   zombieProximitySort();
   var _loc2_;
   for(i in roundsOnScreen)
   {
      if(roundsOnScreen[i].ref._x < -150)
      {
         roundsOnScreen[i].ref.removeMovieClip();
         roundsOnScreen.splice(i,1);
      }
      if(_root[currentWeapon].rangeType == "melee")
      {
         _loc2_ = new Object();
         _loc2_.x = mainGunRef.barrelEnd._x;
         _loc2_.y = mainGunRef.barrelEnd._y;
         mainGunRef.localToGlobal(_loc2_);
         if(roundsOnScreen[i].ref._x <= _loc2_.x - _root[currentWeapon].range)
         {
            roundsOnScreen[i].ref.removeMovieClip();
            roundsOnScreen.splice(i,1);
         }
      }
   }
   for(j in aliveZombies)
   {
      enemyOnScreen[j].ref.zombieHealth.text = enemyOnScreen[j].health;
      enemyOnScreen[j].ref.zombieDead.text = enemyOnScreen[j].dead;
      if(aliveZombies[j].dead == false)
      {
         if(aliveZombies[j].ref._x > 520 + aliveZombies[j].ref._y * 20 / 100 && !aliveZombies[j].idle == true && aliveZombies[j].dead == false)
         {
            aliveZombies[j].ref.gotoAndPlay("idlestop1");
            aliveZombies[j].idle = true;
         }
         else if(aliveZombies[j].idle == true && !wall.destroyed && aliveZombies[j].dead == false)
         {
            aliveZombies[j].ref.gotoAndPlay("attackWall" + random(50));
            wall.health -= aliveZombies[j].damage;
            checkWallStatus();
            if(wall.health <= -1)
            {
               wall.destroyed = true;
            }
         }
         else if(aliveZombies[j].idle == false && aliveZombies[j].dead == false && aliveZombies[j].beingExploded == false)
         {
            aliveZombies[j].ref._x += aliveZombies[j].speed;
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
                  trace("DEAD!");
                  _root.mainChar.gotoAndPlay("dead");
                  aliveZombies[j].ref.gotoAndPlay("lunge");
                  _root.attachMovie("gameOver","gameOver",50000);
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
         for(v in aliveZombies)
         {
            if(aliveZombies[v].ref.head.hitTest(roundsOnScreen[k].ref.collision) && aliveZombies[v].dead == false)
            {
               hitHelmet = random(5);
               if(hitHelmet <= 2 && aliveZombies[v].type == "zombieSoldier")
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
                  switch(_root[currentWeapon].name)
                  {
                     case "chainsaw":
                        aliveZombies[v].ref["bloodPackHead" + randomBloodPack].gotoAndPlay("chainsaw" + randomBloodAnimChainsaw);
                        hitBodySound = new Sound(stageBG);
                        hitBodySound.attachSound("sound_hitChainsaw" + (random(2) + 1));
                        hitBodySound.setVolume(100);
                        hitBodySound.start(0,1);
                        break;
                     case "flameThrower":
                        aliveZombies[v].ref.flamePackHead.play();
                        break;
                     default:
                        aliveZombies[v].ref["bloodPackHead" + randomBloodPack].gotoAndPlay("head" + randomBloodAnimHead);
                        hitBodySound = new Sound(stageBG);
                        hitBodySound.attachSound("sound_hitHead1");
                        hitBodySound.setVolume(100);
                        hitBodySound.start(0,1);
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
                     randomDeath = random(3) + 1;
                     if(aliveZombies[v].ref._x > 450)
                     {
                        aliveZombies[v].ref.gotoAndPlay("fallBackwards" + randomDeath);
                        zombiesKilled++;
                        deadZombieCount++;
                        aliveZombies[v].dead = true;
                        aliveZombies.splice(v,1);
                     }
                     else
                     {
                        aliveZombies[v].ref.gotoAndPlay("fallHead" + randomDeath);
                        zombiesKilled++;
                        deadZombieCount++;
                        aliveZombies[v].dead = true;
                        aliveZombies.splice(v,1);
                        sunRiseCheck();
                     }
                  }
               }
            }
            if(aliveZombies[v].ref.torso.hitTest(roundsOnScreen[k].ref.collision) && aliveZombies[j].dead == false)
            {
               if(aliveZombies[v].type == "zombieSoldier" || aliveZombies[v].type == "zombieSWAT")
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
                        aliveZombies[v].ref.flamePackTorso.play();
                        break;
                     default:
                        hitBodySound = new Sound(stageBG);
                        hitBodySound.attachSound("sound_hitBody" + (random(2) + 1));
                        hitBodySound.setVolume(100);
                        hitBodySound.start(0,1);
                        aliveZombies[v].ref["bloodPackTorso" + randomBloodPack].gotoAndPlay("base" + randomBloodAnim);
                  }
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
                     aliveZombies[v].ref.gotoAndPlay("fallBackwards" + randomDeath);
                     zombiesKilled++;
                     deadZombieCount++;
                     aliveZombies[v].dead = true;
                     aliveZombies.splice(v,1);
                     sunRiseCheck();
                  }
               }
            }
            if(aliveZombies[v].ref.legs.hitTest(roundsOnScreen[k].ref.collision) && aliveZombies[j].dead == false)
            {
               aliveZombies[v].health -= roundsOnScreen[k].damage + random(1);
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
                     aliveZombies[v].ref.flamePackLegs.play();
                     break;
                  default:
                     aliveZombies[v].ref["bloodPackLegs" + randomBloodPack].play();
                     hitLegSound = new Sound(stageBG);
                     hitLegSound.attachSound("sound_hitBody1");
                     hitLegSound.setVolume(100);
                     hitLegSound.start(0,1);
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
                     deadZombieCount++;
                     aliveZombies[v].dead = true;
                     aliveZombies.splice(v,1);
                  }
                  else
                  {
                     aliveZombies[v].ref.gotoAndPlay("fallForward" + randomDeath);
                     zombiesKilled++;
                     deadZombieCount++;
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
_quality = "medium";
mouseInitialised = "notyet";
_root.attachMovie("blackOut","mainBlackOut",1324);
_root.mainBlackOut.alphaTo(0,1.5,"easeOutSine",0.5,hideBlackOut);
_root.mainBlackOut.depth = 554000;
bullet = 0;
bulletLevel = 1;
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
zombieLimit = 9;
liveZombieCount = 0;
delay = 6;
roundsOnScreen = new Array();
enemyOnScreen = new Array();
deadZombies = new Array();
aliveZombies = new Array();
allWeapons = new Array();
x = 1;
zombiesCreated = 0;
var bodysOnScreenTime = 50;
mainGunRef = mainChar.mainGun;

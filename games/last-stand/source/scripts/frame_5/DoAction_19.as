function activateHelpers(numberToActivate)
{
   z = -1;
   while(z < maxHelpers)
   {
      if(numberToActivate > 0)
      {
         numberToActivate = numberToActivate - 1;
         helpersOnScreen[z].active = true;
         helpersOnScreen[z].killed = false;
         helpersOnScreen[z].running = false;
         helpersOnScreen[z].ammoInMag = helpersOnScreen[z].maxAmmo;
      }
      else
      {
         helpersOnScreen[z].active = false;
      }
      placeHelpers(z);
      z++;
   }
}
function placeHelpers(numberToPlace)
{
   p = -1;
   while(p < totalHelpers)
   {
      if(helpersOnScreen[p].active == true)
      {
         helpersOnScreen[p].ref.gotoAndStop(1);
         helpersOnScreen[p].ref.helperMainGun.gotoAndStop(1);
         helpersOnScreen[p].running = false;
         helpersOnScreen[p].helperReloading = false;
         helpersOnScreen[p].currentShotDelay = 50;
         if(helpersOnScreen[p].alreadyPlaced == false)
         {
            helpersOnScreen[p].alreadyPlaced = true;
            decorateHelper(helpersOnScreen[p].ref._name);
         }
         helpersOnScreen[p].ref._visible = true;
         helpersOnScreen[p].ref.onEnterFrame = function()
         {
            _root.survivorHelperFire(this._name);
         };
      }
      else
      {
         helpersOnScreen[p].active = false;
         helpersOnScreen[p].killed = true;
         helpersOnScreen[p].alreadyPlaced = false;
         helpersOnScreen[p].ref._visible = false;
         delete helpersOnScreen[p].ref.onEnterFrame;
      }
      p++;
   }
}
function decorateHelper(helperName)
{
   _root[helperName].helperMainGun.helperGun.gotoAndStop(_root[helperName + "_Object"].currentWeapon);
   randomTorsoColour = torsoColours[random(torsoColours.length)];
   _root[helperName].helperMainGun.dummyHead.gotoAndStop("survivor_head" + random(10));
   _root[helperName].helperMainGun.dummyFrontHand.attachMovie("survivorHand" + randomZombieTorso,"torso",x);
   _root[helperName].helperMainGun.dummyBackHand.attachMovie("survivorHand" + randomZombieTorso,"torso",x);
   _root[helperName].dummyHead.head.accessories.gotoAndStop(randomHeadAccessory);
   _root[helperName].dummyTorso.torsoAddons.gotoAndStop(randomTorsoAccessory);
   _root[helperName].dummyTorso.torso.colorTo(randomTorsoColour,0);
   _root[helperName].helperMainGun.dummyFrontUpperArm.upperArm.colorTo(randomTorsoColour,0);
   _root[helperName].helperMainGun.dummyFrontLowerArm.lowerArm.colorTo(randomTorsoColour,0);
   _root[helperName].helperMainGun.dummyBackUpperArm.upperArm.colorTo(randomTorsoColour,0);
   _root[helperName].helperMainGun.dummyBackLowerArm.lowerArm.colorTo(randomTorsoColour,0);
   randomLegColour = legColours[random(legColours.length)];
   _root[helperName].dummyFrontUpperLeg.upperLeg.colorTo(randomLegColour,0);
   _root[helperName].dummyFrontLowerLeg.lowerLeg.colorTo(randomLegColour,0);
   _root[helperName].dummyBackUpperLeg.upperLeg.colorTo(randomLegColour,0);
   _root[helperName].dummyBackLowerLeg.lowerLeg.colorTo(randomLegColour,0);
   _root[helperName].cacheAsBitmap = true;
}
function helperFinishedLoad(firedBy)
{
   _root[firedBy + "_Object"].ammoInMag = _root[firedBy + "_Object"].maxAmmo;
   _root[firedBy + "_Object"].helperReloading = false;
   clearInterval(_root[firedBy + "Reload"]);
}
function survivorHelperFire(firedBy)
{
   _root[firedBy + "_Object"].running = false;
   _root[firedBy + "_Object"].currentShotDelay--;
   runTimer--;
   var _loc4_;
   if(gamePaused == false && _root[firedBy + "_Object"].currentShotDelay <= 0 && _root[firedBy + "_Object"].ammoInMag >= 1)
   {
      _root[firedBy + "_Object"].firing = false;
      _root[firedBy + "_Object"].currentShotDelay = 50 + random(10);
      if(wall.health < 750 && _root[firedBy + "_Object"].running == false && runTimer <= 0)
      {
         _root[firedBy].helperMainGun.gotoAndPlay("scared");
         _root[firedBy].gotoAndPlay("runAway");
         _root[firedBy + "_Object"].running = true;
         runTimer = runTimerMax;
         delete _root[firedBy].onEnterFrame;
      }
      if(_root[firedBy + "_Object"].helperReloading == false && _root[firedBy + "_Object"].running == false)
      {
         _root[firedBy].helperMainGun.gotoAndStop("handgun_firing");
         clearInterval(_root[firedBy + "Reload"]);
         if(_root[firedBy + "_Object"].firing == false)
         {
            _root[firedBy + "_Object"].firing = true;
            for(p in aliveZombies)
            {
               _root[firedBy].proxX = _root[firedBy]._x - aliveZombies[p].ref._x;
               if(_root[firedBy].proxX < 600 && aliveZombies[p].ref._y >= _root[firedBy]._y - 40 && aliveZombies[p].ref._y <= _root[firedBy]._y + 50)
               {
                  bullet++;
                  _root[firedBy + "_Object"].ammoInMag--;
                  _root[firedBy].helperMainGun.helperGun.muzzleFlash.play();
                  firingHelperSound = new Sound(firedBy);
                  firingHelperSound.attachSound("sound_" + _root[firedBy + "_Object"].currentWeapon + "Fire");
                  firingHelperSound.setVolume(40);
                  firingHelperSound.start(0,1);
                  _loc4_ = new Object();
                  _loc4_.x = _root[firedBy].helperMainGun.helperGun.barrelEnd._x;
                  _loc4_.y = _root[firedBy].helperMainGun.helperGun.barrelEnd._y;
                  _root[firedBy].localToGlobal(_loc4_);
                  var helperRound = _root.attachMovie("round","helperRound" + bullet,bullet + 100);
                  helperRound.gotoAndStop("off");
                  helperRound._x = _loc4_.x;
                  helperRound._y = _loc4_.y;
                  helperRound.angle = random(8) - 4;
                  helperRound._rotation = helperRound.angle;
                  helperRound.onEnterFrame = function()
                  {
                     var _loc2_ = Math.cos(helperRound.angle * 3.141592653589793 / 180) * 90;
                     var _loc3_ = Math.sin(helperRound.angle * 3.141592653589793 / 180) * 80;
                     this._x -= _loc2_;
                     this._y -= _loc3_;
                  };
                  _root[firedBy].helperMainGun.gotoAndPlay("fire");
                  roundsOnScreen.push({ref:_root["helperRound" + bullet],damage:_root[_root[firedBy + "_Object"].currentWeapon].damage,headShotDamage:_root[_root[firedBy + "_Object"].currentWeapon].headShotDamage});
                  break;
               }
            }
         }
      }
   }
   else if(_root[firedBy + "_Object"].ammoInMag <= 0 && _root[firedBy + "_Object"].helperReloading == false && _root[firedBy + "_Object"].running == false)
   {
      _root[firedBy].helperMainGun.gotoAndPlay("handgun_reload");
      _root[firedBy + "_Object"].helperReloading = true;
      _root[firedBy + "Reload"] = setInterval(helperFinishedLoad,2500,firedBy);
   }
}
helpers = 0;
totalHelpers = 7;
totalHelpersCount = 0;
maxHelpers = 7;
helperTotal = 0;
helpersToRemove = 0;
currentRemove = 0;
removeCount = 0;
runTimer = 20;
runTimerMax = 20;
survivorCount = 0;
numberToActivate = 0;
numberToDeactivate = 0;
activateCount = 0;
endOfArray = 0;
AIHelp0_Object = new Object();
AIHelp0_Object.currentWeapon = "snubnose";
AIHelp0_Object.active = false;
AIHelp0_Object.maxAmmo = _root["" + AIHelp0_Object.currentWeapon].magazineCapacity;
AIHelp0_Object.ammoInMag = AIHelp0_Object.maxAmmo;
AIHelp0_Object.helperReloading = false;
AIHelp0_Object.running = false;
AIHelp1_Object.firing = false;
AIHelp1_Object = new Object();
AIHelp1_Object.currentWeapon = "pistol";
AIHelp1_Object.active = false;
AIHelp1_Object.maxAmmo = _root["" + AIHelp1_Object.currentWeapon].magazineCapacity;
AIHelp1_Object.ammoInMag = AIHelp1_Object.maxAmmo;
AIHelp1_Object.helperReloading = false;
AIHelp1_Object.running = false;
AIHelp1_Object.firing = false;
AIHelp2_Object = new Object();
AIHelp2_Object.currentWeapon = "pistol";
AIHelp2_Object.active = false;
AIHelp2_Object.maxAmmo = _root["" + AIHelp2_Object.currentWeapon].magazineCapacity;
AIHelp2_Object.ammoInMag = AIHelp2_Object.maxAmmo;
AIHelp2_Object.helperReloading = false;
AIHelp2_Object.running = false;
AIHelp2_Object.firing = false;
AIHelp3_Object = new Object();
AIHelp3_Object.currentWeapon = "revolver";
AIHelp3_Object.active = false;
AIHelp3_Object.maxAmmo = _root["" + AIHelp3_Object.currentWeapon].magazineCapacity;
AIHelp3_Object.ammoInMag = AIHelp3_Object.maxAmmo;
AIHelp3_Object.helperReloading = false;
AIHelp3_Object.running = false;
AIHelp3_Object.firing = false;
AIHelp4_Object = new Object();
AIHelp4_Object.currentWeapon = "snubnose";
AIHelp4_Object.active = false;
AIHelp4_Object.maxAmmo = _root["" + AIHelp4_Object.currentWeapon].magazineCapacity;
AIHelp4_Object.ammoInMag = AIHelp4_Object.maxAmmo;
AIHelp4_Object.helperReloading = false;
AIHelp4_Object.running = false;
AIHelp4_Object.firing = false;
AIHelp5_Object = new Object();
AIHelp5_Object.currentWeapon = "huntingRifle";
AIHelp5_Object.active = false;
AIHelp5_Object.maxAmmo = _root["" + AIHelp5_Object.currentWeapon].magazineCapacity;
AIHelp5_Object.ammoInMag = AIHelp5_Object.maxAmmo;
AIHelp5_Object.helperReloading = false;
AIHelp5_Object.running = false;
AIHelp5_Object.firing = false;
helpersOnScreen = new Array();
while(totalHelpersCount < totalHelpers)
{
   helpersOnScreen.push({ref:_root["AIHelp" + totalHelpersCount],active:false,alreadyPlaced:false,killed:false,running:false});
   totalHelpersCount++;
}
placeHelpers(6);

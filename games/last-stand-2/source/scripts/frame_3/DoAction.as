function theZombieDirector(currentZombieThreat)
{
   if(currentZombieThreat < location[currentTownLocation].zombieThreat + levelUp / 0.25)
   {
      delay--;
      if(delay <= 0 && liveZombieCount < zombieLimit)
      {
         delay = delayMax;
         threatDeficit = location[currentTownLocation].zombieThreat - currentZombieThreat;
         hud.locationNameText.text = location[currentTownLocation].name;
         hud.zombieThreatText.text = location[currentTownLocation].zombieThreat;
         findZombieType(threatDeficit);
      }
   }
}
function findZombieType(threatDeficit)
{
   isArmed = false;
   semiRareZombieChance = random(100) + 1;
   rareZombieChance = random(100) + 1;
   veryRareZombieChance = random(100) + 1;
   armedZombieChance = random(100) + 1;
   if(semiRareZombieChance <= location[currentTownLocation].semiRareZombieChance)
   {
      currentZombieType = semiRareZombies[random(semiRareZombies.length)];
   }
   else if(rareZombieChance <= location[currentTownLocation].rareZombieChance)
   {
      currentZombieType = rareZombies[random(rareZombies.length)];
   }
   else if(veryRareZombieChance <= location[currentTownLocation].veryRareZombieChance)
   {
      currentZombieType = veryRareZombies[random(veryRareZombies.length)];
   }
   else if(armedZombieChance <= location[currentTownLocation].armedZombieChance)
   {
      currentZombieType = armedZombies[random(armedZombies.length)];
      isArmed = true;
   }
   else
   {
      currentZombieType = commonZombies[random(commonZombies.length)];
   }
   assessZombieThreat(currentZombieType,isArmed);
}
function assessZombieThreat(currentZombieType, isArmed)
{
   if(currentZombieType.threat <= threatDeficit)
   {
      addNewZombie(currentZombieType.name,isArmed);
      if(threatDeficit - currentZombieType.threat > 0)
      {
         delay -= maxDelay;
      }
      else if(threatDeficit - currentZombieType.threat > 0)
      {
         delay -= maxDelay;
      }
   }
}
function addNewZombie(zombieType, isArmed)
{
   zombieDepthCount++;
   liveZombieCount++;
   if(zombieType == "zombieDog")
   {
      _root.attachMovie("zombieDog","enemy" + zombieDepthCount,zombieDepthCount + 3);
   }
   else
   {
      _root.attachMovie("newZombie","enemy" + zombieDepthCount,zombieDepthCount + 3);
   }
   zombiesCreated++;
   _root["enemy" + zombieDepthCount]._visible = false;
   _root["enemy" + zombieDepthCount].colorTransformTo(location[currentTownLocation].brightnessLevelZombies,0,location[currentTownLocation].brightnessLevelZombies,0,location[currentTownLocation].brightnessLevelZombies,0,100,0,0);
   var _loc3_ = random(location[currentTownLocation].numSpawnZones);
   var _loc4_ = location[currentTownLocation]["spawnZone" + _loc3_ + "_min"];
   var _loc6_ = location[currentTownLocation]["spawnZone" + _loc3_ + "_max"];
   var _loc7_ = _loc6_ - _loc4_;
   _root["enemy" + zombieDepthCount]._y = random(_loc7_) + _loc4_;
   _root["enemy" + zombieDepthCount]._x = random(150) - 200;
   _root["enemy" + zombieDepthCount].cacheAsBitmap = true;
   _root["enemy" + zombieDepthCount]._visible = true;
   _root["enemy" + zombieDepthCount].attackingWall = false;
   enemyOnScreen.push({ref:_root["enemy" + zombieDepthCount],depth:_root["enemy" + zombieDepthCount]._y});
   aliveZombies.push({ref:_root["enemy" + zombieDepthCount],type:zombieType,health:_root[zombieType].health,speed:_root[zombieType].speed,damage:_root[zombieType].damage,depth:_root["enemy" + zombieDepthCount]._y,idle:false,animating:false,eating:false,dead:false,proximity:0,proximityToExplosion:0,targetX:0,targetY:0,tempNum:0,beingExploded:false,arrowsStuckTorso:0,arrowsStuckHead:0,arrowsStuckLegs:0,threat:_root[zombieType].threat,directionCount:200,directionCountMax:120,currentDirection:"straight",burnDamageCountHead:0,burnDamageCountTorso:0,burnDamageCountLegs:0,armed:isArmed,targetYDiff:0,trapped:false});
   if(zombieType == "zombieSlow" || zombieType == "zombieFast" || zombieType == "zombieSprint" || zombieType == "zombieEater")
   {
      zombieAppearance("enemy" + zombieDepthCount,isArmed);
   }
   else
   {
      zombieAppearanceCustom("enemy" + zombieDepthCount,zombieType,isArmed);
   }
   currentZombieThreat += _root[zombieType].threat;
}
function spawnFragments(numFrags, grenadeX, grenadeY, range, type, damage)
{
   i = 0;
   var _loc4_;
   var _loc3_;
   var _loc5_;
   while(i <= numFrags)
   {
      bullet++;
      _loc4_ = new Object();
      _loc4_.x = grenadeX;
      _loc4_.y = grenadeY;
      _loc3_ = _root.attachMovie("round","round" + bullet,bullet + 310000);
      _root["round" + bullet].gotoAndStop("frag");
      _loc5_ = 100 - random(40);
      _root["round" + bullet]._xscale = _loc5_;
      _root["round" + bullet]._yscale = _loc5_;
      _loc3_._x = _loc4_.x;
      _loc3_._y = _loc4_.y;
      _loc3_.angle = random(360);
      _loc3_._rotation = _loc3_.angle;
      _loc3_.originX = grenadeX;
      _loc3_.originY = grenadeY;
      _loc3_.proximity = 0;
      _loc3_.ref = _root["round" + bullet];
      roundsOnScreen.push({ref:_root["round" + bullet],type:type,range:range + random(50),damage:damage,headShotDamage:damage * 2,owner:"hero",originX:grenadeX,originY:grenadeY,proximity:0});
      _loc3_.onEnterFrame = function()
      {
         this.x = Math.cos(this.angle * 3.141592653589793 / 180) * (80 - random(20));
         this.y = Math.sin(this.angle * 3.141592653589793 / 180) * (80 - random(20));
         this._x -= this.x;
         this._y -= this.y;
      };
      i++;
   }
}
function moveFragRounds(roundName, grenadeX, grenadeY)
{
   roundName.x = Math.cos(roundName.angle * 3.141592653589793 / 180) * _root[currentWeapon].roundSpeed;
   roundName.y = Math.sin(roundName.angle * 3.141592653589793 / 180) * _root[currentWeapon].roundSpeed;
   roundName._x -= roundName.x;
   roundName._y -= roundName.y;
}
function particleEmitter(particleType, particleName, particleDepth, particleX, particleY, particleGravity, particleQuantity, particleHorizontalEnergy, particleVerticalEnergy, particleFade, particleRotationRate, particleScaling, particleSplash)
{
   i = 0;
   var _loc2_;
   while(i <= particleQuantity)
   {
      particleCount++;
      _loc2_ = attachMovie(particleType,particleName + i,particleCount);
      _loc2_.ref = particleName + i;
      _loc2_.partType = particleType;
      _loc2_.gravity = particleGravity;
      _loc2_.HorzEnergy = Math.random() * particleHorizontalEnergy - particleHorizontalEnergy / 4;
      _loc2_.VertEnergy = Math.random() * particleVerticalEnergy - particleVerticalEnergy / 2;
      if(particleScaling == true)
      {
         _loc2_._xscale = _loc2_._yscale = random(60) + 30;
      }
      _loc2_._x = particleX;
      _loc2_._y = particleY;
      _loc2_.angle = 180;
      _loc2_._rotation = _loc2_.angle;
      _loc2_.rotation = particleRotationRate;
      _loc2_.acceleration = 5;
      _loc2_.particleFade = particleFade;
      _loc2_.splash = particleSplash;
      _loc2_.onEnterFrame = _root.moveParticle;
      i++;
   }
}
function moveParticle()
{
   with(this)
   {
      _alpha -= particleFade;
      if(_alpha < 8)
      {
         removeMovieClip();
      }
      this._rotation += rotation;
      this.x = Math.cos(this.angle * 3.141592653589793 / 180) * HorzEnergy;
      _x -= this.x;
      _y += VertEnergy += gravity;
   }
}
function zombieBloodParticle(targetX, targetY)
{
   particleEmitter("bloodParticle","bloodPart",100,targetX,targetY,0.35,Math.round(_root[currentWeapon].damage / 8),9,8,8,0,true,false);
}
function zombieHeadBloodParticle(targetX, targetY)
{
   particleEmitter("bloodParticle","bloodPart",100,targetX,targetY,0.35,Math.round(_root[currentWeapon].headShotDamage / 8),9,8,8,0,true,false);
}
function zombieLegBloodParticle(targetX, targetY)
{
   particleEmitter("bloodParticle","bloodPart",100,targetX,targetY,0.35,1,10,8,8,0,true,false);
}
function zombieChainsawBloodParticle(targetX, targetY)
{
   particleEmitter("bloodParticle","bloodPart",100,targetX,targetY,0.35,8,9,8,4,0,true,false);
}
function survivorBloodParticle(targetX, targetY)
{
   particleEmitter("bloodParticle","bloodPart",100,targetX,targetY,0.35,15,9,8,8,0,true,false);
}
function depthSortFriendlies()
{
   var _loc2_ = new Array();
   for(var _loc1_ in friendliesOnScreen)
   {
      if(friendliesOnScreen[_loc1_].ref != null)
      {
         friendliesOnScreen[_loc1_].depth = friendliesOnScreen[_loc1_].ref._y;
         _loc2_.push(friendliesOnScreen[_loc1_]);
      }
   }
   _loc2_.sortOn("depth",Array.NUMERIC,Array.DESCENDING);
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc2_[_loc1_].ref.swapDepths(survivorDepthCount + _loc1_ + 163486);
      _loc1_ = _loc1_ + 1;
   }
}
function openJournal()
{
   timeManager.journal.journalScribbles.gotoAndStop("blank");
   timeManager.journal.journalDayNumber.text = "DAY " + levelUp;
   timeManager.journal.journalText.text = location[currentTownLocation].journalText;
   timeManager.journal.journalEntryHeading.text = location[currentTownLocation].journalHeading;
   timeManager.journal.ySlideTo(10,0.8,"easeOutSine",0);
}
function openIntroJournal()
{
   introJournal.journalDayNumber.text = "DAY " + levelUp;
   introJournal.journalText.text = location.glenDale.journalText;
   introJournal.journalEntryHeading.text = location.glenDale.journalHeading;
   introJournal.ySlideTo(10,0.8,"easeOutSine",1);
}
function closeIntroJournal()
{
   _root.introBlackOut.alphaTo(100,3,"easeOutSine",0,startGameFromJournal);
}
function startGameFromJournal()
{
   _root.gotoAndStop("game");
}
function closeJournal()
{
   timeManager.journal.ySlideTo(420,1.2,"easeOutSine",0);
   clipBoardUp();
}
_global.$createTweenController = function()
{
   var _loc3_ = _root.createEmptyMovieClip("__tweenController__",123432);
   _loc3_.$_tweenPropList = new Array();
   _loc3_.$_tTime = getTimer();
   _loc3_.onEnterFrame = _global.$updateTweens;
};
ASSetPropFlags(_global,"$createTweenController",1,0);
_global.$removeTweenController = function()
{
   delete _root.__tweenController__.$_tweenPropList;
   delete _root.__tweenController__.$_tTime;
   delete _root.__tweenController__.onEnterFrame;
   _root.__tweenController__.removeMovieClip();
};
ASSetPropFlags(_global,"$removeTweenController",1,0);
_global.$addTween = function(mtarget, prop, propDest, timeSeconds, animType, delay, callback, extra1, extra2, extras)
{
   if(timeSeconds == undefined)
   {
      timeSeconds = 0;
   }
   if(animType == undefined || animType == "")
   {
      animType = "easeOutExpo";
   }
   if(delay == undefined)
   {
      delay = 0;
   }
   var _loc7_;
   var _loc11_;
   var _loc9_;
   if(typeof prop == "string")
   {
      _loc7_ = [prop];
      _loc11_ = [mtarget[prop]];
      _loc9_ = [propDest];
   }
   else
   {
      _loc7_ = [];
      _loc11_ = [];
      _loc9_ = [];
      for(var _loc32_ in prop)
      {
         _loc11_.push(mtarget[prop[_loc32_]]);
      }
      for(_loc32_ in prop)
      {
         _loc7_.push(prop[_loc32_]);
      }
      for(_loc32_ in propDest)
      {
         _loc9_.push(propDest[_loc32_]);
      }
   }
   var _loc12_ = false;
   if(_root.__tweenController__ == undefined)
   {
      _global.$createTweenController();
   }
   var _loc4_ = _root.__tweenController__.$_tweenPropList;
   var _loc8_ = _root.__tweenController__.$_tTime;
   var _loc3_;
   for(_loc32_ in _loc11_)
   {
      if(_loc9_[_loc32_] != undefined && !mtarget.$_isTweenLocked)
      {
         if(mtarget.$_tweenCount > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               if(_loc4_[_loc3_]._targ == mtarget && _loc4_[_loc3_]._prop == _loc7_[_loc32_])
               {
                  if(_loc8_ + delay * 1000 < _loc4_[_loc3_]._timeDest)
                  {
                     _loc4_.splice(_loc3_,1);
                     _loc3_ = _loc3_ - 1;
                     mtarget.$_tweenCount = mtarget.$_tweenCount - 1;
                  }
               }
               _loc3_ = _loc3_ + 1;
            }
         }
         _loc4_.push({_prop:_loc7_[_loc32_],_targ:mtarget,_propStart:undefined,_propDest:_loc9_[_loc32_],_timeStart:_loc8_,_timeDest:_loc8_ + timeSeconds * 1000,_animType:animType,_extra1:extra1,_extra2:extra2,_extras:extras,_delay:delay,_isPaused:false,_timePaused:0,_callback:(!_loc12_ ? callback : undefined)});
         mtarget.$_tweenCount = mtarget.$_tweenCount <= 0 ? 1 : mtarget.$_tweenCount + 1;
         _loc12_ = true;
      }
   }
   ASSetPropFlags(mtarget,"$_tweenCount",1,0);
};
ASSetPropFlags(_global,"$addTween",1,0);
_global.$updateTweens = function()
{
   var _loc0_;
   var _loc8_ = this.$_tTime = getTimer();
   var _loc6_ = 0;
   var _loc3_;
   var _loc5_;
   var _loc10_;
   var _loc4_;
   var _loc7_;
   var _loc9_;
   var _loc11_;
   while(_loc6_ < this.$_tweenPropList.length)
   {
      _loc3_ = this.$_tweenPropList[_loc6_];
      if(_loc3_._targ.toString() == undefined)
      {
         this.$_tweenPropList.splice(_loc6_,1);
         _loc6_ = _loc6_ - 1;
      }
      else if(_loc3_._timeStart + _loc3_._delay * 1000 <= _loc8_ && !_loc3_._isPaused)
      {
         if(_loc3_._propStart == undefined)
         {
            if(_loc3_._prop.substr(0,10) == "__special_")
            {
               if(_loc3_._prop == "__special_mc_frame__")
               {
                  _loc3_._propStart = _loc3_._targ._currentframe;
               }
               else if(_loc3_._prop == "__special_mc_ra__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().ra;
               }
               else if(_loc3_._prop == "__special_mc_rb__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().rb;
               }
               else if(_loc3_._prop == "__special_mc_ga__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().ga;
               }
               else if(_loc3_._prop == "__special_mc_gb__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().gb;
               }
               else if(_loc3_._prop == "__special_mc_ba__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().ba;
               }
               else if(_loc3_._prop == "__special_mc_bb__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().bb;
               }
               else if(_loc3_._prop == "__special_mc_aa__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().aa;
               }
               else if(_loc3_._prop == "__special_mc_ab__")
               {
                  _loc3_._propStart = new Color(_loc3_._targ).getTransform().ab;
               }
               else if(_loc3_._prop == "__special_text_r__")
               {
                  _loc3_._propStart = _loc3_._targ.textColor >> 16;
               }
               else if(_loc3_._prop == "__special_text_g__")
               {
                  _loc3_._propStart = (_loc3_._targ.textColor & 0xFF00) >> 8;
               }
               else if(_loc3_._prop == "__special_text_b__")
               {
                  _loc3_._propStart = _loc3_._targ.textColor & 0xFF;
               }
               else if(_loc3_._prop == "__special_sound_volume__")
               {
                  _loc3_._propStart = _loc3_._targ.getVolume();
               }
               else if(_loc3_._prop == "__special_sound_pan__")
               {
                  _loc3_._propStart = _loc3_._targ.getPan();
               }
               else if(_loc3_._prop == "__special_bst_t__")
               {
                  _loc3_._propStart = 0;
                  _loc3_._extras.__special_bst_ix__ = _loc3_._targ._x;
                  _loc3_._extras.__special_bst_iy__ = _loc3_._targ._y;
               }
               else if(_loc3_._prop == "__special_blur_x__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BlurFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].blurX;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_blur_y__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BlurFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].blurY;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_glow_color__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.GlowFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].color;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 16777215;
                  }
               }
               else if(_loc3_._prop == "__special_glow_alpha__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.GlowFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].alpha;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 1;
                  }
               }
               else if(_loc3_._prop == "__special_glow_blurX__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.GlowFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].blurX;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_glow_blurY__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.GlowFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].blurY;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_glow_strength__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.GlowFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].strength;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 1;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_distance__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].distance;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_angle__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].angle;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 45;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_highlightColor__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].highlightColor;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 16777215;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_highlightAlpha__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].highlightAlpha;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 1;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_shadowColor__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].shadowColor;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_shadowAlpha__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].shadowAlpha;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 1;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_blurX__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].blurX;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_blurY__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].blurY;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 0;
                  }
               }
               else if(_loc3_._prop == "__special_bevel_strength__")
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_._targ.filters.length)
                  {
                     if(_loc3_._targ.filters[_loc5_] instanceof flash.filters.BevelFilter)
                     {
                        _loc3_._propStart = _loc3_._targ.filters[_loc5_].strength;
                     }
                     _loc5_ = _loc5_ + 1;
                  }
                  if(_loc3_._propStart == undefined)
                  {
                     _loc3_._propStart = 1;
                  }
               }
               else
               {
                  _loc3_._propStart = _loc3_._targ[_loc3_._prop];
               }
            }
            else
            {
               _loc3_._propStart = _loc3_._targ[_loc3_._prop];
            }
         }
         _loc10_ = _loc3_._timeDest + _loc3_._delay * 1000;
         if(_loc10_ <= _loc8_)
         {
            _loc4_ = _loc3_._propDest;
         }
         else
         {
            _loc4_ = _global.findTweenValue(_loc3_._propStart,_loc3_._propDest,_loc3_._timeStart,_loc8_ - _loc3_._delay * 1000,_loc3_._timeDest,_loc3_._animType,_loc3_._extra1,_loc3_._extra2);
         }
         _loc3_._targ[_loc3_._prop] = !_loc3_._extras.mustRound ? _loc4_ : Math.round(_loc4_);
         if(_loc3_._prop == "__special_mc_frame__")
         {
            _loc3_._targ.gotoAndStop(Math.round(_loc4_));
         }
         else if(_loc3_._prop == "__special_mc_ra__")
         {
            new Color(_loc3_._targ).setTransform({ra:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_rb__")
         {
            new Color(_loc3_._targ).setTransform({rb:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_ga__")
         {
            new Color(_loc3_._targ).setTransform({ga:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_gb__")
         {
            new Color(_loc3_._targ).setTransform({gb:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_ba__")
         {
            new Color(_loc3_._targ).setTransform({ba:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_bb__")
         {
            new Color(_loc3_._targ).setTransform({bb:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_aa__")
         {
            new Color(_loc3_._targ).setTransform({aa:_loc4_});
         }
         else if(_loc3_._prop == "__special_mc_ab__")
         {
            new Color(_loc3_._targ).setTransform({ab:_loc4_});
         }
         if(_loc3_._prop == "__special_bst_t__")
         {
            _loc7_ = _loc3_._extras;
            _loc9_ = _global.findPointOnCurve(_loc7_.__special_bst_ix__,_loc7_.__special_bst_iy__,_loc7_.__special_bst_cx__,_loc7_.__special_bst_cy__,_loc7_.__special_bst_dx__,_loc7_.__special_bst_dy__,_loc4_);
            if(_loc3_._extras.mustRound)
            {
               _loc3_._targ._x = Math.round(_loc9_.x);
               _loc3_._targ._y = Math.round(_loc9_.y);
            }
            else
            {
               _loc3_._targ._x = _loc9_.x;
               _loc3_._targ._y = _loc9_.y;
            }
         }
         if(typeof _loc3_._targ != "movieclip" && _loc3_._prop == "__special_text_b__")
         {
            _loc3_._targ.textColor = (_loc3_._targ.__special_text_r__ << 16) + (_loc3_._targ.__special_text_g__ << 8) + _loc3_._targ.__special_text_b__;
         }
         if(_loc3_._prop == "__special_sound_volume__")
         {
            _loc3_._targ.setVolume(_loc4_);
         }
         if(_loc3_._prop == "__special_sound_pan__")
         {
            _loc3_._targ.setPan(_loc4_);
         }
         if(_loc3_._prop == "__special_blur_x__")
         {
            _global.$setFilterProperty(_loc3_._targ,"blur_blurX",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_blur_y__")
         {
            _global.$setFilterProperty(_loc3_._targ,"blur_blurY",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_glow_color__")
         {
            _global.$setFilterProperty(_loc3_._targ,"glow_color",_global.findTweenColor(_loc3_,_loc8_),_loc3_._extras);
         }
         if(_loc3_._prop == "__special_glow_alpha__")
         {
            _global.$setFilterProperty(_loc3_._targ,"glow_alpha",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_glow_blurX__")
         {
            _global.$setFilterProperty(_loc3_._targ,"glow_blurX",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_glow_blurY__")
         {
            _global.$setFilterProperty(_loc3_._targ,"glow_blurY",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_glow_strength__")
         {
            _global.$setFilterProperty(_loc3_._targ,"glow_strength",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_distance__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_distance",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_angle__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_angle",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_highlightColor__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_highlightColor",_global.findTweenColor(_loc3_,_loc8_),_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_highlightAlpha__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_highlightAlpha",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_shadowColor__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_shadowColor",_global.findTweenColor(_loc3_,_loc8_),_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_shadowAlpha__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_shadowAlpha",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_blurX__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_blurX",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_blurY__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_blurY",_loc4_,_loc3_._extras);
         }
         if(_loc3_._prop == "__special_bevel_strength__")
         {
            _global.$setFilterProperty(_loc3_._targ,"bevel_strength",_loc4_,_loc3_._extras);
         }
         if(_loc3_._targ.onTweenUpdate != undefined)
         {
            _loc3_._targ.onTweenUpdate(_loc3_._prop);
         }
         if(_loc10_ <= _loc8_)
         {
            if(_loc3_._targ.onTweenComplete != undefined)
            {
               _loc3_._targ.onTweenComplete(_loc3_._prop);
            }
            _global.$stopTween(_loc3_._targ,[_loc3_._prop],false);
            _loc6_ = _loc6_ - 1;
            if(_loc3_._callback != undefined)
            {
               if(_global.backwardCallbackTweening)
               {
                  _loc11_ = _loc3_._targ.createEmptyMovieClip("__child__",122344);
                  _loc3_._callback.apply(_loc11_,null);
                  _loc11_.removeMovieClip();
               }
               else
               {
                  _loc3_._callback.apply(_loc3_._targ,null);
               }
            }
         }
      }
      _loc6_ = _loc6_ + 1;
   }
   if(this.$_tweenPropList.length == 0)
   {
      _global.$removeTweenController();
   }
};
ASSetPropFlags(_global,"$updateTween",1,0);
_global.$stopTween = function(mtarget, props, wipeFuture)
{
   var _loc4_ = _root.__tweenController__.$_tweenPropList;
   var _loc7_;
   var _loc5_;
   for(var _loc9_ in _loc4_)
   {
      _loc7_ = _loc4_[_loc9_]._prop;
      _loc5_ = 0;
      while(_loc5_ < props.length || _loc5_ < 1 && props == undefined)
      {
         if(_loc4_[_loc9_]._targ == mtarget && (_loc7_ == props[_loc5_] || props == undefined) && (wipeFuture || _loc4_[_loc9_]._timeDest + _loc4_[_loc9_]._delay * 1000 <= getTimer()))
         {
            switch(_loc7_)
            {
               case "__special_mc_frame__":
               case "__special_mc_ra__":
               case "__special_mc_rb__":
               case "__special_mc_ga__":
               case "__special_mc_gb__":
               case "__special_mc_ba__":
               case "__special_mc_bb__":
               case "__special_mc_aa__":
               case "__special_mc_ab__":
               case "__special_sound_volume__":
               case "__special_bst_t__":
                  delete mtarget[_loc7_];
                  break;
               case "__special_text_b__":
                  delete mtarget.__special_text_r__;
                  delete mtarget.__special_text_g__;
                  delete mtarget.__special_text_b__;
            }
            _loc4_.splice(_loc9_,1);
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   if(props == undefined)
   {
      delete mtarget.$_tweenCount;
   }
   else
   {
      mtarget.$_tweenCount = 0;
      for(_loc9_ in _loc4_)
      {
         if(_loc4_[_loc9_]._targ == mtarget)
         {
            mtarget.$_tweenCount = mtarget.$_tweenCount + 1;
         }
      }
      if(mtarget.$_tweenCount == 0)
      {
         delete mtarget.$_tweenCount;
      }
   }
   if(_loc4_.length == 0)
   {
      _global.$removeTweenController();
   }
};
ASSetPropFlags(_global,"$stopTween",1,0);
_global.$setFilterProperty = function(mtarget, propName, propValue, extras)
{
   var _loc1_;
   var _loc7_ = false;
   var _loc3_ = [];
   _loc1_ = 0;
   while(_loc1_ < mtarget.filters.length)
   {
      _loc3_.push(mtarget.filters[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   var _loc9_;
   var _loc8_;
   var _loc12_;
   var _loc10_;
   var _loc11_;
   if(propName.substr(0,5) == "blur_")
   {
      _loc1_ = 0;
      while(_loc1_ < mtarget.filters.length)
      {
         if(_loc3_[_loc1_] instanceof flash.filters.BlurFilter)
         {
            _loc3_[_loc1_][propName.substr(5)] = propValue;
            if(extras.__special_blur_quality__ != undefined)
            {
               _loc3_[_loc1_].quality = extras.__special_blur_quality__;
            }
            _loc7_ = true;
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(!_loc7_)
      {
         _loc8_ = extras.__special_blur_quality__ != undefined ? extras.__special_blur_quality__ : 2;
         if(propName == "blur_blurX")
         {
            _loc9_ = new flash.filters.BlurFilter(propValue,0,_loc8_);
         }
         if(propName == "blur_blurY")
         {
            _loc9_ = new flash.filters.BlurFilter(0,propValue,_loc8_);
         }
         _loc3_.push(_loc9_);
      }
   }
   else if(propName.substr(0,5) == "glow_")
   {
      _loc1_ = 0;
      while(_loc1_ < mtarget.filters.length)
      {
         if(_loc3_[_loc1_] instanceof flash.filters.GlowFilter)
         {
            _loc3_[_loc1_][propName.substr(5)] = propValue;
            if(extras.__special_glow_quality__ != undefined)
            {
               _loc3_[_loc1_].quality = extras.__special_glow_quality__;
            }
            if(extras.__special_glow_inner__ != undefined)
            {
               _loc3_[_loc1_].inner = extras.__special_glow_inner__;
            }
            if(extras.__special_glow_knockout__ != undefined)
            {
               _loc3_[_loc1_].knockout = extras.__special_glow_knockout__;
            }
            _loc7_ = true;
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(!_loc7_)
      {
         _loc8_ = extras.__special_glow_quality__ != undefined ? extras.__special_glow_quality__ : 2;
         _loc12_ = extras.__special_glow_inner__ != undefined ? extras.__special_glow_inner__ : false;
         _loc10_ = extras.__special_glow_knockout__ != undefined ? extras.__special_glow_knockout__ : false;
         if(propName == "glow_color")
         {
            _loc9_ = new flash.filters.GlowFilter(propValue,1,0,0,1,_loc8_,_loc12_,_loc10_);
         }
         if(propName == "glow_alpha")
         {
            _loc9_ = new flash.filters.GlowFilter(16777215,propValue,0,0,1,_loc8_,_loc12_,_loc10_);
         }
         if(propName == "glow_blurX")
         {
            _loc9_ = new flash.filters.GlowFilter(16777215,1,propValue,0,1,_loc8_,_loc12_,_loc10_);
         }
         if(propName == "glow_blurY")
         {
            _loc9_ = new flash.filters.GlowFilter(16777215,1,0,propValue,1,_loc8_,_loc12_,_loc10_);
         }
         if(propName == "glow_strength")
         {
            _loc9_ = new flash.filters.GlowFilter(16777215,1,0,0,propValue,_loc8_,_loc12_,_loc10_);
         }
         _loc3_.push(_loc9_);
      }
   }
   else
   {
      if(propName.substr(0,6) != "bevel_")
      {
         return undefined;
      }
      _loc1_ = 0;
      while(_loc1_ < mtarget.filters.length)
      {
         if(_loc3_[_loc1_] instanceof flash.filters.BevelFilter)
         {
            _loc3_[_loc1_][propName.substr(6)] = propValue;
            if(extras.__special_bevel_quality__ != undefined)
            {
               _loc3_[_loc1_].quality = extras.__special_bevel_quality__;
            }
            if(extras.__special_bevel_type__ != undefined)
            {
               _loc3_[_loc1_].inner = extras.__special_bevel_type__;
            }
            if(extras.__special_bevel_knockout__ != undefined)
            {
               _loc3_[_loc1_].knockout = extras.__special_bevel_knockout__;
            }
            _loc7_ = true;
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(!_loc7_)
      {
         _loc8_ = extras.__special_bevel_quality__ != undefined ? extras.__special_bevel_quality__ : 2;
         _loc11_ = extras.__special_bevel_type__ != undefined ? extras.__special_bevel_type__ : "inner";
         _loc10_ = extras.__special_bevel_knockout__ != undefined ? extras.__special_bevel_knockout__ : false;
         if(propName == "bevel_distance")
         {
            _loc9_ = new flash.filters.BevelFilter(propValue,45,16777215,1,0,1,0,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_angle")
         {
            _loc9_ = new flash.filters.BevelFilter(0,propValue,16777215,1,0,1,0,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_highlightColor")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,propValue,1,0,1,0,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_highlightAlpha")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,16777215,propValue,0,1,0,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_shadowColor")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,16777215,1,propValue,1,0,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_shadowAlpha")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,16777215,1,0,propValue,0,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_blurX")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,16777215,1,0,1,propValue,0,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_blurY")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,16777215,1,0,1,0,propValue,1,_loc8_,_loc11_,_loc10_);
         }
         if(propName == "bevel_strength")
         {
            _loc9_ = new flash.filters.BevelFilter(0,45,16777215,1,0,1,0,0,propValue,_loc8_,_loc11_,_loc10_);
         }
         _loc3_.push(_loc9_);
      }
   }
   mtarget.filters = _loc3_;
};
MovieClip.prototype.tween = TextField.prototype.tween = Sound.prototype.tween = function(prop, propDest, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,prop,propDest,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"tween",1,0);
ASSetPropFlags(TextField.prototype,"tween",1,0);
ASSetPropFlags(Sound.prototype,"tween",1,0);
MovieClip.prototype.roundedTween = TextField.prototype.roundedTween = Sound.prototype.roundedTween = function(prop, propDest, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,prop,propDest,timeSeconds,animType,delay,callback,extra1,extra2,{mustRound:true});
};
ASSetPropFlags(MovieClip.prototype,"roundedTween",1,0);
ASSetPropFlags(TextField.prototype,"roundedTween",1,0);
ASSetPropFlags(Sound.prototype,"roundedTween",1,0);
MovieClip.prototype.stopTween = TextField.prototype.stopTween = Sound.prototype.stopTween = function(props)
{
   if(typeof props == "string")
   {
      props = [props];
   }
   var _loc4_;
   if(props != undefined)
   {
      _loc4_ = 1;
      while(_loc4_ < arguments.length)
      {
         props.push(arguments[_loc4_]);
         _loc4_ = _loc4_ + 1;
      }
   }
   _global.$stopTween(this,props,true);
};
ASSetPropFlags(MovieClip.prototype,"stopTween",1,0);
ASSetPropFlags(TextField.prototype,"stopTween",1,0);
ASSetPropFlags(Sound.prototype,"stopTween",1,0);
MovieClip.prototype.pauseTween = TextField.prototype.pauseTween = Sound.prototype.pauseTween = function(props)
{
   var _loc6_;
   if(props != undefined)
   {
      if(typeof props == "string")
      {
         props = [props];
      }
      _loc6_ = 1;
      while(_loc6_ < Arguments.length)
      {
         props.push(Arguments[_loc6_]);
         _loc6_ = _loc6_ + 1;
      }
   }
   var _loc4_ = _root.__tweenController__.$_tweenPropList;
   var _loc5_;
   for(var _loc7_ in _loc4_)
   {
      if(_loc4_[_loc7_]._targ == this && !_loc4_[_loc7_]._isPaused)
      {
         if(props != undefined)
         {
            _loc5_ = false;
            for(_loc6_ in props)
            {
               if(props[_loc6_] == _loc4_[_loc7_]._prop)
               {
                  _loc5_ = true;
                  break;
               }
            }
         }
         if(props == undefined || _loc5_)
         {
            _loc4_[_loc7_]._isPaused = true;
            _loc4_[_loc7_]._timePaused = _root.__tweenController__.$_tTime;
         }
      }
   }
};
ASSetPropFlags(MovieClip.prototype,"pauseTween",1,0);
ASSetPropFlags(TextField.prototype,"pauseTween",1,0);
ASSetPropFlags(Sound.prototype,"pauseTween",1,0);
MovieClip.prototype.resumeTween = TextField.prototype.resumeTween = Sound.prototype.resumeTween = function(props)
{
   var _loc7_;
   if(props != undefined)
   {
      if(typeof props == "string")
      {
         props = [props];
      }
      _loc7_ = 1;
      while(_loc7_ < Arguments.length)
      {
         props.push(Arguments[_loc7_]);
         _loc7_ = _loc7_ + 1;
      }
   }
   var _loc3_ = _root.__tweenController__.$_tweenPropList;
   var _loc5_;
   var _loc6_;
   for(var _loc8_ in _loc3_)
   {
      if(_loc3_[_loc8_]._targ == this && _loc3_[_loc8_]._isPaused)
      {
         if(props != undefined)
         {
            _loc5_ = false;
            for(_loc7_ in props)
            {
               if(props[_loc7_] == _loc3_[_loc8_]._prop)
               {
                  _loc5_ = true;
                  break;
               }
            }
         }
         if(props == undefined || _loc5_)
         {
            _loc3_[_loc8_]._isPaused = false;
            _loc6_ = _root.__tweenController__.$_tTime - _loc3_[_loc8_]._timePaused;
            _loc3_[_loc8_]._timeStart += _loc6_;
            _loc3_[_loc8_]._timeDest += _loc6_;
            _loc3_[_loc8_]._timePaused = 0;
         }
      }
   }
};
ASSetPropFlags(MovieClip.prototype,"resumeTween",1,0);
ASSetPropFlags(TextField.prototype,"resumeTween",1,0);
ASSetPropFlags(Sound.prototype,"resumeTween",1,0);
MovieClip.prototype.lockTween = TextField.prototype.lockTween = Sound.prototype.lockTween = function()
{
   this.$_isTweenLocked = true;
   ASSetPropFlags(this,"this.$_isTweenLocked",1,0);
};
ASSetPropFlags(MovieClip.prototype,"lockTween",1,0);
ASSetPropFlags(TextField.prototype,"lockTween",1,0);
ASSetPropFlags(Sound.prototype,"lockTween",1,0);
MovieClip.prototype.unlockTween = TextField.prototype.unlockTween = Sound.prototype.unlockTween = function()
{
   delete this.$_isTweenLocked;
};
ASSetPropFlags(MovieClip.prototype,"unlockTween",1,0);
ASSetPropFlags(TextField.prototype,"unlockTween",1,0);
ASSetPropFlags(Sound.prototype,"unlockTween",1,0);
MovieClip.prototype.getTweens = TextField.prototype.getTweens = Sound.prototype.getTweens = function()
{
   return this.$_tweenCount;
};
ASSetPropFlags(MovieClip.prototype,"getTweens",1,0);
ASSetPropFlags(TextField.prototype,"getTweens",1,0);
ASSetPropFlags(Sound.prototype,"getTweens",1,0);
MovieClip.prototype.isTweening = TextField.prototype.isTweening = Sound.prototype.isTweening = function()
{
   return this.$_tweenCount <= 0 ? false : true;
};
ASSetPropFlags(MovieClip.prototype,"isTweening",1,0);
ASSetPropFlags(TextField.prototype,"isTweening",1,0);
ASSetPropFlags(Sound.prototype,"isTweening",1,0);
MovieClip.prototype.alphaTo = TextField.prototype.alphaTo = function(propDest_a, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_alpha",propDest_a,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"alphaTo",1,0);
ASSetPropFlags(TextField.prototype,"alphaTo",1,0);
MovieClip.prototype.frameTo = function(propDest_frame, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"__special_mc_frame__",propDest_frame,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"frameTo",1,0);
MovieClip.prototype.resizeTo = TextField.prototype.resizeTo = function(propDest_width, propDest_height, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["_width","_height"],[propDest_width,propDest_height],timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"resizeTo",1,0);
ASSetPropFlags(TextField.prototype,"resizeTo",1,0);
MovieClip.prototype.rotateTo = TextField.prototype.rotateTo = function(propDest_rotation, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_rotation",propDest_rotation,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"rotateTo",1,0);
ASSetPropFlags(TextField.prototype,"rotateTo",1,0);
MovieClip.prototype.scaleTo = TextField.prototype.scaleTo = function(propDest_scale, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["_xscale","_yscale"],[propDest_scale,propDest_scale],timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"scaleTo",1,0);
ASSetPropFlags(TextField.prototype,"scaleTo",1,0);
MovieClip.prototype.xScaleTo = TextField.prototype.xScaleTo = function(propDest_scale, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_xscale",propDest_scale,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"xScaleTo",1,0);
ASSetPropFlags(TextField.prototype,"xScaleTo",1,0);
MovieClip.prototype.yScaleTo = TextField.prototype.yScaleTo = function(propDest_scale, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_yscale",propDest_scale,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"yScaleTo",1,0);
ASSetPropFlags(TextField.prototype,"yScaleTo",1,0);
TextField.prototype.scrollTo = function(propDest_scroll, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"scroll",propDest_scroll,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(TextField.prototype,"scrollTo",1,0);
MovieClip.prototype.slideTo = TextField.prototype.slideTo = function(propDest_x, propDest_y, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["_x","_y"],[propDest_x,propDest_y],timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"slideTo",1,0);
ASSetPropFlags(TextField.prototype,"slideTo",1,0);
MovieClip.prototype.roundedSlideTo = TextField.prototype.roundedSlideTo = function(propDest_x, propDest_y, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["_x","_y"],[propDest_x,propDest_y],timeSeconds,animType,delay,callback,extra1,extra2,{mustRound:true});
};
ASSetPropFlags(MovieClip.prototype,"roundedSlideTo",1,0);
ASSetPropFlags(TextField.prototype,"roundedSlideTo",1,0);
MovieClip.prototype.xSlideTo = TextField.prototype.xSlideTo = function(propDest_x, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_x",propDest_x,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"xSlideTo",1,0);
ASSetPropFlags(TextField.prototype,"xSlideTo",1,0);
MovieClip.prototype.roundedXSlideTo = TextField.prototype.roundedXSlideTo = function(propDest_x, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_x",propDest_x,timeSeconds,animType,delay,callback,extra1,extra2,{mustRound:true});
};
ASSetPropFlags(MovieClip.prototype,"roundedXSlideTo",1,0);
ASSetPropFlags(TextField.prototype,"roundedXSlideTo",1,0);
MovieClip.prototype.ySlideTo = TextField.prototype.ySlideTo = function(propDest_y, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_y",propDest_y,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(MovieClip.prototype,"ySlideTo",1,0);
ASSetPropFlags(TextField.prototype,"ySlideTo",1,0);
MovieClip.prototype.roundedYSlideTo = TextField.prototype.roundedYSlideTo = function(propDest_y, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"_y",propDest_y,timeSeconds,animType,delay,callback,extra1,extra2,{mustRound:true});
};
ASSetPropFlags(MovieClip.prototype,"roundedYSlideTo",1,0);
ASSetPropFlags(TextField.prototype,"roundedYSlideTo",1,0);
MovieClip.prototype.bezierSlideTo = TextField.prototype.bezierSlideTo = function(cpoint_x, cpoint_y, propDest_x, propDest_y, timeSeconds, animType, delay, callback, extra1, extra2)
{
   var _loc3_ = new Object();
   _loc3_.__special_bst_ix__ = undefined;
   _loc3_.__special_bst_iy__ = undefined;
   _loc3_.__special_bst_cx__ = cpoint_x;
   _loc3_.__special_bst_cy__ = cpoint_y;
   _loc3_.__special_bst_dx__ = propDest_x;
   _loc3_.__special_bst_dy__ = propDest_y;
   _global.$addTween(this,"__special_bst_t__",1,timeSeconds,animType,delay,callback,extra1,extra2,_loc3_);
};
ASSetPropFlags(MovieClip.prototype,"bezierSlideTo",1,0);
ASSetPropFlags(TextField.prototype,"bezierSlideTo",1,0);
MovieClip.prototype.roundedBezierSlideTo = TextField.prototype.roundedBezierSlideTo = function(cpoint_x, cpoint_y, propDest_x, propDest_y, timeSeconds, animType, delay, callback, extra1, extra2)
{
   var _loc3_ = new Object();
   _loc3_.__special_bst_ix__ = undefined;
   _loc3_.__special_bst_iy__ = undefined;
   _loc3_.__special_bst_cx__ = cpoint_x;
   _loc3_.__special_bst_cy__ = cpoint_y;
   _loc3_.__special_bst_dx__ = propDest_x;
   _loc3_.__special_bst_dy__ = propDest_y;
   _loc3_.mustRound = true;
   _global.$addTween(this,"__special_bst_t__",1,timeSeconds,animType,delay,callback,extra1,extra2,_loc3_);
};
ASSetPropFlags(MovieClip.prototype,"roundedBezierSlideTo",1,0);
ASSetPropFlags(TextField.prototype,"roundedBezierSlideTo",1,0);
Sound.prototype.volumeTo = function(propDest_volume, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"__special_sound_volume__",propDest_volume,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Sound.prototype,"volumeTo",1,0);
Sound.prototype.panTo = function(propDest_volume, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"__special_sound_pan__",propDest_volume,timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Sound.prototype,"panTo",1,0);
MovieClip.prototype.colorTo = function(propDest_color, timeSeconds, animType, delay, callback, extra1, extra2)
{
   var _loc3_;
   var _loc5_;
   var _loc4_;
   if(propDest_color == null)
   {
      this.colorTransformTo(100,0,100,0,100,0,undefined,undefined,timeSeconds,animType,delay,callback,extra1,extra2);
   }
   else
   {
      _loc3_ = propDest_color >> 16;
      _loc5_ = (propDest_color & 0xFF00) >> 8;
      _loc4_ = propDest_color & 0xFF;
      this.colorTransformTo(0,_loc3_,0,_loc5_,0,_loc4_,undefined,undefined,timeSeconds,animType,delay,callback,extra1,extra2);
   }
};
ASSetPropFlags(MovieClip.prototype,"colorTo",1,0);
TextField.prototype.colorTo = function(propDest_color, timeSeconds, animType, delay, callback, extra1, extra2)
{
   var _loc3_ = propDest_color >> 16;
   var _loc6_ = (propDest_color & 0xFF00) >> 8;
   var _loc4_ = propDest_color & 0xFF;
   _global.$addTween(this,["__special_text_r__","__special_text_g__","__special_text_b__"],[_loc3_,_loc6_,_loc4_],timeSeconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(TextField.prototype,"colorTo",1,0);
MovieClip.prototype.colorTransformTo = function()
{
   if(typeof arguments[0] == "object" && arguments[0] != undefined)
   {
      _global.$addTween(this,["__special_mc_ra__","__special_mc_rb__","__special_mc_ga__","__special_mc_gb__","__special_mc_ba__","__special_mc_bb__","__special_mc_aa__","__special_mc_ab__"],[arguments[0].ra,arguments[0].rb,arguments[0].ga,arguments[0].gb,arguments[0].ba,arguments[0].bb,arguments[0].aa,arguments[0].ab],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6]);
   }
   else
   {
      _global.$addTween(this,["__special_mc_ra__","__special_mc_rb__","__special_mc_ga__","__special_mc_gb__","__special_mc_ba__","__special_mc_bb__","__special_mc_aa__","__special_mc_ab__"],[arguments[0],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6],arguments[7]],arguments[8],arguments[9],arguments[10],arguments[11],arguments[12],arguments[13]);
   }
};
ASSetPropFlags(MovieClip.prototype,"colorTransformTo",1,0);
MovieClip.prototype.blurTo = TextField.prototype.blurTo = function()
{
   if(typeof arguments[0] == "object" && arguments[0] != undefined)
   {
      _global.$addTween(this,["__special_blur_x__","__special_blur_y__"],[arguments[0].blurX,arguments[0].blurY],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6],{__special_blur_quality__:arguments[0].quality});
   }
   else
   {
      _global.$addTween(this,["__special_blur_x__","__special_blur_y__"],[arguments[0],arguments[0]],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6],arguments[7],{__special_blur_quality__:arguments[1]});
   }
};
ASSetPropFlags(MovieClip.prototype,"blurTo",1,0);
ASSetPropFlags(TextField.prototype,"blurTo",1,0);
MovieClip.prototype.xyBlurTo = TextField.prototype.xyBlurTo = function(propDest_blurX, propDest_blurY, quality, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["__special_blur_x__","__special_blur_y__"],[propDest_blurX,propDest_blurY],timeSeconds,animType,delay,callback,extra1,extra2,{__special_blur_quality__:quality});
};
ASSetPropFlags(MovieClip.prototype,"xyBlurTo",1,0);
ASSetPropFlags(TextField.prototype,"xyBlurTo",1,0);
MovieClip.prototype.xBlurTo = TextField.prototype.xBlurTo = function(propDest_blur, quality, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"__special_blur_x__",propDest_blur,timeSeconds,animType,delay,callback,extra1,extra2,{__special_blur_quality__:quality});
};
ASSetPropFlags(MovieClip.prototype,"xBlurTo",1,0);
ASSetPropFlags(TextField.prototype,"xBlurTo",1,0);
MovieClip.prototype.yBlurTo = TextField.prototype.yBlurTo = function(propDest_blur, quality, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,"__special_blur_y__",propDest_blur,timeSeconds,animType,delay,callback,extra1,extra2,{__special_blur_quality__:quality});
};
ASSetPropFlags(MovieClip.prototype,"yBlurTo",1,0);
ASSetPropFlags(TextField.prototype,"yBlurTo",1,0);
MovieClip.prototype.glowTo = TextField.prototype.glowTo = function()
{
   if(typeof arguments[0] == "object" && arguments[0] != undefined)
   {
      _global.$addTween(this,["__special_glow_color__","__special_glow_alpha__","__special_glow_blurX__","__special_glow_blurY__","__special_glow_strength__"],[arguments[0].color,arguments[0].alpha,arguments[0].blurX,arguments[0].blurY,arguments[0].strength],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6],{__special_glow_quality__:arguments[0].quality,__special_glow_inner__:arguments[0].inner,__special_glow_knockout__:arguments[0].knockout});
   }
   else
   {
      _global.$addTween(this,["__special_glow_color__","__special_glow_alpha__","__special_glow_blurX__","__special_glow_blurY__","__special_glow_strength__"],[arguments[0],arguments[1],arguments[2],arguments[2],arguments[3]],arguments[7],arguments[8],arguments[9],arguments[10],arguments[11],arguments[12],{__special_glow_quality__:arguments[4],__special_glow_inner__:arguments[5],__special_glow_knockout__:arguments[6]});
   }
};
ASSetPropFlags(MovieClip.prototype,"glowTo",1,0);
ASSetPropFlags(TextField.prototype,"glowTo",1,0);
MovieClip.prototype.xyGlowTo = TextField.prototype.xyGlowTo = function(propDest_color, propDest_alpha, propDest_blurX, propDest_blurY, propDest_strength, quality, inner, knockout, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["__special_glow_color__","__special_glow_alpha__","__special_glow_blurX__","__special_glow_blurY__","__special_glow_strength__"],[propDest_color,propDest_alpha,propDest_blurX,propDest_blurY,propDest_strength],timeSeconds,animType,delay,callback,extra1,extra2,{__special_glow_quality__:quality,__special_glow_inner__:inner,__special_glow_knockout__:knockout});
};
ASSetPropFlags(MovieClip.prototype,"xyGlowTo",1,0);
ASSetPropFlags(TextField.prototype,"xyGlowTo",1,0);
MovieClip.prototype.xGlowTo = TextField.prototype.xGlowTo = function(propDest_color, propDest_alpha, propDest_blur, propDest_strength, quality, inner, knockout, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["__special_glow_color__","__special_glow_alpha__","__special_glow_blurX__","__special_glow_strength__"],[propDest_color,propDest_alpha,propDest_blur,propDest_strength],timeSeconds,animType,delay,callback,extra1,extra2,{__special_glow_quality__:quality,__special_glow_inner__:inner,__special_glow_knockout__:knockout});
};
ASSetPropFlags(MovieClip.prototype,"xGlowTo",1,0);
ASSetPropFlags(TextField.prototype,"xGlowTo",1,0);
MovieClip.prototype.yGlowTo = TextField.prototype.yGlowTo = function(propDest_color, propDest_alpha, propDest_blur, propDest_strength, quality, inner, knockout, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["__special_glow_color__","__special_glow_alpha__","__special_glow_blurY__","__special_glow_strength__"],[propDest_color,propDest_alpha,propDest_blur,propDest_strength],timeSeconds,animType,delay,callback,extra1,extra2,{__special_glow_quality__:quality,__special_glow_inner__:inner,__special_glow_knockout__:knockout});
};
ASSetPropFlags(MovieClip.prototype,"yGlowTo",1,0);
ASSetPropFlags(TextField.prototype,"yGlowTo",1,0);
MovieClip.prototype.bevelTo = TextField.prototype.bevelTo = function()
{
   if(typeof arguments[0] == "object" && arguments[0] != undefined)
   {
      _global.$addTween(this,["__special_bevel_distance__","__special_bevel_angle__","__special_bevel_highlightColor__","__special_bevel_highlightAlpha__","__special_bevel_shadowColor__","__special_bevel_shadowAlpha__","__special_bevel_blurX__","__special_bevel_blurY__","__special_bevel_strength__"],[arguments[0].distance,arguments[0].angle,arguments[0].highlightColor,arguments[0].highlightAlpha * 100,arguments[0].shadowColor,arguments[0].shadowAlpha * 100,arguments[0].blurX,arguments[0].blurY,arguments[0].strength],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6],{__special_bevel_quality__:arguments[0].quality,__special_bevel_type__:arguments[0].type,__special_bevel_knockout__:arguments[0].knockout});
   }
   else
   {
      _global.$addTween(this,["__special_bevel_distance__","__special_bevel_angle__","__special_bevel_highlightColor__","__special_bevel_highlightAlpha__","__special_bevel_shadowColor__","__special_bevel_shadowAlpha__","__special_bevel_blurX__","__special_bevel_blurY__","__special_bevel_strength__"],[arguments[0],arguments[1],arguments[2],arguments[3],arguments[4],arguments[5],arguments[6],arguments[6],arguments[7]],arguments[11],arguments[12],arguments[13],arguments[14],arguments[15],arguments[16],{__special_bevel_quality__:arguments[8],__special_bevel_type__:arguments[9],__special_bevel_knockout__:arguments[10]});
   }
};
ASSetPropFlags(MovieClip.prototype,"bevelTo",1,0);
ASSetPropFlags(TextField.prototype,"bevelTo",1,0);
MovieClip.prototype.xyBevelTo = TextField.prototype.xyBevelTo = function(propDest_distance, propDest_angle, propDest_highlightColor, propDest_highlightAlpha, propDest_shadowColor, propDest_shadowAlpha, propDest_blurX, propDest_blurY, propDest_strength, quality, type, knockout, timeSeconds, animType, delay, callback, extra1, extra2)
{
   _global.$addTween(this,["__special_bevel_distance__","__special_bevel_angle__","__special_bevel_highlightColor__","__special_bevel_highlightAlpha__","__special_bevel_shadowColor__","__special_bevel_shadowAlpha__","__special_bevel_blurX__","__special_bevel_blurY__","__special_bevel_blurY__","__special_bevel_strength__"],[propDest_distance,propDest_angle,propDest_highlightColor,propDest_highlightAlpha,propDest_shadowColor,propDest_shadowAlpha,propDest_blur,propDest_blur,propDest_strength],timeSeconds,animType,delay,callback,extra1,extra2,{__special_bevel_quality__:quality,__special_bevel_type__:type,__special_bevel_knockout__:knockout});
};
ASSetPropFlags(MovieClip.prototype,"xyBevelTo",1,0);
ASSetPropFlags(TextField.prototype,"xyBevelTo",1,0);
_global.findPointOnCurve = function(p1x, p1y, cx, cy, p2x, p2y, t)
{
   return {x:p1x + t * (2 * (1 - t) * (cx - p1x) + t * (p2x - p1x)),y:p1y + t * (2 * (1 - t) * (cy - p1y) + t * (p2y - p1y))};
};
ASSetPropFlags(_global,"findPointOnCurve",1,0);
_global.findTweenColor = function(objProp, tTime)
{
   var _loc8_ = objProp._propStart >> 16;
   var _loc4_ = objProp._propDest >> 16;
   var _loc5_ = objProp._propStart >> 8 & 0xFF;
   var _loc6_ = objProp._propDest >> 8 & 0xFF;
   var _loc9_ = objProp._propStart & 0xFF;
   var _loc7_ = objProp._propDest & 0xFF;
   var _loc12_ = Math.round(_global.findTweenValue(_loc8_,_loc4_,objProp._timeStart,tTime - objProp._delay * 1000,objProp._timeDest,objProp._animType,objProp._extra1,objProp._extra2));
   var _loc10_ = Math.round(_global.findTweenValue(_loc5_,_loc6_,objProp._timeStart,tTime - objProp._delay * 1000,objProp._timeDest,objProp._animType,objProp._extra1,objProp._extra2));
   var _loc3_ = Math.round(_global.findTweenValue(_loc9_,_loc7_,objProp._timeStart,tTime - objProp._delay * 1000,objProp._timeDest,objProp._animType,objProp._extra1,objProp._extra2));
   return (_loc12_ << 16) + (_loc10_ << 8) + _loc3_;
};
_global.findTweenValue = function(_propStart, _propDest, _timeStart, _timeNow, _timeDest, _animType, _extra1, _extra2)
{
   var _loc1_ = _timeNow - _timeStart;
   var _loc4_ = _propStart;
   var _loc2_ = _propDest - _propStart;
   var _loc3_ = _timeDest - _timeStart;
   var _loc6_ = _extra1;
   var _loc7_ = _extra2;
   var _loc5_ = _extra1;
   switch(_animType.toLowerCase())
   {
      case "linear":
         return _loc2_ * _loc1_ / _loc3_ + _loc4_;
      case "easeinquad":
         return _loc2_ * (_loc1_ /= _loc3_) * _loc1_ + _loc4_;
      case "easeoutquad":
         return (- _loc2_) * (_loc1_ /= _loc3_) * (_loc1_ - 2) + _loc4_;
      case "easeinoutquad":
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * _loc1_ * _loc1_ + _loc4_;
         }
         return (- _loc2_) / 2 * ((_loc1_ = _loc1_ - 1) * (_loc1_ - 2) - 1) + _loc4_;
         break;
      case "easeoutinquad":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutQuad") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInQuad") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeincubic":
         return _loc2_ * (_loc1_ /= _loc3_) * _loc1_ * _loc1_ + _loc4_;
      case "easeoutcubic":
         return _loc2_ * ((_loc1_ = _loc1_ / _loc3_ - 1) * _loc1_ * _loc1_ + 1) + _loc4_;
      case "easeinoutcubic":
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * _loc1_ * _loc1_ * _loc1_ + _loc4_;
         }
         return _loc2_ / 2 * ((_loc1_ -= 2) * _loc1_ * _loc1_ + 2) + _loc4_;
         break;
      case "easeoutincubic":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutCubic") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInCubic") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinquart":
         return _loc2_ * (_loc1_ /= _loc3_) * _loc1_ * _loc1_ * _loc1_ + _loc4_;
      case "easeoutquart":
         return (- _loc2_) * ((_loc1_ = _loc1_ / _loc3_ - 1) * _loc1_ * _loc1_ * _loc1_ - 1) + _loc4_;
      case "easeinoutquart":
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * _loc1_ * _loc1_ * _loc1_ * _loc1_ + _loc4_;
         }
         return (- _loc2_) / 2 * ((_loc1_ -= 2) * _loc1_ * _loc1_ * _loc1_ - 2) + _loc4_;
         break;
      case "easeoutinquart":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutQuart") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInQuart") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinquint":
         return _loc2_ * (_loc1_ /= _loc3_) * _loc1_ * _loc1_ * _loc1_ * _loc1_ + _loc4_;
      case "easeoutquint":
         return _loc2_ * ((_loc1_ = _loc1_ / _loc3_ - 1) * _loc1_ * _loc1_ * _loc1_ * _loc1_ + 1) + _loc4_;
      case "easeinoutquint":
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * _loc1_ * _loc1_ * _loc1_ * _loc1_ * _loc1_ + _loc4_;
         }
         return _loc2_ / 2 * ((_loc1_ -= 2) * _loc1_ * _loc1_ * _loc1_ * _loc1_ + 2) + _loc4_;
         break;
      case "easeoutinquint":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutQuint") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInQuint") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinsine":
         return (- _loc2_) * Math.cos(_loc1_ / _loc3_ * 1.5707963267948966) + _loc2_ + _loc4_;
      case "easeoutsine":
         return _loc2_ * Math.sin(_loc1_ / _loc3_ * 1.5707963267948966) + _loc4_;
      case "easeinoutsine":
         return (- _loc2_) / 2 * (Math.cos(3.141592653589793 * _loc1_ / _loc3_) - 1) + _loc4_;
      case "easeoutinsine":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutSine") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInSine") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinexpo":
         return _loc1_ != 0 ? _loc2_ * Math.pow(2,10 * (_loc1_ / _loc3_ - 1)) + _loc4_ : _loc4_;
      case "easeoutexpo":
         return _loc1_ != _loc3_ ? _loc2_ * (- Math.pow(2,-10 * _loc1_ / _loc3_) + 1) + _loc4_ : _loc4_ + _loc2_;
      case "easeinoutexpo":
         if(_loc1_ == 0)
         {
            return _loc4_;
         }
         if(_loc1_ == _loc3_)
         {
            return _loc4_ + _loc2_;
         }
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * Math.pow(2,10 * (_loc1_ - 1)) + _loc4_;
         }
         return _loc2_ / 2 * (- Math.pow(2,-10 * (_loc1_ = _loc1_ - 1)) + 2) + _loc4_;
         break;
      case "easeoutinexpo":
         if(_loc1_ == 0)
         {
            return _loc4_;
         }
         if(_loc1_ == _loc3_)
         {
            return _loc4_ + _loc2_;
         }
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * (- Math.pow(2,-10 * _loc1_ / 1) + 1) + _loc4_;
         }
         return _loc2_ / 2 * (Math.pow(2,10 * (_loc1_ - 2) / 1) + 1) + _loc4_;
         break;
      case "easeincirc":
         return (- _loc2_) * (Math.sqrt(1 - (_loc1_ /= _loc3_) * _loc1_) - 1) + _loc4_;
      case "easeoutcirc":
         return _loc2_ * Math.sqrt(1 - (_loc1_ = _loc1_ / _loc3_ - 1) * _loc1_) + _loc4_;
      case "easeinoutcirc":
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return (- _loc2_) / 2 * (Math.sqrt(1 - _loc1_ * _loc1_) - 1) + _loc4_;
         }
         return _loc2_ / 2 * (Math.sqrt(1 - (_loc1_ -= 2) * _loc1_) + 1) + _loc4_;
         break;
      case "easeoutincirc":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutCirc") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInCirc") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinelastic":
         if(_loc1_ == 0)
         {
            return _loc4_;
         }
         if((_loc1_ /= _loc3_) == 1)
         {
            return _loc4_ + _loc2_;
         }
         if(!_loc7_)
         {
            _loc7_ = _loc3_ * 0.3;
         }
         if(!_loc6_ || _loc6_ < Math.abs(_loc2_))
         {
            _loc6_ = _loc2_;
            _loc5_ = _loc7_ / 4;
         }
         else
         {
            _loc5_ = _loc7_ / 6.283185307179586 * Math.asin(_loc2_ / _loc6_);
         }
         return - _loc6_ * Math.pow(2,10 * (_loc1_ -= 1)) * Math.sin((_loc1_ * _loc3_ - _loc5_) * 6.283185307179586 / _loc7_) + _loc4_;
         break;
      case "easeoutelastic":
         if(_loc1_ == 0)
         {
            return _loc4_;
         }
         if((_loc1_ /= _loc3_) == 1)
         {
            return _loc4_ + _loc2_;
         }
         if(!_loc7_)
         {
            _loc7_ = _loc3_ * 0.3;
         }
         if(!_loc6_ || _loc6_ < Math.abs(_loc2_))
         {
            _loc6_ = _loc2_;
            _loc5_ = _loc7_ / 4;
         }
         else
         {
            _loc5_ = _loc7_ / 6.283185307179586 * Math.asin(_loc2_ / _loc6_);
         }
         return _loc6_ * Math.pow(2,-10 * _loc1_) * Math.sin((_loc1_ * _loc3_ - _loc5_) * 6.283185307179586 / _loc7_) + _loc2_ + _loc4_;
         break;
      case "easeinoutelastic":
         if(_loc1_ == 0)
         {
            return _loc4_;
         }
         if((_loc1_ /= _loc3_ / 2) == 2)
         {
            return _loc4_ + _loc2_;
         }
         if(!_loc7_)
         {
            _loc7_ = _loc3_ * 0.44999999999999996;
         }
         if(!_loc6_ || _loc6_ < Math.abs(_loc2_))
         {
            _loc6_ = _loc2_;
            _loc5_ = _loc7_ / 4;
         }
         else
         {
            _loc5_ = _loc7_ / 6.283185307179586 * Math.asin(_loc2_ / _loc6_);
         }
         if(_loc1_ < 1)
         {
            return -0.5 * (_loc6_ * Math.pow(2,10 * (_loc1_ -= 1)) * Math.sin((_loc1_ * _loc3_ - _loc5_) * 6.283185307179586 / _loc7_)) + _loc4_;
         }
         return _loc6_ * Math.pow(2,-10 * (_loc1_ -= 1)) * Math.sin((_loc1_ * _loc3_ - _loc5_) * 6.283185307179586 / _loc7_) * 0.5 + _loc2_ + _loc4_;
         break;
      case "easeoutinelastic":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutElastic") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInElastic") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinback":
         if(_loc5_ == undefined)
         {
            _loc5_ = 1.70158;
         }
         return _loc2_ * (_loc1_ /= _loc3_) * _loc1_ * ((_loc5_ + 1) * _loc1_ - _loc5_) + _loc4_;
      case "easeoutback":
         if(_loc5_ == undefined)
         {
            _loc5_ = 1.70158;
         }
         return _loc2_ * ((_loc1_ = _loc1_ / _loc3_ - 1) * _loc1_ * ((_loc5_ + 1) * _loc1_ + _loc5_) + 1) + _loc4_;
      case "easeinoutback":
         if(_loc5_ == undefined)
         {
            _loc5_ = 1.70158;
         }
         if((_loc1_ /= _loc3_ / 2) < 1)
         {
            return _loc2_ / 2 * (_loc1_ * _loc1_ * (((_loc5_ *= 1.525) + 1) * _loc1_ - _loc5_)) + _loc4_;
         }
         return _loc2_ / 2 * ((_loc1_ -= 2) * _loc1_ * (((_loc5_ *= 1.525) + 1) * _loc1_ + _loc5_) + 2) + _loc4_;
         break;
      case "easeoutinback":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutBack") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInBack") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeinbounce":
         return _loc2_ - findTweenValue(0,_loc2_,0,_loc3_ - _loc1_,_loc3_,"easeOutBounce") + _loc4_;
      case "easeoutbounce":
         if((_loc1_ /= _loc3_) < 0.36363636363636365)
         {
            return _loc2_ * (7.5625 * _loc1_ * _loc1_) + _loc4_;
         }
         if(_loc1_ < 0.7272727272727273)
         {
            return _loc2_ * (7.5625 * (_loc1_ -= 0.5454545454545454) * _loc1_ + 0.75) + _loc4_;
         }
         if(_loc1_ < 0.9090909090909091)
         {
            return _loc2_ * (7.5625 * (_loc1_ -= 0.8181818181818182) * _loc1_ + 0.9375) + _loc4_;
         }
         return _loc2_ * (7.5625 * (_loc1_ -= 0.9545454545454546) * _loc1_ + 0.984375) + _loc4_;
         break;
      case "easeinoutbounce":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeInBounce") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeOutBounce") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      case "easeoutinbounce":
         if(_loc1_ < _loc3_ / 2)
         {
            return findTweenValue(0,_loc2_,0,_loc1_ * 2,_loc3_,"easeOutBounce") * 0.5 + _loc4_;
         }
         return findTweenValue(0,_loc2_,0,_loc1_ * 2 - _loc3_,_loc3_,"easeInBounce") * 0.5 + _loc2_ * 0.5 + _loc4_;
         break;
      default:
         return 0;
   }
};
ASSetPropFlags(_global,"findTweenValue",1,0);
var currentZombieThreat = 0;
var threatDeficit = 0;
var liveZombieCount = 0;
var zombieLimit = 10;
var delayMax = 40;
var delay = delayMax;
var rareZombie = false;
var findZombieRetry = false;
var commonZombieChance = 0;
var semiRareZombieChance = 0;
var rareZombieChance = 0;
var veryRareZombieChance = 0;
var isArmed = false;
var zombieDepthCount = 0;
var particleCount = 480000;
var friendlyDepthSortCount = 0;
var friendlyDepthSortCountMax = 0;
loadJournal();

function fillWeaponMagazines()
{
   ammoInMag = _root[primaryWeapon.name].magazineCapacity;
   primaryAmmo = _root[primaryWeapon.name].magazineCapacity;
   secondaryAmmo = _root[secondaryWeapon.name].magazineCapacity;
   currentWeaponInHand = "primary";
}
function switchWeapons()
{
   if(currentWeaponInHand == "primary" && secondaryWeapon != undefined && !reloading)
   {
      switchingWeapons = true;
      primaryAmmo = ammoInMag;
      swapWeapon(secondaryWeapon.name);
      currentWeaponInHand = "secondary";
      ammoInMag = secondaryAmmo;
   }
   else if(!reloading && secondaryWeapon != undefined)
   {
      switchingWeapons = true;
      secondaryAmmo = ammoInMag;
      swapWeapon(primaryWeapon.name);
      currentWeaponInHand = "primary";
      ammoInMag = primaryAmmo;
   }
}
function checkWeaponSlots()
{
   timeManager.tm_backgrounds.slot3_outline._alpha = 100;
   timeManager.tm_backgrounds.slot4_outline._alpha = 100;
   timeManager.tm_backgrounds.slot5_outline._alpha = 100;
   timeManager.tm_backgrounds.slot6_outline._alpha = 100;
   if(secondaryWeaponSlot == "full")
   {
      timeManager.tm_backgrounds.secondary.isAvailable = false;
   }
   if(survivorSlot[0].free == true)
   {
      slot3WeaponSlot = "empty";
      slot3Weapon.inUse = false;
      slot3Weapon = snubnose;
      _root.timeManager.tm_backgrounds.slot3.onRelease = null;
      _root.timeManager.tm_backgrounds.slot3_outline._alpha = 0;
   }
   if(survivorSlot[1].free == true)
   {
      slot4WeaponSlot = "empty";
      slot4Weapon.inUse = false;
      slot4Weapon = snubnose;
      _root.timeManager.tm_backgrounds.slot4.onRelease = null;
      _root.timeManager.tm_backgrounds.slot4_outline._alpha = 0;
   }
   if(survivorSlot[2].free == true)
   {
      slot5WeaponSlot = "empty";
      _root[slot5Weapon.name].inUse = false;
      slot5Weapon = snubnose;
      _root.timeManager.tm_backgrounds.slot5.onRelease = null;
      _root.timeManager.tm_backgrounds.slot5_outline._alpha = 0;
   }
   if(survivorSlot[3].free == true)
   {
      slot6WeaponSlot = "empty";
      _root[slot6Weapon.name].inUse = false;
      slot6Weapon = snubnose;
      _root.timeManager.tm_backgrounds.slot6.onRelease = null;
      _root.timeManager.tm_backgrounds.slot6_outline._alpha = 0;
   }
}
function pickupWeapon(wpnName)
{
   if(_root[wpnName].found == true && _root[wpnName].inUse == false)
   {
      handlingSound = new Sound(stageBG);
      handlingSound.attachSound("sound_gunUp");
      handlingSound.setVolume(100);
      handlingSound.start(0,1);
      timeManager.tm_backgrounds["shadow_" + _root[wpnName].name][_root[wpnName].name + "_Weapon"].alphaTo(0,0);
      weaponInHand = true;
      weaponToAssign = wpnName;
      _root.attachMovie(wpnName + "_Icon","floatingGunIcon",900034);
      _root.attachMovie(wpnName + "_Icon","floatingGunShadow",900033);
      floatingGunIcon._x = -3000;
      floatingGunIcon._y = -3000;
      floatingGunShadow._x = -3000;
      floatingGunShadow._y = -3000;
      floatingGunIcon.onEnterFrame = function()
      {
         this._x = _xmouse;
         this._y = _ymouse;
      };
      floatingGunShadow.onEnterFrame = function()
      {
         this._x = _xmouse + 5;
         this._y = _ymouse + 5;
      };
      floatingGunShadow.alphaTo(20);
      floatingGunShadow.colorTo(0,0);
      floatingGunShadow.blurTo(5,0);
   }
}
function dropWeapon()
{
   timeManager.tm_backgrounds["shadow_" + _root[weaponToAssign].name][_root[weaponToAssign].name + "_Weapon"].alphaTo(100,0);
   weaponInHand = false;
   weaponToAssign = null;
   removeMovieClip(floatingGunIcon);
   removeMovieClip(floatingGunShadow);
   handlingSound = new Sound(stageBG);
   handlingSound.attachSound("sound_gunDown");
   handlingSound.setVolume(100);
   handlingSound.start(0,1);
}
function weaponRackButtons(btnName)
{
   _root.timeManager.tm_backgrounds[btnName].onRelease = function()
   {
      if(weaponInHand && btnName != weaponToAssign)
      {
         _root.dropWeapon();
         _root.pickupWeapon(btnName);
      }
      else
      {
         _root.pickupWeapon(btnName);
      }
   };
}
function weaponSlotButtons(btnName)
{
   _root.timeManager.tm_backgrounds.primary.isAvailable = false;
   _root.timeManager.tm_backgrounds[btnName].onRelease = function()
   {
      if(weaponInHand && _root[btnName + "Weapon"].name != weaponToAssign)
      {
         assignWeapon(btnName,weaponToAssign);
      }
      else
      {
         unassignWeapon(btnName);
         if(weaponInHand && _root[btnName + "Weapon"].name != weaponToAssign)
         {
            assignWeapon(btnName,weaponToAssign);
         }
      }
   };
   _root.timeManager.tm_backgrounds[btnName].onRollOver = function()
   {
      if(_root[btnName + "WeaponSlot"] == "full")
      {
         _root.timeManager.tm_backgrounds["remove_" + btnName].alphaTo(100,0.2);
      }
   };
   _root.timeManager.tm_backgrounds[btnName].onRollOut = function()
   {
      _root.timeManager.tm_backgrounds["remove_" + btnName].alphaTo(0,0.2);
   };
}
function assignWeapon(btnName, wpnName)
{
   if((btnName == "slot3" || btnName == "slot4" || btnName == "slot5" || btnName == "slot6") && (wpnName == "chainsaw" || wpnName == "grenade" || wpnName == "RPG" || wpnName == "compoundBow"))
   {
      handlingSound = new Sound(stageBG);
      handlingSound.attachSound("sound_scratch");
      handlingSound.setVolume(100);
      handlingSound.start(0,1);
   }
   else if(_root[wpnName].found == true && _root[wpnName].inUse == false)
   {
      if(_root[btnName + "WeaponSlot"] == "empty")
      {
         _root.timeManager.tm_backgrounds[btnName].isAvailable = false;
         handlingSound = new Sound(stageBG);
         handlingSound.attachSound("sound_gunDown");
         handlingSound.setVolume(100);
         handlingSound.start(0,1);
         weaponToAssign = null;
         weaponInHand = false;
         removeMovieClip(floatingGunIcon);
         removeMovieClip(floatingGunShadow);
         _root.timeManager.tm_backgrounds.needAWeapon.alphaTo(0,0.2);
         _root[btnName + "WeaponSlot"] = "full";
         _root.timeManager.tm_backgrounds[btnName].attachMovie(_root[wpnName].name + "_Icon",btnName + "Weapon",this.getNextHighestDepth);
         _root[wpnName].inUse = true;
         _root[btnName + "Weapon"] = _root[wpnName];
         swapWeapon(_root[btnName + "Weapon"].name);
         fillWeaponMagazines();
         switch(btnName)
         {
            case "slot3":
               survivorSlot[0].weapon = slot3Weapon.name;
               return;
            case "slot4":
               survivorSlot[1].weapon = slot4Weapon.name;
               return;
            case "slot5":
               survivorSlot[2].weapon = slot5Weapon.name;
               return;
            case "slot6":
               survivorSlot[3].weapon = slot6Weapon.name;
               return;
            default:
               return;
         }
      }
   }
}
function unassignWeapon(btnName)
{
   for(v in survivorSlot)
   {
      if(survivorSlot[v].weapon == _root[btnName + "Weapon"].name)
      {
         survivorSlot[v].weapon = "snubnose";
      }
   }
   _root.timeManager.tm_backgrounds["shadow_" + _root[btnName + "Weapon"].name][_root[btnName + "Weapon"].name + "_Weapon"].alphaTo(100,0);
   handlingSound = new Sound(stageBG);
   handlingSound.attachSound("sound_gunUnassign");
   handlingSound.setVolume(100);
   handlingSound.start(0,1);
   _root.timeManager.tm_backgrounds[btnName][btnName + "Weapon"].removeMovieClip();
   _root.timeManager.tm_backgrounds[btnName].isAvailable = true;
   _root[btnName + "Weapon"].inUse = false;
   _root[btnName + "WeaponSlot"] = "empty";
   _root[btnName + "Weapon"] = null;
}
currentWeapon = "pistol";
primaryWeapon = _root.pistol;
secondaryWeapon = null;
var primaryWeaponSlot = "full";
var secondaryWeaponSlot = "empty";
var slot3WeaponSlot = "empty";
var slot3Weapon = null;
var slot4WeaponSlot = "empty";
var slot4Weapon = null;
var slot5WeaponSlot = "empty";
var slot5Weapon = null;
var slot6WeaponSlot = "empty";
var slot6Weapon = null;
var weaponToAssign = "";
var weaponInHand = false;
currentWeaponInHand = "primary";
primaryAmmo = 0;
secondaryAmmo = 0;
slot3Ammo = 0;
slot4Ammo = 0;
slot5Ammo = 0;
slot6Ammo = 0;
primaryWeaponSlot.free = true;
secondaryWeaponSlot.free = true;
ammoInMag = _root[primaryWeapon.name].magazineCapacity;
primaryAmmo = _root[primaryWeapon.name].magazineCapacity;
secondaryAmmo = _root[secondaryWeapon.name].magazineCapacity;

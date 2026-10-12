_root.smokePuff++;
_root.attachMovie("RPG_Smoke","RPG_Smoke" + _root.smokePuff,_root.smokePuff + 534346);
_root["RPG_Smoke" + _root.smokePuff]._x = this._x;
_root["RPG_Smoke" + _root.smokePuff]._y = this._y + (random(10) - 5);
_root["RPG_Smoke" + _root.smokePuff]._rotation = _root.mainGunRef._rotation;
gotoAndStop("RPG");
play();

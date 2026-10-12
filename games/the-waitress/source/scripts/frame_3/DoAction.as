var MochiAd = {showPreloaderAd:function(options)
{
   var _loc1_ = this;
   var _loc2_ = options;
   var DEFAULTS = {clip:_root,ad_timeout:3000,fadeout_time:250,regpt:"o",method:"showPreloaderAd",color:16747008,background:16777161,outline:13994812};
   _loc2_ = MochiAd._parseOptions(_loc2_,DEFAULTS);
   var clip = _loc2_.clip;
   var ad_msec = 11000;
   var ad_timeout = _loc2_.ad_timeout;
   delete _loc2_.ad_timeout;
   var fadeout_time = _loc2_.fadeout_time;
   delete _loc2_.fadeout_time;
   var _loc3_;
   if(MochiAd.load(_loc2_))
   {
      clip.stop();
      var mc = clip._mochiad;
      mc.onUnload = function()
      {
         this._parent.play();
      };
      var wh = MochiAd._getRes(_loc2_);
      var w = wh[0];
      var h = wh[1];
      mc._x = w * 0.5;
      mc._y = h * 0.5;
      var chk = mc.createEmptyMovieClip("_mochiad_wait",3);
      chk._x = w * -0.5;
      chk._y = h * -0.5;
      var bar = chk.createEmptyMovieClip("_mochiad_bar",4);
      bar._x = 10;
      bar._y = h - 20;
      var bar_color = _loc2_.color;
      delete _loc2_.color;
      var bar_background = _loc2_.background;
      delete _loc2_.background;
      var bar_outline = _loc2_.outline;
      delete _loc2_.outline;
      var backing = bar.createEmptyMovieClip("_outline",1);
      backing.beginFill(bar_background);
      backing.moveTo(0,0);
      backing.lineTo(w - 20,0);
      backing.lineTo(w - 20,10);
      backing.lineTo(0,10);
      backing.lineTo(0,0);
      backing.endFill();
      _loc3_ = bar.createEmptyMovieClip("_inside",2);
      _loc3_.beginFill(bar_color);
      _loc3_.moveTo(0,0);
      _loc3_.lineTo(w - 20,0);
      _loc3_.lineTo(w - 20,10);
      _loc3_.lineTo(0,10);
      _loc3_.lineTo(0,0);
      _loc3_.endFill();
      _loc3_._xscale = 0;
      var outline = bar.createEmptyMovieClip("_outline",3);
      outline.lineStyle(0,bar_outline,100);
      outline.moveTo(0,0);
      outline.lineTo(w - 20,0);
      outline.lineTo(w - 20,10);
      outline.lineTo(0,10);
      outline.lineTo(0,0);
      chk.ad_msec = ad_msec;
      chk.ad_timeout = ad_timeout;
      chk.started = getTimer();
      chk.showing = false;
      chk.last_pcnt = 0;
      chk.fadeout_time = fadeout_time;
      chk.fadeFunction = function()
      {
         var _loc1_ = this;
         var _loc2_ = 100 * (1 - (getTimer() - _loc1_.fadeout_start) / _loc1_.fadeout_time);
         var _loc3_;
         if(_loc2_ > 0)
         {
            _loc1_._parent._alpha = _loc2_;
         }
         else
         {
            _loc3_ = _loc1_._parent._parent;
            MochiAd.unload(_loc3_);
            delete _loc1_.onEnterFrame;
         }
      };
      mc.lc.adjustProgress = function(msec)
      {
         var _loc1_ = this.mc._mochiad_wait;
         _loc1_.server_control = true;
         _loc1_.started = getTimer();
         _loc1_.ad_msec = msec;
      };
      chk.onEnterFrame = function()
      {
         var _loc1_ = this;
         var _clip = _loc1_._parent._parent;
         var ad_clip = _loc1_._parent._mochiad_ctr;
         var elapsed = getTimer() - _loc1_.started;
         var _loc3_ = false;
         var clip_total = _clip.getBytesTotal();
         var clip_loaded = _clip.getBytesLoaded();
         var clip_pcnt = 100 * clip_loaded / clip_total;
         var ad_pcnt = 100 * elapsed / chk.ad_msec;
         var _inside = _loc1_._mochiad_bar._inside;
         var _loc2_ = Math.min(100,Math.min(clip_pcnt || 0,ad_pcnt));
         _loc2_ = Math.max(_loc1_.last_pcnt,_loc2_);
         _loc1_.last_pcnt = _loc2_;
         _inside._xscale = _loc2_;
         if(!chk.showing)
         {
            var total = ad_clip.getBytesTotal();
            if(total > 0 || typeof total == "undefined")
            {
               chk.showing = true;
               chk.started = getTimer();
            }
            else if(elapsed > chk.ad_timeout)
            {
               _loc3_ = true;
            }
         }
         if(elapsed > chk.ad_msec)
         {
            _loc3_ = true;
         }
         if(clip_total > 0 && clip_loaded >= clip_total && _loc3_)
         {
            if(_loc1_.server_control)
            {
               delete _loc1_.onEnterFrame;
            }
            else
            {
               _loc1_.fadeout_start = getTimer();
               _loc1_.onEnterFrame = chk.fadeFunction;
            }
         }
      };
   }
},showTimedAd:function(options)
{
   var _loc1_ = this;
   var _loc2_ = options;
   var DEFAULTS = {clip:_root,ad_timeout:2000,fadeout_time:250,regpt:"o",method:"showTimedAd"};
   _loc2_ = MochiAd._parseOptions(_loc2_,DEFAULTS);
   var clip = _loc2_.clip;
   var ad_msec = 11000;
   var ad_timeout = _loc2_.ad_timeout;
   delete _loc2_.ad_timeout;
   var fadeout_time = _loc2_.fadeout_time;
   delete _loc2_.fadeout_time;
   var _loc3_;
   if(MochiAd.load(_loc2_))
   {
      clip.stop();
      _loc3_ = clip._mochiad;
      _loc3_.onUnload = function()
      {
         this._parent.play();
      };
      var wh = MochiAd._getRes(_loc2_);
      var w = wh[0];
      var h = wh[1];
      _loc3_._x = w * 0.5;
      _loc3_._y = h * 0.5;
      var chk = _loc3_.createEmptyMovieClip("_mochiad_wait",3);
      chk.ad_msec = ad_msec;
      chk.ad_timeout = ad_timeout;
      chk.started = getTimer();
      chk.showing = false;
      chk.fadeout_time = fadeout_time;
      chk.fadeFunction = function()
      {
         var _loc1_ = this;
         var _loc2_ = 100 * (1 - (getTimer() - _loc1_.fadeout_start) / _loc1_.fadeout_time);
         var _loc3_;
         if(_loc2_ > 0)
         {
            _loc1_._parent._alpha = _loc2_;
         }
         else
         {
            _loc3_ = _loc1_._parent._parent;
            MochiAd.unload(_loc3_);
            delete _loc1_.onEnterFrame;
         }
      };
      _loc3_.lc.adjustProgress = function(msec)
      {
         var _loc1_ = this.mc._mochiad_wait;
         _loc1_.server_control = true;
         _loc1_.started = getTimer();
         _loc1_.ad_msec = msec - 250;
      };
      chk.onEnterFrame = function()
      {
         var _loc1_ = this;
         var ad_clip = _loc1_._parent._mochiad_ctr;
         var elapsed = getTimer() - _loc1_.started;
         var _loc2_ = false;
         var _loc3_;
         if(!chk.showing)
         {
            _loc3_ = ad_clip.getBytesTotal();
            if(_loc3_ > 0 || typeof _loc3_ == "undefined")
            {
               chk.showing = true;
               chk.started = getTimer();
            }
            else if(elapsed > chk.ad_timeout)
            {
               _loc2_ = true;
            }
         }
         if(elapsed > chk.ad_msec)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            if(_loc1_.server_control)
            {
               delete _loc1_.onEnterFrame;
            }
            else
            {
               _loc1_.fadeout_start = getTimer();
               _loc1_.onEnterFrame = _loc1_.fadeFunction;
            }
         }
      };
   }
},_allowDomains:function(server)
{
   var _loc1_ = server.split("/")[2].split(":")[0];
   if(System.security)
   {
      if(System.security.allowDomain)
      {
         System.security.allowDomain("*");
         System.security.allowDomain(_loc1_);
      }
      if(System.security.allowInsecureDomain)
      {
         System.security.allowInsecureDomain("*");
         System.security.allowInsecureDomain(_loc1_);
      }
   }
   return _loc1_;
},_loadCommunicator:function(options)
{
   var _loc2_ = options;
   var _loc3_ = arguments;
   var DEFAULTS = {clip:_root,com_server:"http://x.mochiads.com/com/1/",method:"loadCommunicator",depth:10337,id:"_UNKNOWN_"};
   _loc2_ = MochiAd._parseOptions(_loc2_,DEFAULTS);
   _loc2_.swfv = _loc2_.clip.getSWFVersion() || 6;
   _loc2_.mav = "1.4";
   var clip = _loc2_.clip;
   var clipname = "_mochiad_com_" + _loc2_.id;
   if(!MochiAd._isNetworkAvailable())
   {
      return null;
   }
   if(clip[clipname])
   {
      return clip[clipname].lc;
   }
   var server = _loc2_.com_server + _loc2_.id;
   MochiAd._allowDomains(server);
   delete _loc2_.id;
   delete _loc2_.com_server;
   var depth = _loc2_.depth;
   delete _loc2_.depth;
   var mc = clip.createEmptyMovieClip(clipname,depth);
   var lv = mc.createEmptyMovieClip("_mochiad_com",1);
   for(var k in _loc2_)
   {
      lv[k] = _loc2_[k];
   }
   var lc = new LocalConnection();
   var name = ["",Math.floor(new Date().getTime()),random(999999)].join("_");
   lc.mc = mc;
   lc.name = name;
   lc.allowDomain = function(d)
   {
      return true;
   };
   lc.allowInsecureDomain = lc.allowDomain;
   lc.connect(name);
   mc.lc = lc;
   lv.lc = name;
   lc._id = 0;
   lc._queue = [];
   lc.rpcResult = function(cb)
   {
      cb = parseInt(cb);
      var _loc2_ = this._callbacks[cb];
      var _loc3_;
      var _loc1_;
      if(_loc2_)
      {
         delete this._callbacks[cb];
         _loc3_ = [];
         _loc1_ = 2;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_.push(_loc2_[_loc1_]);
            _loc1_ = _loc1_ + 1;
         }
         _loc1_ = 1;
         while(_loc1_ < arguments.length)
         {
            _loc3_.push(arguments[_loc1_]);
            _loc1_ = _loc1_ + 1;
         }
         var method = _loc2_[1];
         var obj = _loc2_[0];
         if(obj && typeof method == "string")
         {
            method = obj[method];
         }
         if(method)
         {
            method.apply(obj,_loc3_);
         }
      }
   };
   lc._didConnect = function(endpoint)
   {
      this._endpoint = endpoint;
      var _loc3_ = this._queue;
      delete this._queue;
      var ds = this.doSend;
      var _loc1_ = 0;
      var _loc2_;
      while(_loc1_ < _loc3_.length)
      {
         _loc2_ = _loc3_[_loc1_];
         ds.apply(this,_loc2_);
         _loc1_ = _loc1_ + 1;
      }
   };
   lc.doSend = function(args, cbobj, cbfn)
   {
      var _loc2_ = arguments;
      var _loc3_;
      var _loc1_;
      if(this._endpoint == null)
      {
         _loc3_ = [];
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_.push(_loc2_[_loc1_]);
            _loc1_ = _loc1_ + 1;
         }
         this._queue.push(_loc3_);
      }
      else
      {
         this._id += 1;
         var id = this._id;
         if(cbfn === undefined || cbfn === null)
         {
            cbfn = cbobj;
         }
         this._callbacks[id] = [cbobj,cbfn];
         var slc = new LocalConnection();
         var ss = slc.send(this._endpoint,"rpc",id,args);
      }
   };
   lc._callbacks = {};
   lc._callbacks[0] = [lc,"_didConnect"];
   lv.st = getTimer();
   lv.loadMovie(server + ".swf","POST");
   return lc;
},fetchHighScores:function(options, callbackObj, callbackMethod)
{
   var _loc2_ = options;
   var _loc1_ = MochiAd._loadCommunicator({id:_loc2_.id});
   if(!_loc1_)
   {
      return false;
   }
   var fncall = ["fetchHighScores",_loc2_];
   _loc1_.doSend(["fetchHighScores",_loc2_],callbackObj,callbackMethod);
   return true;
},sendHighScore:function(options, callbackObj, callbackMethod)
{
   var _loc2_ = options;
   var _loc1_ = MochiAd._loadCommunicator({id:_loc2_.id});
   if(!_loc1_)
   {
      return false;
   }
   var fncall = ["sendHighScore",_loc2_];
   _loc1_.doSend(["sendHighScore",_loc2_],callbackObj,callbackMethod);
   return true;
},load:function(options)
{
   var _loc1_ = options;
   var DEFAULTS = {clip:_root,server:"http://x.mochiads.com/srv/1/",method:"load",depth:10333,id:"_UNKNOWN_"};
   _loc1_ = MochiAd._parseOptions(_loc1_,DEFAULTS);
   _loc1_.swfv = _loc1_.clip.getSWFVersion() || 6;
   _loc1_.mav = "1.4";
   var clip = _loc1_.clip;
   if(!MochiAd._isNetworkAvailable())
   {
      return null;
   }
   if(clip._mochiad_loaded)
   {
      return null;
   }
   var depth = _loc1_.depth;
   delete _loc1_.depth;
   var mc = clip.createEmptyMovieClip("_mochiad",depth);
   var wh = MochiAd._getRes(_loc1_);
   _loc1_.res = wh[0] + "x" + wh[1];
   _loc1_.server += _loc1_.id;
   delete _loc1_.id;
   clip._mochiad_loaded = true;
   var _loc2_ = mc.createEmptyMovieClip("_mochiad_ctr",1);
   for(var k in _loc1_)
   {
      _loc2_[k] = _loc1_[k];
   }
   if(clip._url.indexOf("http") != 0)
   {
      _loc1_.no_page = true;
   }
   var server = _loc2_.server;
   delete _loc2_.server;
   var hostname = MochiAd._allowDomains(server);
   mc.onEnterFrame = function()
   {
      var _loc1_ = this;
      if(_loc1_._mochiad_ctr._url != _loc1_._url)
      {
         _loc1_.onEnterFrame = function()
         {
            var _loc1_ = this;
            if(!_loc1_._mochiad_ctr)
            {
               delete _loc1_.onEnterFrame;
               MochiAd.unload(_loc1_._parent);
            }
         };
      }
   };
   var _loc3_ = new LocalConnection();
   var name = ["",Math.floor(new Date().getTime()),random(999999)].join("_");
   _loc3_.mc = mc;
   _loc3_.name = name;
   _loc3_.hostname = hostname;
   _loc3_.allowDomain = function(d)
   {
      return true;
   };
   _loc3_.allowInsecureDomain = _loc3_.allowDomain;
   _loc3_.connect(name);
   mc.lc = _loc3_;
   _loc2_.lc = name;
   _loc2_.st = getTimer();
   _loc2_.loadMovie(server + ".swf","POST");
   return mc;
},unload:function(clip)
{
   var _loc1_ = clip;
   if(typeof _loc1_ == "undefined")
   {
      _loc1_ = _root;
   }
   if(_loc1_.clip && _loc1_.clip._mochiad)
   {
      _loc1_ = _loc1_.clip;
   }
   if(!_loc1_._mochiad)
   {
      return false;
   }
   _loc1_._mochiad.removeMovieClip();
   delete _loc1_._mochiad_loaded;
   delete _loc1_._mochiad;
   return true;
},_isNetworkAvailable:function()
{
   var _loc1_;
   if(System.security)
   {
      _loc1_ = System.security;
      if(_loc1_.sandboxType == "localWithFile")
      {
         return false;
      }
   }
   return true;
},_getRes:function(options)
{
   var _loc3_ = options.clip.getBounds();
   var _loc2_ = 0;
   var _loc1_ = 0;
   if(typeof options.res != "undefined")
   {
      var xy = options.res.split("x");
      _loc2_ = parseFloat(xy[0]);
      _loc1_ = parseFloat(xy[1]);
   }
   else
   {
      _loc2_ = _loc3_.xMax - _loc3_.xMin;
      _loc1_ = _loc3_.yMax - _loc3_.yMin;
   }
   if(_loc2_ == 0 || _loc1_ == 0)
   {
      _loc2_ = Stage.width;
      _loc1_ = Stage.height;
   }
   return [_loc2_,_loc1_];
},_parseOptions:function(options, defaults)
{
   var _loc3_ = {};
   for(var k in defaults)
   {
      _loc3_[k] = defaults[k];
   }
   if(options)
   {
      for(var k in options)
      {
         _loc3_[k] = options[k];
      }
   }
   var _loc1_;
   var _loc2_;
   if(_root.mochiad_options)
   {
      var pairs = _root.mochiad_options.split("&");
      _loc1_ = 0;
      while(_loc1_ < pairs.length)
      {
         _loc2_ = pairs[_loc1_].split("=");
         _loc3_[unescape(_loc2_[0])] = unescape(_loc2_[1]);
         _loc1_ = _loc1_ + 1;
      }
   }
   return _loc3_;
},_:null};
stop();

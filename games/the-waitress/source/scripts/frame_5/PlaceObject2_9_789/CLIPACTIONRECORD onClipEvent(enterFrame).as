onClipEvent(enterFrame){
   _root.preloadtext = Math.round(_root.getBytesLoaded() / _root.getBytesTotal() * 100) + "% Loaded";
}

// @GENERATOR:play-routes-compiler
// @SOURCE:/code/server/conf/routes
// @DATE:Wed Dec 19 22:25:01 GMT 2018

import play.api.mvc.Call


import _root_.controllers.Assets.Asset

// @LINE:6
package com.framed.playscalajs.controllers {

  // @LINE:6
  class ReverseApplication(_prefix: => String) {
    def _defaultPrefix: String = {
      if (_prefix.endsWith("/")) "" else "/"
    }

  
    // @LINE:6
    def index(): Call = {
      
      Call("GET", _prefix)
    }
  
  }


}

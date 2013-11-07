import openfl.Assets;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
#if online
import kong.*;
#end

class Main extends Engine {

#if online
  private static var kong:KongregateApi;
#end

  override public function init() {
#if online
    var parameters = flash.Lib.current.root.loaderInfo.parameters;
    var api_path = parameters.kongregate_api_path;
    if (api_path == null) {
      api_path = "http://www.kongregate.com/flash/API_AS3_Local.swf";
    }
    flash.system.Security.allowDomain(api_path);
    var request = new flash.net.URLRequest(api_path);
    var loader = new flash.display.Loader();
    loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,
        function(event:flash.events.Event) {
        kong = cast event.target.content;
        onLoad();
        });
    loader.load(request);
    flash.Lib.current.addChild(loader);
#else
    onLoad();
#end
  }

  private function onLoad() {
#if online 
    kong.services.connect();
#end
#if debug
    trace("onLoad()");
    HXP.console.enable();
    HXP.console.toggleKey = Key.E;
#end
    HXP.scene = new TheScene();
    HXP.screen.color = 0;
  }

#if online
  public static function submit(statName:String, value:Int) {
    kong.stats.submit(statName, value);
  }
#end

  override public function new() {
    super(900, 640, 60, false);
  }

  public static function main() { 
    trace("main");
    new Main(); 
  }

}

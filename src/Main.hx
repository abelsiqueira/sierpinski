import openfl.Assets;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Main extends Engine {

  override public function init() {
#if debug
    HXP.console.enable();
    HXP.console.toggleKey = Key.E;
#end
    HXP.scene = new TheScene();
    HXP.screen.color = 0;
  }

  override public function new() {
    super(900, 640, 60, false);
  }

  public static function main() { new Main(); }

}

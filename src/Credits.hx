import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Credits extends Scene {

  public function new() {
    super();

    addGraphic(new Image("gfx/credits.png"));
  }

  public override function update() {
    super.update();

    if (Input.pressed(Key.ANY)) {
      HXP.scene = new TheScene();
    }

  }

}

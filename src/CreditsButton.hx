import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class CreditsButton extends Entity {

  public function new() {
    super();

    var image:Image = new Image("gfx/help.png");
    x = 2;
    y = 2;

    setHitbox(image.width, image.height);

    addGraphic(image);
  }

  override public function update() {
    super.update();

    if (Input.mousePressed) {
      var mx:Int = Input.mouseX;
      var my:Int = Input.mouseY;
      if (collidePoint(x, y, mx, my)) {
        HXP.scene = new Credits();
#if online
        Main.submit("SawCredits",1);
#end
      }
    }
  }

}

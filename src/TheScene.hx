import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TheScene extends Scene {

  public function new() {
    super();
    add(new Sierpinski());
  }

  public override function update() {
    super.update();
  }
}

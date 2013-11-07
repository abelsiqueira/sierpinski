import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TheScene extends Scene {

  private var sierpinski:Sierpinski;

  public function new() {
    super();
    sierpinski = new Sierpinski();
    add(sierpinski);
    add(new CreditsButton());
    add(new Menu(sierpinski));

#if online
    Main.submit("GameStarted", 1);
#end
  }

  public override function update() {
    super.update();
  }
}

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Sierpinski extends Entity {

  private var canvas:Canvas;

  private var bx:Array<Float>;
  private var by:Array<Float>;

  private var pto_x:Float;
  private var pto_y:Float;

  private var psize:Int = 1;

  private var speed:Int = 1;

  public function new() {
    super();

    var i:Int;
    width = HXP.width;
    height = HXP.height;
    canvas = new Canvas(width, height);

    bx = new Array<Float>();
    by = new Array<Float>();

    for (i in 0...3) {
      bx.push(width/2 + Math.sin(i*2.0*3.14/3.0)*Math.min(width,height)*0.45);
      by.push(width/2 - Math.cos(i*2.0*3.14/3.0)*Math.min(width,height)*0.45);
    }

    for (i in 0...3)
      canvas.fill(new Rectangle(bx[i], by[i], psize, psize), 0xff0000);

    pto_x = width/2;
    pto_y = height/2;

    addGraphic(canvas);
  }

  override public function update() {
    var i:Int;

    for (i in 0...speed) {
      var r:Int = Std.random(3);
      canvas.fill(new Rectangle(pto_x, pto_y, psize, psize), 0xff0000);
      pto_x = (pto_x + bx[r])/2;
      pto_y = (pto_y + by[r])/2;
    }

    if (Input.pressed(Key.A)) {
      speed++;
    } else if (Input.pressed(Key.S)) {
      speed--;
      if (speed < 0)
        speed = 0;
    } else if (Input.pressed(Key.R)) {
      canvas.fill(new Rectangle(0,0,width,height), 0);
    }
  }

}

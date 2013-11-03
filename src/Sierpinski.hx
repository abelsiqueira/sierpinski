import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import com.haxepunk.graphics.Text;
import flash.geom.Rectangle;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Sierpinski extends Entity {

  private var canvas:Canvas;
  private var speed_text:Text;
  private var np_text:Text;

  private var bx:Array<Float>;
  private var by:Array<Float>;

  private var pto_x:Float;
  private var pto_y:Float;

  private var psize:Int = 1;

  private var speed:Float = 1;
  private var accul:Float = 0;
  private var np:Int = 0;

  public function new() {
    super();

    var i:Int;
    width = HXP.width;
    height = HXP.height;
    canvas = new Canvas(width, height);

    speed_text = new Text("speed = " + Std.string(Math.round(Math.log(speed)/0.69315)));
    speed_text.x = 10;
    speed_text.y = 40;
    speed_text.size = 18;

    np_text = new Text("N of points = " + Std.string(np));
    np_text.x = 10;
    np_text.y = 10;
    np_text.size = 18;

    bx = new Array<Float>();
    by = new Array<Float>();

    for (i in 0...3) {
      bx.push(width/2 + Math.sin(i*2.0*3.14/3.0)*Math.min(width,height)*0.45);
      by.push(width/2 - Math.cos(i*2.0*3.14/3.0)*Math.min(width,height)*0.45);
    }

    clear_drawing();

    addGraphic(canvas);
    addGraphic(speed_text);
    addGraphic(np_text);

    var desc:String = "Press A to increase speed and S to decrease. Press R ";
    desc += "to reset the image.\n";
    desc += "Abel Soares Siqueira\n";
    desc += "https://github.com/abelsiqueira/sierpinski";
    var text_opt:TextOptions = { wordWrap:true, color:0xffffff, size:18};
    var description:Text = new Text(desc, 10, height-100, width-40, 200, text_opt);
    addGraphic(description);
  }

  private function clear_drawing() {
    canvas.fill(new Rectangle(0,0,width,height), 0);
    for (i in 0...3)
      canvas.fill(new Rectangle(bx[i], by[i], psize, psize), 0xff0000);
    np = 3;
    pto_x = width/2;
    pto_y = height/2;
  }

  override public function update() {
    var i:Int;

    accul += speed;

    while (accul > 1) {
      var r:Int = Std.random(3);
      canvas.fill(new Rectangle(pto_x, pto_y, psize, psize), 0xff0000);
      pto_x = (pto_x + bx[r])/2;
      pto_y = (pto_y + by[r])/2;
      accul -= 1;
      np++;
    }

    np_text.text = "N of points = " + Std.string(np);

    if (Input.pressed(Key.A)) {
      speed *= 2;
      speed_text.text = "speed = " + Std.string(Math.round((Math.log(speed)/0.69315)));
    } else if (Input.pressed(Key.S)) {
      speed /= 2;
      speed_text.text = "speed = " + Std.string(Math.round((Math.log(speed)/0.69315)));
    } else if (Input.pressed(Key.R)) {
      clear_drawing();
    }
  }

}

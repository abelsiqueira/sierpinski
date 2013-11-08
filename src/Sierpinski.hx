import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import com.haxepunk.graphics.Text;
import flash.geom.Rectangle;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Sierpinski extends Entity {

  private var canvas:Canvas;

  private var bx:Array<Float>;
  private var by:Array<Float>;

  private var pto_x:Array<Float>;
  private var pto_y:Array<Float>;

  private var psize:Int = 1;

  private var max_no_vertex:Int = 20;
  private var no_vertex:Int = 3;

  private var min_speed:Int = -6;
  private var max_speed:Int = 8;
  private var speed:Int = 0;
  private var accul:Float = 0;
  private var np:Int = 0;
  private var radius:Int;

  private var wfc:Bool = false;

  public function new() {
    super();

    var i:Int;
    width = HXP.width;
    height = HXP.height;
    radius = Std.int(height/2)-4;
    canvas = new Canvas(width, height);

    clear_drawing();

    addGraphic(canvas);
  }

  public function clear_drawing() {
    canvas.fill(new Rectangle(0,0,width,height), 0);

    bx = new Array<Float>();
    by = new Array<Float>();

    for (i in 0...no_vertex) {
      bx.push(2+radius + Math.sin(i*2.0*3.14/no_vertex)*radius);
      by.push(2+radius - Math.cos(i*2.0*3.14/no_vertex)*radius);
      canvas.fill(new Rectangle(bx[i], by[i], psize, psize), 0xff0000);
    }

    np = no_vertex;

    if (!wfc) {
      pto_x = new Array<Float>();
      pto_y = new Array<Float>();
      for (i in 0...no_vertex-2) {
        pto_x.push(2+radius);
        pto_y.push(2+radius);
      }
    }

    canvas.fill(new Rectangle(0,0,width,2), 0xffffff);
    canvas.fill(new Rectangle(0,height-2,width,2), 0xffffff);
    canvas.fill(new Rectangle(0,0,2,height), 0xffffff);
    canvas.fill(new Rectangle(width-2,0,2,height), 0xffffff);
    canvas.fill(new Rectangle(4+2*radius,0,2,height), 0xffffff);
  }

  override public function update() {
    var i:Int;

    if (wfc) {
      if (Input.mousePressed) {
        var mx:Int = Input.mouseX;
        var my:Int = Input.mouseY;

        if (mx > HXP.height)
          return;

        pto_x = new Array<Float>();
        pto_y = new Array<Float>();
        pto_x.push(mx);
        pto_y.push(my);
        wfc = false;
        accul = 1;
      }
    } else {
      if (speed > min_speed) {
        accul += Math.exp(speed);

        while (accul > 1) {
          for (i in 0...no_vertex-2) {
            canvas.fill(new Rectangle(pto_x[i], pto_y[i], psize, psize), 0xff0000);
            var r:Int = Std.random(3);
            if (r == 0) {
              pto_x[i] += bx[0];
              pto_y[i] += by[0];
            } else {
              pto_x[i] += bx[i+r];
              pto_y[i] += by[i+r];
            }
            pto_x[i] /= 2;
            pto_y[i] /= 2;
          }
          accul -= 1;
          np++;
        }
      }

      if (Input.pressed(Key.A)) {
        increaseSpeed();
      } else if (Input.pressed(Key.S)) {
        decreaseSpeed();
      } else if (Input.pressed(Key.R)) {
        clear_drawing();
      } else if (Input.pressed(Key.P)) {
        increaseNV();
      } else if (Input.pressed(Key.O)) {
        decreaseNV();
      }
    }
  }

  public function increaseSpeed() {
    if (speed < max_speed)
      speed++;
#if online
    Main.submit("MaxSpeed", speed);
#end
  }

  public function decreaseSpeed() {
    if (speed > min_speed)
      speed--;
#if online
    Main.submit("MinSpeed", speed);
#end
  }

  public function increaseNV() {
    if (no_vertex < max_no_vertex)
      no_vertex++;
    clear_drawing();
#if online
    Main.submit("MaxNoVertex", no_vertex);
#end
  }

  public function decreaseNV() {
    if (no_vertex > 3)
      no_vertex--;
    clear_drawing();
#if online
    Main.submit("MinNoVertex", no_vertex);
#end
  }

  public function getSpeedFrac() : Float {
    var p:Float = speed - min_speed;
    p = p/(max_speed - min_speed);
    return p;
  }

  public function getSpeed() : String {
    return Std.string(speed - min_speed);
  }

  public function getNV() : String {
    return Std.string(no_vertex);
  }
  
  public function getNP() : String {
    return Std.string(np);
  }

  public function setThickness(p:Int) {
    psize = p;
  }

  public function waitForClick() {
    wfc = true;
    clear_drawing();
  }

}

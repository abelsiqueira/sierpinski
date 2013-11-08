import openfl.Assets;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Canvas;
import com.haxepunk.graphics.Text;
import flash.geom.Rectangle;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Menu extends Entity {

  private var speed_text:Text;
  private var np_text:Text;
  private var nv_text:Text;

  private var np_p_rect:Rectangle;
  private var np_m_rect:Rectangle;
  private var speed_p_rect:Rectangle;
  private var speed_m_rect:Rectangle;
  private var refresh_rect:Rectangle;
  private var click_rect:Rectangle;
  private var thickness_rects:Array<Rectangle>;
  private var thickness_canvas:Array<Canvas>;

  private var sierpinski:Sierpinski;

  private var speed_bar:Canvas;

  public function new(s:Sierpinski) {
    super();

    var np_plus:Image;
    var np_minus:Image;
    var speed_plus:Image;
    var speed_minus:Image;
    var refresh:Image;
    var click:Image;

    var d:Int = 15;

    this.sierpinski = s;


    speed_text = new Text("speed:");
    speed_text.x = HXP.height + d;
    speed_text.y = 100;
    speed_text.size = 20;

    speed_bar = new Canvas(HXP.width - Std.int(speed_text.x + speed_text.width)
        - 3*d, speed_text.height);
    speed_bar.x = speed_text.x + speed_text.width + d;
    speed_bar.y = speed_text.y;

    np_text = new Text("No points:\n" + s.getNP());
    np_text.x = HXP.height + d;
    np_text.y = 10;
    np_text.size = 20;

    nv_text = new Text("No vertices: " + s.getNV());
    nv_text.x = HXP.height + d;
    nv_text.y = 300;
    nv_text.size = 20;

    np_plus = new Image("gfx/plus.png");
    np_minus = new Image("gfx/minus.png");
    speed_plus = new Image("gfx/plus.png");
    speed_minus = new Image("gfx/minus.png");
    refresh = new Image("gfx/refresh.png");
    click = new Image("gfx/click.png");

    var w:Int = np_plus.width;
    var h:Int = np_plus.height;

    speed_p_rect = new Rectangle(HXP.width - w - d, 150, w, h);
    speed_m_rect = new Rectangle(HXP.height+d, 150, w, h);
    np_p_rect = new Rectangle(HXP.width - w - d, 350, w, h);
    np_m_rect = new Rectangle(HXP.height+d, 350, w, h);
    refresh_rect = new Rectangle(HXP.width - w - d, HXP.height-h-d, w, h);
    click_rect = new Rectangle(HXP.height + d, HXP.height-h-d, w, h);
    
    thickness_rects = new Array<Rectangle>();
    thickness_canvas = new Array<Canvas>();

    var i:Int;

    for (i in 0...3) {
      thickness_rects.push(new Rectangle(HXP.height +
            (HXP.width-HXP.height)/2 - 16 + 50*(i-1), 350 + h + 2*d, 32, 32));
      thickness_canvas.push(new Canvas(33, 33));
    }

    np_plus.x = np_p_rect.x;
    np_plus.y = np_p_rect.y;
    np_minus.x = np_m_rect.x;
    np_minus.y = np_m_rect.y;
    speed_plus.x = speed_p_rect.x;
    speed_plus.y = speed_p_rect.y;
    speed_minus.x = speed_m_rect.x;
    speed_minus.y = speed_m_rect.y;
    refresh.x = refresh_rect.x;
    refresh.y = refresh_rect.y;
    click.x = click_rect.x;
    click.y = click_rect.y;

    addGraphic(np_plus);
    addGraphic(np_minus);
    addGraphic(speed_plus);
    addGraphic(speed_minus);
    addGraphic(refresh);
    addGraphic(click);
    addGraphic(speed_text);
    addGraphic(np_text);
    addGraphic(nv_text);
    addGraphic(speed_bar);
    for (i in 0...3) {
      thickness_canvas[i].x = thickness_rects[i].x;
      thickness_canvas[i].y = thickness_rects[i].y;
      addGraphic(thickness_canvas[i]);
    }
    setThickness(0);
  }

  private function setThickness(p:Int) {
    for (i in 0...3) {
      thickness_canvas[i].x = thickness_rects[i].x;
      thickness_canvas[i].y = thickness_rects[i].y;
      thickness_canvas[i].fill(new Rectangle( 0, 0,33,33), 0xffffff);
      thickness_canvas[i].fill(new Rectangle( 1, 1,31,31), 0);
      thickness_canvas[i].fill(new Rectangle(15-2*i,15-2*i, 3+4*i, 3+4*i), 0xff0000);
      addGraphic(thickness_canvas[i]);
    }
    thickness_canvas[p].fill(new Rectangle( 0, 0,33,33), 0x00ff00);
    thickness_canvas[p].fill(new Rectangle( 3, 3,27,27), 0);
    thickness_canvas[p].fill(new Rectangle(15-2*p,15-2*p, 3+4*p, 3+4*p), 0xff0000);
  }

  override public function update() {
    super.update();

    speed_text.text = "speed:";
    np_text.text = "No points:\n" + sierpinski.getNP();
    nv_text.text = "No vertices: " + sierpinski.getNV();
    speed_bar.fill(new Rectangle(0,0,speed_bar.width,speed_bar.height), 0x333333);
    var p:Float = sierpinski.getSpeedFrac();
    speed_bar.fill(new Rectangle(0,0, p*speed_bar.width,speed_bar.height),
          Std.int(0xff*(1-p))*0x10000 + Std.int(0xff*p)*0x100);

    if (Input.mousePressed)
      handleMouse();
  }

  private function handleMouse() {
    var mx:Int = Input.mouseX;
    var my:Int = Input.mouseY;

    if (np_p_rect.contains(mx, my)) {
      sierpinski.increaseNV();
    } else if (np_m_rect.contains(mx, my)) {
      sierpinski.decreaseNV();
    } else if (speed_p_rect.contains(mx, my)) {
      sierpinski.increaseSpeed();
    } else if (speed_m_rect.contains(mx, my)) {
      sierpinski.decreaseSpeed();
    } else if (refresh_rect.contains(mx, my)) {
#if online
      Main.submit("Refreshed",1);
#end
      sierpinski.clear_drawing();
    } else if (click_rect.contains(mx, my)) {
      sierpinski.waitForClick();
    } else {
      var i:Int;
      for (i in 0...3) {
        if (thickness_rects[i].contains(mx, my)) {
          setThickness(i);
          sierpinski.setThickness(i+1);
        }
      }
    }
  }

}

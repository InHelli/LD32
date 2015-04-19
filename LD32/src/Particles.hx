package ;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Pazych
 */
class Particles extends Sprite implements ActiveObject
{
	public var localX:Float;
	public var localY:Float;
	public var size:Float;
	public var localRotation:Float;
	public var type:Int; 
	public var ps:Sprite = new Sprite();
	public var lifetime:Int;
	public var bmp:Bitmap;
	public var dirx:Float;
	public var diry:Float;
	public var dirrotation:Float;
	public var dirAlpha:Float;
	public function new(type:Int) 
	{
		super();
		this.type = type;
		addChild(ps);
		switch(type) {
			case -1: 
				//var temp = Math.round(Math.random() * 3)+2;
				//bmp = new Bitmap(PictersSource.particles[7]);
				ps.graphics.beginFill(0x8C0000,0.9);
				ps.graphics.drawCircle(0, 0, Std.int(Math.random()*3));
				ps.graphics.endFill();
				dirx = Math.random() * 3-1.5;
				diry = Math.random() * 3-1;
				//dirrotation = Math.random() * 10 - 5;
				dirrotation = 1;
				lifetime = 40;
				dirAlpha = 1;
			case 0: 
				bmp = new Bitmap(PictersSource.particles[0]);
				dirx = Math.random() * 3.8 - 1.9;
				diry = Math.random() * 3.8 - 1.9;
				dirrotation = Math.random() * 10 - 5;
				lifetime = 45;
				dirAlpha = 0.965;
			case 1: 
				bmp = new Bitmap(PictersSource.particles[1]);
				dirx = Math.random() * 3.8 - 1.9;
				diry = Math.random() * 3.8 - 1.9;
				dirrotation = Math.random() * 10 - 5;
				lifetime = 45;
				dirAlpha = 0.965;
			case 2:
		}
		if (type>=0)
		ps.addChild(bmp);
		//addEventListener(Event.ENTER_FRAME, onFrame);
	}
	
/*	public function onFrame(e:Event) {
		
	}*/
	public function free():Void 
	{
		if (parent.contains(this))
		{ 
			parent.removeChild(this);
		}
		Main.currentLevel.activeObjects.remove(this);
	}
	public function update():Void 
	{
		lifetime--;
		this.x += dirx;
		this.y += diry;
		this.rotation += dirrotation;
		alpha *= dirAlpha;
		if (lifetime == 0) {
			//removeEventListener(Event.ENTER_FRAME, onFrame);
			free();
		}
	}
	public function init(x:Int, y:Int):Void 
	{
		this.x = localX = x;
		this.y = localY = y;
		
		Main.currentLevel.objects.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		
	}
	
}
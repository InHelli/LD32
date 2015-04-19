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
	public var localRotation:Float;
	public var type:Int; 
	public var ps:Sprite = new Sprite();
	public var lifetime:Int = 50;
	public var bmp:Bitmap;
	public var dirx:Float = Math.random() * 6 - 3;
	public var diry:Float = Math.random() * 6 - 3;
	public function new(type:Int) 
	{
		super();
		this.type = type;
		addChild(ps);
		switch(type) {
			case 0: bmp = new Bitmap(PictersSource.particles[0]);
			case 1:
			case 2:
		}
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
		alpha *= 0.98;
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
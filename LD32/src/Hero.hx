package ;
import openfl.display.Sprite;
import Main;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
/**
 * ...
 * @author InHelli
 */
class Hero extends Sprite implements ActiveObject
{
	var keys:Map<Int,Bool>;
	var speed:Float;
	public var localX:Float;
	public var localY:Float;
	public var degToMouse:Float;
	public function new() 
	{
		super();
		this.scaleY = 0.4;
		keys = new Map<Int,Bool>();
		speed = 1;
	}
	
	/* INTERFACE ActiveObject */
	
	public function init(x:Int,y:Int):Void 
	{
		
		this.x = localX = x;
		this.y = localY = y;
		Main.currentLevel.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey.bind(true));
		stage.addEventListener(KeyboardEvent.KEY_UP, onKey.bind(false));
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	
	function onMouseMove(e:MouseEvent)
	{
		degToMouse = MyMath.getAngle(this.x,this.y,Main.currentLevel.mouse_X,Main.currentLevel.mouse_Y);
	}
	
	function onMouseDown(e:MouseEvent)
	{
		
		var eff:Effect = new Effect(degToMouse,1,20);
		eff.init(Math.round(this.x),Math.round(this.y));
	}
	
	function onKey(press:Bool,e:KeyboardEvent)
	{
		
		keys[e.keyCode] = press;
		
	}
	
	public function free():Void 
	{
		if (parent.contains(this))
		  { 
			parent.removeChild(this);
		  }
		Main.currentLevel.activeObjects.remove(this);
		
		stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey.bind(true));
		stage.removeEventListener(KeyboardEvent.KEY_UP, onKey.bind(false));
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		graphics.clear();
	}
	
	public function update():Void 
	{
		graphics.clear();
		graphics.beginFill(0x888888);
		graphics.drawCircle(0, 0, 20);
		graphics.endFill();
		move();
	}
	function move()
	{
		
		if (keys[87]) 
		{
			localY -= speed;
		}
		else if (keys[83])
		{
			localY += speed;
		}
		
		if (keys[65]) 
		{
			localX -= speed;
		}
		else if (keys[68])
		{
			localX += speed;
		}
		
		this.x = localX;
		this.y = localY;
	}
	
}
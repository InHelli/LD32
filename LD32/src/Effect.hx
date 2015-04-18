package ;
import openfl.display.Sprite;

/**
 * ...
 * @author InHelli
 */
class Effect extends Sprite implements ActiveObject
{
	public var localX:Float;
	public var localY:Float;
	public var localRotation:Float;
	public var speed:Float;
	public var lifetime:Int;
	public function new(deg:Float,speed:Float,lifetime:Int) 
	{
		super();
		this.rotation = MyMath.toDegrees(deg);
		localRotation = deg;
		this.speed = speed;
		this.lifetime = lifetime;
		this.scaleX = 0.1;
	}
	
	/* INTERFACE ActiveObject */
	
	
	public function init(x:Int,y:Int):Void 
	{
		this.x = localX = x;
		this.y = localY = y;
		Main.currentLevel.addChild(this);
		Main.currentLevel.effects.push(this);
		Main.currentLevel.activeObjects.push(this);
	}
	
	public function free():Void 
	{
		this.graphics.clear();
		if (parent.contains(this))
		{ 
			parent.removeChild(this);
		}
		Main.currentLevel.activeObjects.remove(this);
		Main.currentLevel.effects.remove(this);
	}
	
	public function update():Void 
	{
		graphics.clear();
		graphics.beginFill(0xD3D3D3);
		graphics.drawCircle(0, 0, 20);
		graphics.endFill();
		move();
		lifetime--;
		if (lifetime < 0) this.free();
	}
	
	function move()
	{
		
		localX += speed * Math.cos(localRotation);
		localY += speed * Math.sin(localRotation);
		
		this.x = localX;
		this.y = localY;
	}
	
}
package ;
import openfl.display.Sprite;

/**
 * ...
 * @author InHelli
 */
class Bullet extends Sprite implements ActiveObject
{
	
	public var localX:Float;
	public var localY:Float;
	public var localRotation:Float;
	public var speed:Float;
	public var lifetime:Int;
	public var friendly:Bool;
	public var size:Float;
	
	public function new(deg:Float,speed:Float,lifetime:Int) 
	{
		super();
		
		//this.rotation = MyMath.toDegrees(deg);
		localRotation = deg;
		this.speed = speed;
		this.lifetime = lifetime;
	}
	
	/* INTERFACE ActiveObject */
	
	public function free():Void 
	{
		this.graphics.clear();
		if (parent.contains(this))
		{ 
			parent.removeChild(this);
		}
		Main.currentLevel.activeObjects.remove(this);
		Main.currentLevel.bullets.remove(this);
	}
	
	public function update():Void 
	{
		graphics.clear();
		graphics.beginFill(0x00ff00);
		graphics.drawCircle(0, 0, 10);
		graphics.endFill();
		move();
		lifetime--;
		if (lifetime < 0) this.free();
		
		if (((MyMath.distance(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y, x, y) < Level.currentHero.size))&&!friendly)
		{
			
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.degToMouse-localRotation));
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep) - localRotation));
			var differ = MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation));
			
			//trace(MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation)));
			if (differ>=136)
			{
				
				var herDeg = Level.currentHero.degToMouse;
				localRotation = (herDeg + MyMath.toRadians(180 - differ));
				var differMove = MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.moveRotation), MyMath.toDegrees(localRotation));
				//trace(differMove);
				if (Level.currentHero.wallking && differMove<46)
				{
					
					speed += Level.currentHero.speed;
				}
				friendly = true;
			}
			else if(!friendly)
			{
				trace("Damage!");
				free();
			}
		}
		
	}
	
	public function init(x:Int, y:Int):Void 
	{
		this.x = localX = x;
		this.y = localY = y;
		Main.currentLevel.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		Main.currentLevel.bullets.push(this);
		friendly = false;
	}
	
	function move()
	{
		
		localX += speed * Math.cos(localRotation);
		localY += speed * Math.sin(localRotation);
		
		this.x = localX;
		this.y = localY;
	}
}
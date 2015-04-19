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
	public var size:Float  = 10;
	public var shadow:Sprite;
	public function new(deg:Float,speed:Float,lifetime:Int) 
	{
		super();
		
		//this.rotation = MyMath.toDegrees(deg);
		localRotation = deg;
		this.speed = speed;
		this.lifetime = lifetime;
		shadow = new Sprite();
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
		graphics.beginFill(0x595959);
		graphics.drawCircle(0, -20, 10);
		graphics.endFill();
		
		shadow.graphics.clear();
		shadow.graphics.beginFill(0x888888);
		shadow.graphics.drawCircle(0, 20, size);
		shadow.graphics.endFill();
		move();
		lifetime--;
		if (lifetime < 0) this.free();
		
		if (Level.isCollision(Level.currentHero,this)&&!friendly)
		{
			
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.degToMouse-localRotation));
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep) - localRotation));
			var differ = MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation));
			
			//trace(MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation)));
			if (Level.currentHero.isHit(this))
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
				Level.currentHero.Damaged();
				free();
			}
		}
		
	}
	
	public function init(x:Int, y:Int):Void 
	{
		this.x = localX = x;
		this.y = localY = y;
		Main.currentLevel.objects.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		Main.currentLevel.bullets.push(this);
		friendly = false;
		addChild(shadow);
		shadow.alpha = 0.6;
		shadow.scaleY = 0.4;
	}
	
	function move()
	{
		
		localX += speed * Math.cos(localRotation);
		localY += speed * Math.sin(localRotation);
		
		this.x = localX;
		this.y = localY;
	}
}
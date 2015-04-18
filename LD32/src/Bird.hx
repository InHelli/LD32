package ;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author InHelli
 */
class Bird extends Sprite implements ActiveObject
{
	public var localX:Float;
	public var localY:Float;
	public var localRotation:Float;
	public var speed:Float;
	public var target:Point;
	public var pic:Bitmap;
	public var animSpeed:Int = 10;
	public var animCooldown:Int = 0;
	public var animstep:Int = 0;
	public var globalScale = 0.5;
	public var stopDown:Int;
	public function new() 
	{
		super();
		speed = 2;
		target = new Point(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y);
		pic = new Bitmap();
		scaleX = scaleY = globalScale;
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
		removeChild(pic);
	}
	
	public function update():Void 
	{
		animCooldown -= animSpeed;
		if (animCooldown < 0)
		{
			animCooldown += 60;
			pic.bitmapData = PictersSource.birdArray[animstep];
			animstep++;
			if (animstep >= PictersSource.birdArray.length) 
			{
				animstep = 0;
				pic.x = -pic.bitmapData.width / 2;
				pic.y = -pic.bitmapData.height / 2;
			}
		}
		
		if (localRotation > 1.57 && localRotation < 4.71)
		{
			scaleX = -globalScale;
		}
		else 
		{
			scaleX = globalScale;
		}
		move();
		
		
		
		if (((MyMath.distance(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y, x, y) < Level.currentHero.size)))
		{
			
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.degToMouse-localRotation));
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep) - localRotation));
			var differ = MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation));
			
			//trace(MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation)));
			if (differ>=136)
			{
				
				free();
				
			}
			else
			{
				trace("Damage!");
				free();
			}
		}
	}
	
	function move()
	{
		if (MyMath.distance(localX, localY, target.x, target.y) < 10)
		{
			if (stopDown > 0)
			{
				stopDown--;
			}
			else
			{
				resetTarget();
			}
		}
		else
		{
			localX += speed * Math.cos(localRotation);
			localY += speed * Math.sin(localRotation);
			
			this.x = localX;
			this.y = localY;
		}
	}
	
	function resetTarget()
	{
		var size = Level.currentHero.size;
		switch(Math.round(Math.random() * 5))
		{
			case 0: target = new Point(Level.currentHero.heroPoint.x + size, Level.currentHero.heroPoint.y);
			case 1: target = new Point(Level.currentHero.heroPoint.x - size, Level.currentHero.heroPoint.y);
			case 2: target = new Point(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y+size);
			case 3: target = new Point(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y-size);
			case 4: target = new Point(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y);
			case 5: 
			{
				target = new Point(x, y);
				stopDown = 60;
			}
		}
		localRotation = MyMath.getAngle(localX, localY, target.x,target.y);
	}
	
	public function init(x:Int, y:Int):Void 
	{
		
		this.x = localX = x;
		this.y = localY = y;
		resetTarget();
		Main.currentLevel.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		addChild(pic);
	}
	
}
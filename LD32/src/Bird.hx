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
	public var shadow:Sprite;
	public var size:Float = 3;
	
	
	public function new() 
	{
		super();
		speed = 2;
		target = new Point(Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y);
		pic = new Bitmap();
		scaleX = scaleY = globalScale;
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
		removeChild(pic);
		shadow.graphics.clear();
		this.removeChild(shadow);
	}
	
	public function update():Void 
	{
		shadow.graphics.clear();
		shadow.graphics.beginFill(0x888888);
		shadow.graphics.drawCircle(0, 0, globalScale*40);
		shadow.graphics.endFill();
		
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
		
		
		
		if (Level.isCollision(this,Level.currentHero))
		{
			if(Level.currentHero.isHit(this))
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
		shadow.scaleY = 0.4;
		this.x = localX = x;
		this.y = localY = y;
		resetTarget();
		Main.currentLevel.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		
		addChild(shadow);
		shadow.y = 0;
		pic.y = -140;
		addChild(pic);
		
	}
	
}
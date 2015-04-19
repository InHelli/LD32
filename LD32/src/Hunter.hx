package ;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author InHelli
 */
class Hunter extends Sprite implements ActiveObject
{
	public var localX:Float;
	public var localY:Float;
	public var localRotation:Float;
	public var speed:Float;
	public var target:Point;
	public var pic:Bitmap;
	public var animSpeed:Int = 5;
	public var animCooldown:Int = 0;
	public var animstep:Int = 0;
	public var globalScale = 1.4;
	public var stopDown:Int;
	public var shadow:Sprite;
	public var size:Float = 20;
	
	
	
	public function new() 
	{
		super();
		speed = 8;
		target = new Point(Level.currentHero.localX, Level.currentHero.localY);
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
		shadow.graphics.drawCircle(0, 0, globalScale*10);
		shadow.graphics.endFill();
		
		animCooldown -= animSpeed;
		if (animCooldown < 0)
		{
			animCooldown += 60;
			pic.bitmapData = PictersSource.eagleArray[animstep];
			animstep++;
			if (animstep >= PictersSource.eagleArray.length) 
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
				Audio.playHit();
				
				for (i in 0...20) {
					var ps:Particles = new Particles(1);
					ps.init(Math.round(x+pic.x), Math.round(y+pic.y));
				}
				Level.currentHero.scores+=3;
				free();
				
			}
			else
			{
				Level.currentHero.Damaged();
				for (i in 0...18) {
					var ps:Particles = new Particles( -1);
					ps.scaleX = 1.7;
					ps.scaleY = 1.7;
					ps.init(Math.round(Level.currentHero.localX),Math.round(y+pic.y));
					//ps.init(Math.round(Level.currentHero.localX), Math.round(Level.currentHero.localY - 55));
				}

				trace("Damage!");
				Level.currentHero.health -= 10;

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
			case 0: target = new Point(Level.currentHero.localX + size, Level.currentHero.localY);
			case 1: target = new Point(Level.currentHero.localX - size, Level.currentHero.localY);
			case 2: target = new Point(Level.currentHero.localX, Level.currentHero.localY+size);
			case 3: target = new Point(Level.currentHero.localX, Level.currentHero.localY-size);
			case 4: target = new Point(Level.currentHero.localX, Level.currentHero.localY);
			case 5: 
			{
				target = new Point(x, y);
				
			}
		}
		stopDown = Math.round(50 + Math.random()*90);
		localRotation = MyMath.getAngle(localX, localY, target.x,target.y);
	}
	
	public function init(x:Int, y:Int):Void 
	{
		
		shadow.scaleY = 0.4;
		this.x = localX = x;
		this.y = localY = y;
		resetTarget();
		
		Main.currentLevel.objects.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		
		addChild(shadow);
		shadow.y = 20;
		shadow.alpha = 0.6;
		pic.y = -30;
		addChild(pic);
	}
	
}
package ;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author InHelli
 */
class Goblin extends Sprite implements ActiveObject
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
	public var globalScale = 0.2;
	public var stopDown:Int;
	public var shadow:Sprite;
	public var size:Float = 10;
	public var startDown:Int = 120;
	public var bombCooldown:Int;
	
	public function new() 
	{
		super();
		speed = 2;
		target = new Point(Level.currentHero.localX, Level.currentHero.localY);
		
		pic = new Bitmap();
		scaleX = scaleY = globalScale;
		shadow = new Sprite();
		
	}
	
	public function init(x:Int, y:Int):Void 
	{
		localX = x;
		this.x = localX;
		localY = y;
		this.y = localY = y;
		shadow.scaleY = 0.4;
		localRotation = MyMath.getAngle(localX, localY, target.x, target.y);
		addChild(pic);
		addChild(shadow);
		shadow.alpha = 0.6;
		
		Main.currentLevel.objects.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		
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
		if(bombCooldown>0)bombCooldown--;
		shadow.graphics.clear();
		shadow.graphics.beginFill(0x888888);
		shadow.graphics.drawCircle(0, 0, size/globalScale);
		shadow.graphics.endFill();
		
		
		
		
		if (localRotation > 1.57 && localRotation < 4.71)
		{
			scaleX = globalScale;
		}
		else 
		{
			scaleX = -globalScale;
		}
		move();
		
		
		
		if (Level.isCollision(this,Level.currentHero))
		{
			if(Level.currentHero.isHit(this))
			{
				Audio.playHit();
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
		if (MyMath.distance(localX, localY, target.x, target.y) < size)
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
			
			animCooldown -= animSpeed;
			if (animCooldown < 0)
			{
				animCooldown += 60;
				pic.bitmapData = PictersSource.goblin0[animstep];
				pic.x = -pic.bitmapData.width / 2;
				pic.y = -pic.bitmapData.height;
				
				animstep++;
				if (animstep >= PictersSource.birdArray.length) 
				{
					animstep = 0;
					
					
				}
			}
		}
		if (startDown > 0)
		{
			startDown--;
		}
		if (startDown == 0)
		{
			resetTarget();
			startDown--;
		}
		
	}
	
	function resetTarget()
	{ 
		
		switch(Math.round(Math.random() * 2))
		{
			case 0:
				{
					target = new Point(Math.random()*800,Math.random()*480);
				}
			case 1:
				{
					if (bombCooldown <= 0)
					{
						pic.bitmapData = PictersSource.goblin1[0];
						stopDown = 5;
						var bul:Bullet = new Bullet(MyMath.getAngle(localX, localY, Level.currentHero.localX, Level.currentHero.localY), 3, 1000);
						bul.init(Math.round(localX), Math.round(localY));
						bombCooldown = 60;
					}
					else {
						resetTarget();
					}
				}
			case 2: 
			{
				target = new Point(x, y);
				stopDown = 60;
			}
		}
		localRotation = MyMath.getAngle(localX, localY, target.x,target.y);
	}
	
	
	
	
	
	
	
}
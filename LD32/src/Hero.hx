package ;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import Main;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.geom.Point;
/**
 * ...
 * @author InHelli
 */
class Hero extends Sprite implements ActiveObject
{
	var keys:Map<Int,Bool>;
	public var speed:Float;
	public var localX:Float;
	public var localY:Float;
	public var degToMouse:Float;
	public var herobitmapData:Animation;
	public var shadow:Sprite;
	public var size:Float = 40;
	public var wallking:Bool;
	public var shield:Bitmap;
	var shieldSize:Float = 1.3;
	var shieldSpr:Sprite;
	public var mouseStep:Int;
	public var moveRotation:Float;
	public var shieldDeg:Float = 125;
	public var localRotation:Float;
	//public var localRotation:Float;
	public function new() 
	{
		super();
		shadow = new Sprite();
		shield = new Bitmap(PictersSource.shieldArray[0]);
		keys = new Map<Int,Bool>();
		speed = 2;
		shieldSpr = new Sprite();
		shieldSpr.addChild(shield);
	}
	
	/* INTERFACE ActiveObject */
	
	public function init(x:Int,y:Int):Void 
	{
		herobitmapData = new Animation(PictersSource.hero0,1);
		this.addChild(shadow);
		this.addChild(herobitmapData);
		this.addChild(shieldSpr);
		workSprite();
		
		this.x = localX = x;
		this.y = localY = y;
		wallking = false;
		
		
		Main.currentLevel.objects.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey.bind(true));
		stage.addEventListener(KeyboardEvent.KEY_UP, onKey.bind(false));
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	function workSprite()
	{
		
		herobitmapData.y = -herobitmapData.height;
		
		shadow.scaleY = 0.4;
		shadow.alpha = 0.6;
		
		shield.scaleX = shield.scaleY = shieldSize;
		shield.x = - shield.width / 2;
		shield.y = - shield.height+size*0.4;
	}
	
	function onMouseMove(e:MouseEvent)
	{
		degToMouse = MyMath.getAngle(this.x, this.y, Main.currentLevel.mouse_X, Main.currentLevel.mouse_Y, true);
		
		if (degToMouse > 0.39)
		{
			mouseStep = Math.round(Math.abs(MyMath.toDegrees(degToMouse)-45)/45);
		}
		else
		{
			mouseStep = 0;
		}
		
		//trace(mouseStep);
		
		switch(mouseStep)
		{
			case 0:shield.bitmapData = PictersSource.shieldArray[1];
			case 1:shield.bitmapData = PictersSource.shieldArray[0];
			case 2:shield.bitmapData = PictersSource.shieldArray[1];
			case 3:shield.bitmapData = PictersSource.shieldArray[4];
			case 4:shield.bitmapData = PictersSource.shieldArray[3];
			case 5:shield.bitmapData = PictersSource.shieldArray[2];
			case 6:shield.bitmapData = PictersSource.shieldArray[3];
			case 7:shield.bitmapData = PictersSource.shieldArray[4];
		}
		
		if (mouseStep == 1 || mouseStep == 5)
		{
			shieldSpr.x = 0;
		}
		else if (mouseStep >= 2 && mouseStep <= 4)
		{
			shieldSpr.scaleX = -1;
			shieldSpr.x = -Level.currentHero.size / 2;
		} else
		{
			shieldSpr.scaleX = 1;
			
			shieldSpr.x = Level.currentHero.size/2;
		}
		
		
		
		if (mouseStep >= 4 && mouseStep <= 6) //верх низ
		{
			shieldSpr.y = -20;
			setChildIndex(shieldSpr, 1);
		}
		else if( mouseStep <= 2)
		{
			shieldSpr.y = 5;
			setChildIndex(herobitmapData, 1);
		}
		else
		{
			shieldSpr.y = -10;
			setChildIndex(herobitmapData, 1);
		}
		
		localRotation = getShieldAngel(mouseStep);
		//анимация
		
		checkAnimation();
	}
	
	var animation:Int;
	public function checkAnimation()
	{
		var newAnim:Int;
		if (mouseStep == 5)
		{
			newAnim = 0;
			
		}
		else if (mouseStep==1)
		{
			newAnim = 1;
		}
		else if(mouseStep >= 2 && mouseStep <= 4)
		{
			newAnim = 2;
		}
		else
		{
			newAnim = 3;
		}
			
		if (newAnim != animation)
		{
			switch(newAnim)
			{
				case 0:
					{
						herobitmapData.changeAnimation(PictersSource.hero1, 10);
						herobitmapData.scaleX = 1;
					}
				case 1: 
					{
						herobitmapData.changeAnimation(PictersSource.hero0, 10);
						herobitmapData.scaleX = 1;
					}
				case 2:
					{
						herobitmapData.changeAnimation(PictersSource.hero2, 10);
						herobitmapData.scaleX = -1;
					}
				case 3:	
					{
						herobitmapData.changeAnimation(PictersSource.hero2, 10);
						herobitmapData.scaleX = 1;
					}
			
			}
		animation = newAnim;
		}
	}
	
	function onMouseDown(e:MouseEvent)
	{
		
		var eff:Effect = new Effect(degToMouse,3,8);
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
		shadow.graphics.clear();
		this.removeChild(shadow);
		herobitmapData.free();
		this.removeChild(herobitmapData);
		shieldSpr.removeChild(shield);
		removeChild(shieldSpr);
	}
	public function getShieldAngel(?step:Int):Float
	{
		return MyMath.toRadians(45+ mouseStep * 45);
	}
	
	public function update():Void 
	{
		shadow.graphics.clear();
		shadow.graphics.beginFill(0x888888);
		shadow.graphics.drawCircle(0, 0, size);
		shadow.graphics.endFill();
		move();
		if(wallking)herobitmapData.update();
	}
	function move()
	{
		
		var newX:Float = localX;
		var newY:Float = localY;
		wallking = false;
		if (keys[87]) 
		{
			newY -= speed;
			wallking = true;
		}
		else if (keys[83])
		{
			newY += speed;
			wallking = true;
		}
		
		if (keys[65]) 
		{
			newX -= speed;
			wallking = true;
		}
		else if (keys[68])
		{
			newX += speed;
			wallking = true;
		}
		moveRotation = MyMath.getAngle(localX, localY, newX, newY);
		//trace(MyMath.toDegrees(moveRotation));
		if (newX > size && 
			newX < stage.stageWidth - size)
			{
				this.x = localX = newX;
			}
		if(newY > size && 
			newY < stage.stageHeight - size)
		{
			
			this.y = localY = newY;
		}
		
	}
	
	public function isHit(a:ActiveObject)
	{
			a.localRotation = MyMath.getAngle(a.localX, a.localY, localX,localY);
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.degToMouse-localRotation));
			//var differ = MyMath.toDegrees(Math.abs(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep) - localRotation));
			var differ = MyMath.betweenAnglesDeg(MyMath.toDegrees(localRotation), MyMath.toDegrees(a.localRotation));
			
			//trace(MyMath.betweenAnglesDeg(MyMath.toDegrees(Level.currentHero.getShieldAngel(Level.currentHero.mouseStep)), MyMath.toDegrees(localRotation)));
			if (differ >= Level.currentHero.shieldDeg)
			{
				Audio.playRicoshet();
				return true;
			}
			else
			{
				return false;
			}
	}
}
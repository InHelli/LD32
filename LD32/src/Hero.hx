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
	public var herobitmapData:Bitmap;
	public var shadow:Sprite;
	public var size:Float = 30;
	public var wallking:Bool;
	public var shield:Bitmap;
	var shieldSize:Float = 1.3;
	public var offset_Y = -10;
	var shieldSpr:Sprite;
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
		
		this.addChild(shadow);
		this.addChild(herobitmapData = new Bitmap(new BitmapData(10, 10, false, 0x00ff00)));
		this.addChild(shieldSpr);
		
		workSprite();
		
		this.x = localX = x;
		this.y = localY = y;
		wallking = false;
		
		Main.currentLevel.addChild(this);
		Main.currentLevel.activeObjects.push(this);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey.bind(true));
		stage.addEventListener(KeyboardEvent.KEY_UP, onKey.bind(false));
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	function workSprite()
	{
		herobitmapData.x = -herobitmapData.width / 2;
		herobitmapData.y = -herobitmapData.height;
		herobitmapData.z = 0;
		shadow.scaleY = 0.4;
		
		
		shield.scaleX = shield.scaleY = shieldSize;
		shieldSpr.x = - shield.width / 2;
		shieldSpr.y = - shield.height+size*0.4;
	}
	
	function onMouseMove(e:MouseEvent)
	{
		degToMouse = MyMath.getAngle(this.x, this.y, Main.currentLevel.mouse_X, Main.currentLevel.mouse_Y, true);
		var mouseStep:Float;
		if (degToMouse > 0.39)
		{
			mouseStep = Math.round(Math.abs(MyMath.toDegrees(degToMouse)-45)/45);
		}
		else
		{
			mouseStep = 0;
		}
		
		
		
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
			shieldSpr.scaleX = 1;
			//shieldSpr.x = -10;
		}
		else if (mouseStep >= 2 && mouseStep <= 4)
		{
			shieldSpr.scaleX = -1;
			//shieldSpr.x = 10;
		}
		else
		{
			shield.scaleX = shieldSize;
		}
		
		if (mouseStep >= 4 && mouseStep <= 6)
		{
			//shield.y = - shield.height - size * 0.2;
			setChildIndex(shieldSpr, 1);
		}
		else
		{
			//shield.y = - shield.height + size * 0.5;
			setChildIndex(herobitmapData, 1);
		}
		
		
		
	}
	
	function onMouseDown(e:MouseEvent)
	{
		
		var eff:Effect = new Effect(degToMouse,3,8);
		eff.init(Math.round(this.x),Math.round(this.y));
	}
	
	function onKey(press:Bool,e:KeyboardEvent)
	{
		wallking = press;
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
		this.removeChild(herobitmapData);
	}
	
	public function update():Void 
	{
		shadow.graphics.clear();
		shadow.graphics.beginFill(0x888888);
		shadow.graphics.drawCircle(0, 0, size);
		shadow.graphics.endFill();
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
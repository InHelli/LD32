package ;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
/**
 * ...
 * @author InHelli
 */
class Level extends Sprite
{
	public var activeObjects:Array<ActiveObject>;
	public static var currentHero:Hero;
	public var sound:Audio;
	public var mouse_X:Float;
	public var mouse_Y:Float;
	public var bullets:Array<Bullet>;
	public var effects:Array<Effect>;
	public var fon:Bitmap;
	public var gameInterFace:Sprite;
	public var objects:Sprite;
	public var healthBar:Sprite;
	
	public function new() 
	{
		super();
		activeObjects = [];
		bullets = [];
		effects = [];

		sound = new Audio();
		this.addEventListener(Event.ADDED, added);
		sound.playFon();
		this.addEventListener(Event.ADDED,added);
	}
	
	function added(e:Event)
	{
		
		this.removeEventListener(Event.ADDED, added);
		
		
		fon = new Bitmap(PictersSource.tittle[1]);
		objects = new Sprite();

		healthBar = new Sprite();
		gameInterFace = new Sprite();

		addChild(fon);
		addChild(objects);
		addChild(gameInterFace);
		healthBar.graphics.beginFill(0x2147AD);
		healthBar.graphics.drawRect(0, 460, 8, 20);
		healthBar.graphics.endFill();
		gameInterFace.addChild(healthBar);
		//==Hero
		currentHero = new Hero();
		currentHero.init(400, 280);
		
		
		
		
		
		//==grass
		for (i in 0...7)
		{
			var bush:Tittle = new Tittle();
			bush.init(Math.round(100+Math.random()*700), Math.round(50+Math.random()*380));
		}
		
		
		
		//==Final
		this.addEventListener(Event.ENTER_FRAME, onUpdate);
		this.addEventListener(Event.REMOVED_FROM_STAGE, removed);
		stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
		
	}
	
	function onMouseMove(e:MouseEvent)
	{
		mouse_X = e.stageX;
		mouse_Y = e.stageY;
	}
	
	
	
	function onUpdate(e:Event)
	{
		healthBar.scaleX = Level.currentHero.health;
		frame++;
		for (obj in activeObjects)
		{
			obj.update();
		}
		
		somefunc();
		
		activeObjects.sort(function(a:ActiveObject, b:ActiveObject):Int
		{
			
			if (a.localY < b.localY) return -1;
			if (a.localY > b.localY) return 1;
			return 0;
		} );
		
		for (i in 0...activeObjects.length)
		{
			
			objects.setChildIndex(cast(activeObjects[i],Sprite), i);
		}
	}
	
	public var frame:Int = 0;
	var degToHero:Float;
	function somefunc()
	{
		
		
		if (frame % 200 == 0)
		{
			
			var TX:Float = -20 + Math.random() * 840;
			var TY:Float = -20 * Math.round(0 - Math.random());
			if (Math.random() > 0.5)
			{
			 TX= -20 * Math.round(0 - Math.random());
			 TY= -20 + Math.random() * 520;
			}
			//var degToHero:Float = MyMath.getAngle(TX, TY, Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y);
			
			var bird:Bird = new Bird();
			bird.init(Math.round(TX),Math.round(TY));
			
			
		}
		
		if (frame % 500 == 0)
		{
			
			var TX:Float = -20 + Math.random() * 840;
			var TY:Float = -20 * Math.round(0 - Math.random());
			if (Math.random() > 0.5)
			{
			 TX= -20 * Math.round(0 - Math.random());
			 TY= -20 + Math.random() * 520;
			}
			//var degToHero:Float = MyMath.getAngle(TX, TY, Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y);
			
			var hunter:Hunter = new Hunter();
			hunter.init(Math.round(TX),Math.round(TY));
			
			
		}
		
		if (frame % 450 == 0)
		{
			
			var TX:Float = -20 + Math.random() * 840;
			var TY:Float = -20 * Math.round(0 - Math.random());
			if (Math.random() > 0.5)
			{
			 TX= -20 * Math.round(0 - Math.random());
			 TY= -20 + Math.random() * 520;
			}
			//var degToHero:Float = MyMath.getAngle(TX, TY, Level.currentHero.heroPoint.x, Level.currentHero.heroPoint.y);
			
			var gob:Goblin = new Goblin();
			gob.init(Math.round(TX),Math.round(TY));
			
			
		}
		
		
		
	}
	static public function isCollision(a:ActiveObject,b:ActiveObject)
	{
		if ((MyMath.distance(a.localX, a.localY, b.localX, b.localY) < a.size+b.size))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function removed(e:Event)
	{
		this.removeEventListener(Event.ENTER_FRAME, onUpdate);
		removeChild(fon);
		removeChild(objects);
		removeChild(gameInterFace);
		
		
	}
	
}
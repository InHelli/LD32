package ;

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
	public var mouse_X:Float;
	public var mouse_Y:Float;
	public var bullets:Array<Bullet>;
	public var effects:Array<Effect>;
	public function new() 
	{
		super();
		activeObjects = [];
		bullets = [];
		effects = [];
		this.addEventListener(Event.ADDED,added);
	}
	
	function added(e:Event)
	{
		this.removeEventListener(Event.ADDED, added);
		
		//==Hero
		currentHero = new Hero();
		currentHero.init(400, 280);
		
		
		//==grass
		for (i in 0...4)
		{
			var bush:Tittle = new Tittle();
			bush.init(Math.round(100+Math.random()*700), Math.round(50+Math.random()*430));
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
			
			this.setChildIndex(cast(activeObjects[i],Sprite), i);
		}
	}
	
	public var frame:Int = 0;
	var degToHero:Float;
	function somefunc()
	{
		
		
		if (frame % 100 == 0)
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
		
		if (frame % 300 == 0)
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
	}
	
}
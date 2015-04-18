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
	}
	
	var frame:Int = 0;
	var degToHero:Float;
	function somefunc()
	{
		frame++;
		if (frame % 60 == 0)
		{
			var TX:Float = 400;
			var TY:Float = 240;
			var degToHero:Float = MyMath.getAngle(TX, TY, currentHero.x, currentHero.y+Level.currentHero.offset_Y);
			
			var bul:Bullet = new Bullet(degToHero, 4, 4000);
			bul.init(Math.round(TX),Math.round(TY));
		}
	}
	
	function removed(e:Event)
	{
		this.removeEventListener(Event.ENTER_FRAME, onUpdate);
	}
	
}
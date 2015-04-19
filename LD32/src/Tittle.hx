package ;

import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author InHelli
 */
class Tittle extends Sprite implements ActiveObject
{
	var pic:Bitmap;
	public var localX:Float;
	public var localY:Float;
	public var localRotation:Float;
	public var size:Float = 50;
	public function new() 
	{
		super();
		pic = new Bitmap(PictersSource.tittle[0]);
		pic.x = -pic.width / 2;
		pic.y = -pic.height;
		this.alpha = 0.8;
	}
	
	/* INTERFACE ActiveObject */
	
	public function free():Void 
	{
		removeChild(pic);
		if (parent.contains(this))
		parent.removeChild(this);
		Main.currentLevel.activeObjects.remove(this);
	}
	
	public function update():Void 
	{
		if (MyMath.distance(Level.currentHero.localX, Level.currentHero.localY, x, y) < size && Level.currentHero.y < localY)
		{
			alpha = 0.5;
		}
		else
		{
			alpha = 0.8;
		}
	}
	
	public function init(x:Int, y:Int):Void 
	{
		addChild(pic);
		
		
		this.x = localX=x;
		this.y =localY= y;
		Main.currentLevel.addChild(this);
		Main.currentLevel.activeObjects.push(this);
	}
	
}
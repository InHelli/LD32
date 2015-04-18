package ;

import openfl.display.Sprite;
/**
 * ...
 * @author InHelli
 */
class Level extends Sprite
{
	public var activeObjects:Array<ActiveObject>;
	public function new() 
	{
		super();
		activeObjects = [];
	}
	
}
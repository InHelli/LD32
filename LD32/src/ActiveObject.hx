package ;

/**
 * @author InHelli
 */

interface ActiveObject 
{
	public var localX:Float;
	public var localY:Float;
	public var localRotation:Float;
	//==function
	public function free():Void;
	public function update():Void;
	public function init(x:Int,y:Int):Void;
  
}
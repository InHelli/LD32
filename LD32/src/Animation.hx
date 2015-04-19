package ;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

/**
 * ...
 * @author Pazych
 */
class Animation extends Sprite
{
	public var bmp:Bitmap;
	public var bmdArray:Array<BitmapData>;
	public var frame:Int = 0;
	public var timePerOneFrame:Int;
	public var i:Int = 0;
	public function new(bitmapDataArray:Array<BitmapData>, repeatTime:Int) 
	{
		super();
		bmdArray = bitmapDataArray;
		
		bmp = new Bitmap(bmdArray[0]);
		bmp.x = -bmp.width / 2;
		timePerOneFrame = Std.int(repeatTime / bmdArray.length);
		this.addChild(bmp);
	}
	
	/* INTERFACE ActiveObject */
	
	public function free():Void 
	{
		if (parent.contains(this))
		  { 
			parent.removeChild(this);
		  }
	}
	
	public function update():Void 
	{
		frame++;
		if (frame == timePerOneFrame) {
			frame = 0;
			
			if (i < bmdArray.length-1) {
				i++;
			}
			else {
				i = 0;
			}
			bmp.bitmapData = bmdArray[i];
		}
	}
	
	public function changeAnimation(bitmapDataArray:Array<BitmapData>, repeatTime:Int)
	{
		bmdArray = bitmapDataArray;
		
		bmp.bitmapData = bitmapDataArray[0];
		frame = 0;
		i = 0;
		
		timePerOneFrame = Std.int(repeatTime / bmdArray.length);
	}
	
}
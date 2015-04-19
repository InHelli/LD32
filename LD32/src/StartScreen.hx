package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author pazych
 */
class StartScreen extends Sprite
{
	public var bmp:Bitmap;
	public function new() 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/startscreen.png"));
		addChild(bmp);
		addEventListener(MouseEvent.CLICK, onClick);
		
	}
	
	public function onClick(e:MouseEvent) {
		dispatchEvent(new Event("start"));
	}
	
}
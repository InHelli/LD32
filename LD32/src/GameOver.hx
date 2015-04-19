package ;
import openfl.display.Sprite;

/**
 * ...
 * @author pazych
 */
class GameOver extends Sprite
{

	public function new() 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/startscreen.png"));
		addChild(bmp);
		addEventListener(MouseEvent.CLICK, onClick);
	}
	public function onClick(e:MouseEvent) {
		dispatchEvent(new Event("restart"));
	}
	
}
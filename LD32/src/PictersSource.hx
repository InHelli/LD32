package ;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author InHelli
 */
class PictersSource
{
	public static var shieldArray:Array<BitmapData>;
	static public function load()
	{
		shieldArray = new Array<BitmapData>();
		shieldArray.push(Assets.getBitmapData("img/Shield/0.png")); //0
		shieldArray.push(Assets.getBitmapData("img/Shield/1.png")); //1
		//shieldArray.push(Assets.getBitmapData("img/Shield/2.png"));
		shieldArray.push(Assets.getBitmapData("img/Shield/4.png")); //2
		//shieldArray.push(Assets.getBitmapData("img/Shield/5.png")); 
		shieldArray.push(Assets.getBitmapData("img/Shield/6.png")); //3
		shieldArray.push(Assets.getBitmapData("img/Shield/7.png")); //4
		//shieldArray.push(Assets.getBitmapData("img/Shield/8.png"));
	}
	
}
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
	public static var birdArray:Array<BitmapData>;
	static public function load()
	{
		shieldArray = [];
		birdArray = [];
		shieldArray.push(Assets.getBitmapData("img/Shield/0.png")); //0
		shieldArray.push(Assets.getBitmapData("img/Shield/1.png")); //1
		//shieldArray.push(Assets.getBitmapData("img/Shield/2.png"));
		shieldArray.push(Assets.getBitmapData("img/Shield/4.png")); //2
		//shieldArray.push(Assets.getBitmapData("img/Shield/5.png")); 
		shieldArray.push(Assets.getBitmapData("img/Shield/6.png")); //3
		shieldArray.push(Assets.getBitmapData("img/Shield/7.png")); //4
		//shieldArray.push(Assets.getBitmapData("img/Shield/8.png"));
		birdArray.push(Assets.getBitmapData("img/Enemys/1.png"));//0
		birdArray.push(Assets.getBitmapData("img/Enemys/2.png"));//1
	}
	
}
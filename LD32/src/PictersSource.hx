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
	public static var eagleArray:Array<BitmapData>;
	public static var tittle:Array<BitmapData>;
	static public function load()
	{
		shieldArray = [];
		birdArray = [];
		eagleArray = [];
		tittle = [];
		shieldArray.push(Assets.getBitmapData("img/Shield/0.png")); //0
		shieldArray.push(Assets.getBitmapData("img/Shield/1.png")); //1
		//shieldArray.push(Assets.getBitmapData("img/Shield/2.png"));
		shieldArray.push(Assets.getBitmapData("img/Shield/4.png")); //2
		//shieldArray.push(Assets.getBitmapData("img/Shield/5.png")); 
		shieldArray.push(Assets.getBitmapData("img/Shield/6.png")); //3
		shieldArray.push(Assets.getBitmapData("img/Shield/7.png")); //4
		//shieldArray.push(Assets.getBitmapData("img/Shield/8.png"));
		
		shieldArray.push(Assets.getBitmapData("img/Hero/4_1.png"));//5
		shieldArray.push(Assets.getBitmapData("img/Hero/4_2.png"));//6
		shieldArray.push(Assets.getBitmapData("img/Hero/6_1.png"));//7
		shieldArray.push(Assets.getBitmapData("img/Hero/6_2.png"));//8
		shieldArray.push(Assets.getBitmapData("img/Hero/7_1.png"));//9
		
		
		birdArray.push(Assets.getBitmapData("img/Enemys/1.png"));//0
		birdArray.push(Assets.getBitmapData("img/Enemys/2.png"));//1
		
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle1.png"));//0
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle2.png"));//1
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle3.png"));//2
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle2.png"));//3
		
		tittle.push(Assets.getBitmapData("img/bush.png"));//0
	}
	
}
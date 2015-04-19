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

	public static var particles:Array<BitmapData>;

	public static var hero0:Array<BitmapData>;
	public static var hero1:Array<BitmapData>;
	public static var hero2:Array<BitmapData>;

	
	public static var goblin0:Array<BitmapData>;
	public static var goblin1:Array<BitmapData>;
	
	static public function load()
	{
		shieldArray = [];
		birdArray = [];
		eagleArray = [];
		tittle = [];

		particles = [];

		hero0 = [];
		hero1 = [];
		hero2 = [];

		goblin0 = [];
		goblin1 = [];
		
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
		
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle1.png"));//0
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle2.png"));//1
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle3.png"));//2
		eagleArray.push(Assets.getBitmapData("img/Enemys/eagle2.png"));//3
		
		tittle.push(Assets.getBitmapData("img/bush.png"));//0
		

		particles.push(Assets.getBitmapData("img/Particles/pero1.png"));//0

		hero0.push(Assets.getBitmapData("img/Hero/0.png")); //0
		hero1.push(Assets.getBitmapData("img/Hero/4.png")); 
		hero1.push(Assets.getBitmapData("img/Hero/4_1.png")); //4
		hero1.push(Assets.getBitmapData("img/Hero/4_2.png")); //4
		hero2.push(Assets.getBitmapData("img/Hero/7.png")); //4
		hero2.push(Assets.getBitmapData("img/Hero/7_1.png")); //4
		
		tittle.push(Assets.getBitmapData("img/fon4.png"));
		
		goblin0.push(Assets.getBitmapData("img/Enemys/gob1.png"));
		goblin0.push(Assets.getBitmapData("img/Enemys/gob2.png"));
		goblin1.push(Assets.getBitmapData("img/Enemys/gob3.png"));
	}
	
}
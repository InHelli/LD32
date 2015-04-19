package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.FPS;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
/**
 * ...
 * @author InHelli
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	static public var currentLevel:Level;
	static public var me:Main;
	public var scores:Int = 0;
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	public var startScreen:StartScreen;
	function init() 
	{
		if (inited) return;
		inited = true;
		me = this;
		startScreen = new StartScreen();
		addChild(startScreen);
		startScreen.addEventListener('start', onStart);
		// (your code here)
	
	
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	public function onFrame(e:Event) {
		if (Level.currentHero.health < 0) {
			onRestart();
		}
	}
	public function onStart (e:Event) {
		startScreen.visible =  false;
		//gameoverScreen.visible = false;
		startNewGame();
		addEventListener(Event.ENTER_FRAME, onFrame);
		
	}
	public function onRestart() {
		
		startScreen.visible = true;
		scores = Level.currentHero.scores;
		var scoresText = new TextField();
		var tft:TextFormat = new TextFormat('arial', 35, 0x00);
		scoresText.defaultTextFormat = tft;
		scoresText.width = 500;
		scoresText.height = 100;
		scoresText.x = 10;
		scoresText.y = 10;
		scoresText.autoSize = TextFieldAutoSize.CENTER;
		scoresText.textColor = 0x0000FF;
		scoresText.text = "Your scores: " + Std.string(scores);
		startScreen.addChild(scoresText);
		
		if (currentLevel != null) {
			removeChild(currentLevel);
			currentLevel = null;
		}
	}
	public function startNewGame() {
		if (currentLevel != null) {
			removeChild(currentLevel);
			currentLevel = null;
		}
		PictersSource.load();
		currentLevel = new Level();
		this.addChild(currentLevel);
		this.addChild(new FPS());
	}
	/* SETUP */

	
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}

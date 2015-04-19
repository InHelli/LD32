package ;
import openfl.Lib;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.events.KeyboardEvent;
import openfl.Assets;
import openfl.events.Event;
import openfl.media.SoundTransform;
import openfl.events.MouseEvent;

/**
 * ...
 * @author DrozdOFF
 */
class Audio
{
	
	static var snd_background:Sound = new Sound();
	static var snd_rikoshet:Sound = new Sound();
	static var snd_hit:Sound = new Sound();
	
	static var channel_rikoshet:SoundChannel;
	static var channel_background:SoundChannel;
	static var channel_hit:SoundChannel;

	public function new() 
	{
		
		snd_hit = Assets.getSound("sounds/hit.wav");
		snd_background = Assets.getSound("sounds/fon.mp3");
		snd_rikoshet = Assets.getSound("sounds/rikoshet.wav");
		
		
		
	}
	
	//------------plays-------------
	
	public function playFon(){

		channel_background = snd_background.play();
		channel_background.addEventListener(Event.SOUND_COMPLETE, eventRep);
		
		}
		
		function  eventRep(e:Event) {
			
		playFon();
		
		}
		
		static function  eventStop(e:Event){
 
		}
		
		public function stopFon() {
			
			channel_background.stop();
			channel_background.removeEventListener(Event.SOUND_COMPLETE, eventStop);

			}
		
			public static function playHit() {
			
			channel_hit = snd_hit.play();
			channel_hit.addEventListener(Event.SOUND_COMPLETE, stopHit);
			
			}
			
			public static function stopHit(e:Event) {
			
			channel_hit.stop();
			channel_hit.removeEventListener(Event.SOUND_COMPLETE, eventStop);
		
			}
		
			public static function playRicoshet() {
			
			channel_rikoshet = snd_hit.play();
			channel_rikoshet.addEventListener(Event.SOUND_COMPLETE, stopRicoshet);
			
			}
			
			public static function stopRicoshet(e:Event) {
			
			channel_rikoshet.stop();
			channel_rikoshet.removeEventListener(Event.SOUND_COMPLETE, eventStop);
		
			}
		
	
}
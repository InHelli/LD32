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
	
	var channel_rikoshet:SoundChannel;
	var channel_background:SoundChannel;
	var channel_hit:SoundChannel;

	public function new() 
	{
		
		snd_hit = Assets.getSound("sounds/hit.wav");
		snd_background = Assets.getSound("sounds/fon.mp3");
		snd_rikoshet = Assets.getSound("sounds/rikoshet.wav");
		
		
		
	}
	
	//------------plays-------------
	
	public static function playFon(){

		channel_background = snd_background.play();
		channel_background.addEventListener(Event.SOUND_COMPLETE, eventRep);
		
		}
		
		function eventRep(e:Event) {
			
		playFon();
		
		}
		
		function eventStop(e:Event){
 
		}
		
		public function stopFon() {
			
		channel_background.stop();
        channel_background.removeEventListener(Event.SOUND_COMPLETE, eventStop);

		}
		
		function playHit() {
			
			channel_hit = snd_hit.play(
			
			
			}
		
	
}
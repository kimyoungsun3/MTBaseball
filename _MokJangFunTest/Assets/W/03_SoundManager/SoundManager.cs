#define DEBUG_MODE_ON
#define DEBUG_MODE_ON2

using UnityEngine;
using System.Collections;

public enum Sound{
		BGM_MAIN = 0,			BGM_GAME01,			BGM_GAME02,
		MENU_SELECT, 			MENU_SUBSELECT,		MENU_CANCEL,		MENU_ERROR,
		GAME_BAT_WOOD, 			GAME_BAT_STEEL,		GAME_BAT_TUNA, 		GAME_BAT_GLASS,
		GAME_CATCH, 			GAME_HITFX01, 		GAME_HITFX02,
		GAME_COUNTDOWN, 		GAME_AUDIENCE, 		GAME_BONUS_POLE,
		GAME_PENALTY_ATTACK,	GAME_PENALTY_APPLY,
		RESULT_WIN,				RESULT_LOSE,
		RESULT_SHOWBAR,			RESULT_LEVELUP, 	RESULT_LEVELDOWN, 	RESULT_CARD,				RESULT_STAMP,		RESULT_SCORE,
		GAME_MACHINE_SHOW, 		GAME_MACHINE_SHOT, 	
		ITEM_BUY, 				ITEM_WEAR,			
		ITEM_UPGRADE_ING, 		ITEM_UPGRADE_SUCCESS, ITEM_UPGRADE_FAIL, 	
		CAPSULE_ING, 			CAPSULE_RESULT
};

public class SoundManager : MonoBehaviour {
	
	/*
	 * ***************************************
	 * 전체파일사이즈 : 18 MB
	 * ***************************************
	 * 101_BGM1_02, 102_BGM2_02, 103_win_02
	 * 3개mp3 파일을 설정(563K, 1500K, 1000K)
	 * ****************************************
	 * Stream from disc 			<=======
	 	> 55.59 MB 
	 	> 즉시 플레이됨.
	 * Compressed in memory		
		> 58.81 MB
		> 즉시 플레이됨.
	 * Decompress on load
	 	> 67.98 MB
	 	> 즉시 플레이됨.
	 *	
	 *
	 *************************************************
	 * wave 파일을 Native(wav), Load into memory
	 * 배트음은 Native, Load into memory(안건드린다.)
	 * 55.59M에서 시작.
	 * ************************************************
	 * Wave > Force to mono Checking
	 	> 41.92 MB
	 * Wave > Stream from disc		<=======
	 	> 34.89 MB
	 * Wave > Audio Format : Compressed(MPEG)
	 	> 36.21 MB 
	 	> 헐 늘어난다.(압축해제하는 메모리 공간때문에 늘언나듯).
	 	> 속도도 약간 늦고.
	 * */
	public const int SOUND_CHANNEL_COUNT = 4;
	public const int SOUND_BGM = 0;
	public const int SOUND_EFFECT1 = 1;
	public const int SOUND_EFFECT2 = 2;
	public const int SOUND_EFFECT3 = 3;
	
	private string[] sndName = {
		"bgm_main",				"bgm_game01",			"bgm_game02",
		"menu_select", 			"menu_subselect", 		"menu_cancel", 			"menu_error",
		"game_bat_wood", 		"game_bat_steel",		"game_bat_tuna", 		"game_bat_glass", 		
		"game_catch", 			"game_hitfx01", 		"game_hitfx02",
		"game2_countdown", 		"game2_audience", 		"game2_bonus_pole", 	
		"game2_penalty_attack",	"game2_penalty_apply",	
		"result_win",			"result_lose", 
		"result_showbar",		"result_levelup", 		"result_leveldown", 	"result_card", 		"result_stamp",		"result_score",
		"game2_machine_show", 	"game2_machine_shoot", 	
		"item_buy", 			"item_wear",			
		"item_upgrade_ing", 	"item_upgrade_success", "item_upgrade_fail", 	
		"capsule_ing", 			"capsule_result"
	};
	
	private int[] sndChannel = {
		SOUND_BGM,				SOUND_BGM,				SOUND_BGM,
		SOUND_EFFECT3, 			SOUND_EFFECT3, 			SOUND_EFFECT3, 		SOUND_EFFECT3,
		SOUND_EFFECT2, 			SOUND_EFFECT2,			SOUND_EFFECT2, 		SOUND_EFFECT2, 	
		SOUND_EFFECT2, 			SOUND_EFFECT2, 			SOUND_EFFECT2,
		SOUND_EFFECT1, 			SOUND_EFFECT1, 			SOUND_EFFECT2, 	
		SOUND_EFFECT3,			SOUND_EFFECT3,	
		SOUND_EFFECT1,			SOUND_EFFECT1,
		SOUND_EFFECT1,			SOUND_EFFECT1, 			SOUND_EFFECT1, 		SOUND_EFFECT1, 			SOUND_EFFECT1, 		SOUND_EFFECT1, 
		SOUND_EFFECT1, 			SOUND_EFFECT1, 	
		SOUND_EFFECT3, 			SOUND_EFFECT3,			
		SOUND_EFFECT3, 			SOUND_EFFECT3, 			SOUND_EFFECT3, 	
		SOUND_EFFECT3, 			SOUND_EFFECT3
	};
	
	private int sndCount;
	private AudioSource[]  audioPlayer = new AudioSource[SOUND_CHANNEL_COUNT]; 
	private AudioClip[] sndClips;
	private bool bIsPlaying;
	//private bool bSound = false;
	
	void Awake () {
		for(int i = 0 ; i < SOUND_CHANNEL_COUNT ; i++){ 
			audioPlayer[i] = gameObject.AddComponent("AudioSource") as AudioSource; 
		}
	}
	
	void Start(){
		//나중에 실행에서 초기화 해주자.
		init();
	}
	
	void init(){
		sndCount = sndName.Length;
		sndClips = new AudioClip[sndCount];
		for(int i = 0 ; i < sndCount ; i++){ 
			sndClips[i] = Resources.Load("sound/" + sndName[i], typeof(AudioClip)) as AudioClip; 
		}	
		
		//if(GameData.bSound){
		//	bIsPlaying = true;
		//}else{
		//	bIsPlaying = false;
		//}
	}
	
	#if DEBUG_MODE_ON
	void OnGUI(){
		string _str = "sound:";
		int _px = 10, _py = 10, _dx = 150, _dy = 60;
		Rect _rl;
		
		_rl = new Rect(_px, _py, Screen.width - _px*2, _dy);
		if(GUI.Button(_rl, _str)){
			stopAll();
		}
		
		for(int i = 0; i < sndCount; i++){
			_str = sndName[i];
			if(i != 0 && i % 7 == 0){
				_px += _dx;
				_py = 10 + _dy; 
			}else{
				_py += _dy;
			}
			_rl = new Rect(_px, _py, _dx, _dy);			
			if(GUI.Button(_rl, _str)){
				play(i);
			}
		}	
	}
	#endif
	
	//배트음악.
	public void playBat(Sound _idx, int _kind){
		#if DEBUG_MODE_ON2
			Debug.Log("SoundManager playBat:" + _idx);
		#endif
		int _batKind = (int)_idx + _kind;
		play(_batKind);
	}
	
	//일반적인 사운드 음악.
	public void play(Sound _idx){
		#if DEBUG_MODE_ON2
			Debug.Log("SoundManager play:" + _idx);
		#endif
		
		play((int)_idx);
	}
	
	public void play(Sound _idx, int _branch){
		#if DEBUG_MODE_ON2
			Debug.Log("SoundManager play(" + _branch + "):" + _idx);
		#endif
		
		play((int)_idx);
	}
	
	//게임중 BGM를 사용하고 싶을때.
	public void playGame(Sound _idx){
		#if DEBUG_MODE_ON2
			Debug.Log("SoundManager playGame:" + _idx);
		#endif
		
		int _kind = (int)_idx;
		if(_idx == Sound.BGM_GAME01){
			_kind += Random.Range(0, 2);
		}		
		play(_kind);
	}
	
	public void playGame(Sound _idx, int _branch){
		#if DEBUG_MODE_ON2
			Debug.Log("SoundManager playGame(" + _branch + "):" + _idx);
		#endif
		
		int _kind = (int)_idx;
		if(_idx == Sound.BGM_GAME01){
			_kind += Random.Range(0, 2);
		}		
		play(_kind);
	}
	
	////////////////////////////////////////////////////////////
	void play(int _idx){
		//if(!bSound){
		//	#if DEBUG_MODE_ON2
		//		Debug.Log(" > bSound reject:" + bSound);
		//	#endif
		//	return;
		//}
		
		int _channel = sndChannel[_idx];
		//if(!bIsPlaying){
		//	//pass.
		//}else if(audioPlayer[_channel].clip == sndClips[_idx] && audioPlayer[_channel].loop){
		//	#if DEBUG_MODE_ON2
		//		Debug.Log(" > same loop sound reject _idx:" + _idx);
		//	#endif
		//	return;
		//}
		
		audioPlayer[_channel].clip = sndClips[_idx];
		if(_channel == SOUND_BGM)
			audioPlayer[_channel].loop = true;
		else
			audioPlayer[_channel].loop = false;
		audioPlayer[_channel].Play();
		
		bIsPlaying = true;
	}
	
	public AudioClip getSound(Sound _idx){
		return sndClips[(int)_idx];
	}
	
	public AudioClip getSound(int _idx){
		return sndClips[_idx];
	}
	
	/// <summary>
	/// 전부사운드를 멈추고 싶을때.
	/// </summary>
	public void stopAll(){
		for(int i = 0; i < SOUND_CHANNEL_COUNT; i++){
			stop(i);
		}
		bIsPlaying = false;
	}
	
	void stop(int _channel) { 
        audioPlayer[_channel].Stop(); 
    } 
	
	/// 특정 사운드의 볼륨을 낮추고 싶을때.
	/// 사운드 채널, 사운드볼륨값(0 ~ 1).
	public void setVolume(int _channel, float _volume ) { 
   		audioPlayer[_channel].volume = _volume; 
	}
	
	//1 -> 커지면빨라짐.
	//1 -> 밑으로가면 느려짐.
	public void setPitch(float _pitch){
		audioPlayer[SOUND_BGM].pitch = _pitch;
	}
	
	//public void setPitch(int _channel, float _pitch){
	//	audioPlayer[_channel].pitch = _pitch;
	//}
}


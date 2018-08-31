using UnityEngine;
using System.Collections;

// Make sure we have gui texture and audio source
//@script RequireComponent (GUITexture)
//@script RequireComponent (AudioSource)
		



public class WebMovie2 : MonoBehaviour {
	string url = "http://www.unity3d.com/webplayers/Movie/sample.ogg";
	// Use this for initialization
	#if UNITY_EDITOR	
	IEnumerator Start () {
	    // Start download
	    WWW www = new WWW(url);
		
		//http://docs.unity3d.com/Documentation/Manual/VideoFiles.html
		Debug.Log("Only PC, WebPlayer Mobile Not Support");
	    // Make sure the movie is ready to start before we start playing
		MovieTexture movieTexture = www.movie;
	    while (!movieTexture.isReadyToPlay)
	        yield return www;
	        
	    // Initialize gui texture to be 1:1 resolution centered on screen
	    guiTexture.texture = movieTexture;
	
	    transform.localScale = new Vector3 (0,0,0);
	    transform.position = new Vector3 (0.5f,0.5f,0f);
		guiTexture.pixelInset = new Rect(-movieTexture.width*0.5f, -movieTexture.height*0.5f, movieTexture.width*0.5f, movieTexture.height*0.5f);
	    //guiTexture.pixelInset.xMin = -movieTexture.width / 2.0f;
	    //guiTexture.pixelInset.xMax = movieTexture.width / 2.0f;
	    //guiTexture.pixelInset.yMin = -movieTexture.height / 2.0f;
	    //guiTexture.pixelInset.yMax = movieTexture.height / 2.0f;
	
	    // Assign clip to audio source
	    // Sync playback with audio
	    audio.clip = movieTexture.audioClip;
	
	    // Play both movie & sound
	    movieTexture.Play();
	    audio.Play();
	    /**/
	}
	#endif	
}

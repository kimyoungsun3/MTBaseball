using UnityEngine;
using System.Collections;

public class AppQuit : MonoBehaviour {

	void Update(){
		if (Input.GetKeyDown (KeyCode.Escape)){
    		Application.Quit();
		}
	}
}

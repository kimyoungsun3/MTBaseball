using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace StaticClass{
	public class GameManager : MonoBehaviour {
		GameData aa;
		void Start(){
			aa = new GameData ();
		}
		
		
		// Update is called once per frame
		void Update () {
			if (Input.GetKeyDown (KeyCode.Alpha1)) {
				GameData.exp -= 10;
			} else if (Input.GetKeyDown (KeyCode.Alpha2)) {
				GameData.exp += 1000;
			}

			Debug.Log (GameData.exp + " > " + GameData.level);
		}
	}
}

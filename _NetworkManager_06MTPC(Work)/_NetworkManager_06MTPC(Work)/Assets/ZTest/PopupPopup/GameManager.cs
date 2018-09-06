using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PopupPopup{
	public class GameManager : MonoBehaviour {

		public GameObject go;
		public GameObject go2;
		public GameObject go3;

		void Start () {
			go.SetActive (true);
			go2.SetActive (false);
			go3.SetActive (false);
			StartCoroutine (Flow ());	
		}

		IEnumerator Flow(){
			bool bWait = true;

			//-----------------------
			// Notice 1
			//-----------------------
			T2 _t = go.GetComponent<T2> ();
			_t.InvokeT2 (delegate() {

				Debug.Log (4);
				bWait = false;
				go.SetActive (false);	
				go2.SetActive (true);
				Debug.Log(this + " ok click > 1(off), 2(ON)");
			});


			while (bWait) {
				Debug.Log (" > 1. wait");
				yield return null;
			}

			//-----------------------
			// Notice 2
			//-----------------------
			_t = go2.GetComponent<T2> ();
			_t.InvokeT2 (delegate() {
				bWait = false;
				go2.SetActive (false);	
				go3.SetActive (true);
				Debug.Log(this + " ok click > 2(off), 3(ON)");
			});


			while (bWait) {
				Debug.Log (" > 2. wait");
				yield return null;
			}

			//-----------------------
			// Notice 3
			//-----------------------
			_t = go3.GetComponent<T2> ();
			_t.InvokeT2 (delegate() {
				bWait = false;
				go3.SetActive (false);
				Debug.Log(this + " ok click > 3(off)");
			});


			while (bWait) {
				Debug.Log (" > 3. wait");
				yield return null;
			}


			Debug.Log (" > 4. go~~~~");
		}

	}
}

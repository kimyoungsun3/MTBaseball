using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace PopupPopup{
	public delegate void VOID_FUN_VOID();

	public class T2 : MonoBehaviour {
		VOID_FUN_VOID onFinished;

		public void InvokeT2(VOID_FUN_VOID _on){
			Debug.Log (2 + ":" + _on);
			onFinished = _on;
			Debug.Log (2 + ":" + onFinished);
		}

		void OnMouseDown() {
			Debug.Log (3 + ":" + onFinished);
			//Application.LoadLevel("SomeLevel");
			if (onFinished != null) {
				onFinished ();
				onFinished = null;
			}
		}
	}
}

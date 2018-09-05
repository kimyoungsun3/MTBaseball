using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace LevelTest{
	public class LevelTest : MonoBehaviour {

		int i = 0;
		int iMax = 500000;
		int level = -1;
		void Update () {
			
			for (int j = 0; j < 100; j++, i++) {
				int l = GetLevel (i);
				if (level != l) {
					Debug.Log (i + " > " + l);
				}
				level = l;
			}
		}

		int GetLevel(int _exp){
			return (int)(Mathf.Sqrt ((_exp - 1) / 100f + 1521 / 4f) - 39 / 2f) + 1;
			//ROUNDUP(SQRT(1000000/100+1521/4)-39/2,0)

		}
	}

}
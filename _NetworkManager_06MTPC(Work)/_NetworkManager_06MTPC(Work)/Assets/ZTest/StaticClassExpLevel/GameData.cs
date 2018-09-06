using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace StaticClass{
	public class GameData {
		
		#region UserData level, exp
		/*
		public static int exp_;
		public static int exp { 
			set{
				exp_ = value;
				if (exp_ < 0)
					exp_ = 0;
			}

			get{
				return exp_;
			} 
		}
		*/
		public static int exp;
		public static int level {
			get {			
				return (int)(Mathf.Sqrt ((exp - 1) / 100f + 1521 / 4f) - 39 / 2f) + 1;
			}
		}
		#endregion
	}
}
using UnityEngine;
using System.Collections;
using System;

public class TimeFlow2 : MonoBehaviour {
	int count = 0;
	
	private string startDate = "2012-10-22 10:00"; 
	DateTime startDateTime;
	DateTime curDateTime;
	TimeSpan timeSpan;
	long STAMINA_LIMIT_TIME = 10;//60 * 5;
	
	void Start () {
	}	
	void Update () {}
	void OnGUI(){
		startDateTime 	= DateTime.Parse(startDate); 
		curDateTime 	= DateTime.Now; 
		timeSpan 		= curDateTime - startDateTime; 		
		string _s 		= timeSpan.ToString().Substring(3, 5);
		
		GUI.Button(new Rect(310, 10, 200, 50), count + " : " + _s );
		//Debug.Log("s:" + startDateTime 
		//         + " c:" + curDateTime
		//          + " p1:" + timeSpan.TotalSeconds
		//          + " p2:" + timeSpan.Milliseconds
		//         + " p3:" + timeSpan.Seconds
		//          + " p4:" + timeSpan.TotalSeconds);
		
		if(timeSpan.Seconds > STAMINA_LIMIT_TIME){
			startDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
			count += 1;
			Debug.Log(" new setting");
		}
	}
}
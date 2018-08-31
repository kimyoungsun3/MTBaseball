using UnityEngine;
using System.Collections;
using System;

public class TimeFlow : MonoBehaviour {
	
	//아이콘을 클릭했을 때 04시:59분:59초 부터시작하여 .
	//00시:00분:00초에 도달 할때 까지 GUIText에 초단위로 
	//시간을 현시하는프로그램 작성중인데 아직 초보라 잘 안되네요...
	//sting theTime = System.DateTime.Now.ToString("hh:mm:ss"); 
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	void OnGUI(){
		
		//1. 시간차 구하기.
		//using System;
		string theTime = DateTime.Now.ToString("hh:mm:ss"); 
		GUI.Button(new Rect(10, 10, 200, 50), theTime);
		// 2012-10-12 오후 4:11:10 > 04:11:10
		
		//2. 시간차 구하기.
		string SDate = "2008-01-01"; 
		string EDate = "2009-11-17"; 
		DateTime T1 = DateTime.Parse(SDate); 
        DateTime T2 = DateTime.Parse(EDate); 
        TimeSpan TS = T2 - T1; 
        //int diffDay = TS.Days;  //날짜의 차이 구하기.
		//Debug.Log("xx0:");
		//Debug.Log("xx1:" + TS.ToString());	//xx1:686.00:00:00
		//Debug.Log("xx2:" + TS.Days);			//xx2:686
		//Debug.Log("xx3:");
		GUI.Button(new Rect(10, 110, 200, 50), TS.ToString());

		
		//3. 시간차 구하기.
		string startDate = "2012-12-07 10:15"; 
		T1 = DateTime.Parse(startDate); 
		T2 = DateTime.Now; 
		//TS = T1 - T2; 
		TS = T2 - T1; 
		//string _s = TS.ToString().Substring(0, 8);
		string _s = TS.ToString().Substring(3, 5);
		GUI.Button(new Rect(10, 210, 200, 50), TS.ToString());
		GUI.Button(new Rect(10, 310, 200, 50), _s);
		//GUI.Button(new Rect(10, 310, 200, 50), TS.TotalHours + ":" + TS.TotalMinutes + ":" + TS.TotalSeconds);
		
		
		//4. 시간의 고유값.
		GUI.Button(new Rect(10, 250, 200, 50), (DateTime.Now.Ticks).ToString());
		
		/*
		//3-2.		 * 
		//0. 기준날짜
		//결과 : 2011-04-20 오전 1:48:03
		DateTime dateToday = DateTime.Today;
		 
		//1. 이번달 1일 날짜를 가져오는 방법
		//결과 : 2011-04-01 오전 1:48:03
		DateTime dtFirstDay = dateToday.AddDays(1 - dateToday.Day);
		 
		//2. 요번달 마지막날짜
		//결과 : 2011-04-30 오전 1:48:03
		DateTime dtMonthLastDay = dateTodayAddMonths(1).AddDays(0 - dateTodayDay);
		 
		//3. 요번주의 일요일 날짜
		//결과 : 2011-04-17 오전 1:48:03
		DateTime dtWeekFirstSunday = first_day.AddDays(0 - (int)(first_day.DayOfWeek));
		 
		//4. 요번주의 남은 날짜(오늘포함)
		//결과 : 4
		int intWeekLeftDayCount = 7 - (int)(first_day.DayOfWeek);
		 
		//5. 요번달의 첫일요일
		//결과 : 2011-03-27 오전 1:48:03
		DateTime dtMonthFirstSunday = dtFirstDay.AddDays(0 - (int)(dtFirstDay.DayOfWeek));
		 
		//6. 마지막 주의 일요일을 가져오는 방법
		//결과 : 2011-04-24 오전 1:48:03
		DateTime dtLastSunday = dtMonthLastDay.AddDays(0 - (int)(dtMonthLastDay.DayOfWeek));
		 
		//7. 마지막 주의 일수를 가져오는 방법
		//결과 : 7
		int intLastWeekDayCount = dtMonthLastDay.DayOfYear - dtLastSunday.DayOfYear + 1;
		 
		//8. 이번 달의 주수를 가져오는 방법
		//결과 : 5
		int intMonthWeekCount = ((last_sunday.DayOfYear - first_sunday.DayOfYear) / 7) + 1;
		 
		//9. 오늘의 요일
		//결과 : Wednesday
		string strNow_DayOfWeek = dateToday.DayOfWeek;
		 
		//10. 영어날짜
		//결과 : Tuesday April 4/19/2011 04:48:03 2011
		string strNowEng = String.Format(new System.Globalization.CultureInfo("en-US"), "{0:dddddddddd} {0:MMMMMMMM} {0:d} {0:hh}:{0:mm}:{0:ss} {0:yyyy}", dateToday.ToUniversalTime());
		 
		//11. 요번주의 원하는 요일의 날짜 구하기(여기서는 금요일)
		//결과 : 2011-04-22 오전 1:48:03
		DateTime fridayDate = dateToday.AddDays(Convert.ToInt32(DayOfWeek.Friday) - Convert.ToInt32(NowDate.DayOfWeek));
		/**/         
		           
		
		//4.
		//DateTime "2012-10-13 17:10"
		//씬이 읽어진 후의 지나간 시간.
		//Debug.Log(Time.timeSinceLevelLoad.ToString());
		
		/*
		//5.
		int window = 10;
        int freq = 60 * 60 * 2; // 2 hours;
        DateTime d1 = DateTime.Now;

        DateTime d2 = d1.AddSeconds(2 * window);
        DateTime d3 = d1.AddSeconds(-2 * window);
        DateTime d4 = d1.AddSeconds(window / 2);
        DateTime d5 = d1.AddSeconds(-window / 2);

        DateTime d6 = (d1.AddHours(2)).AddSeconds(2 * window);
        DateTime d7 = (d1.AddHours(2)).AddSeconds(-2 * window);
        DateTime d8 = (d1.AddHours(2)).AddSeconds(window / 2);
        DateTime d9 = (d1.AddHours(2)).AddSeconds(-window / 2);
		Debug.Log("d1 ~= d1 [true]: " + RoughlyEquals(d1, d1, window, freq));
        Debug.Log("d1 ~= d2 [false]: " + RoughlyEquals(d1, d2, window, freq));
        Debug.Log("d1 ~= d3 [false]: " + RoughlyEquals(d1, d3, window, freq));
        Debug.Log("d1 ~= d4 [true]: " + RoughlyEquals(d1, d4, window, freq));
        Debug.Log("d1 ~= d5 [true]: " + RoughlyEquals(d1, d5, window, freq));

        Debug.Log("d1 ~= d6 [false]: " + RoughlyEquals(d1, d6, window, freq));
        Debug.Log("d1 ~= d7 [false]: " + RoughlyEquals(d1, d7, window, freq));
        Debug.Log("d1 ~= d8 [true]: " + RoughlyEquals(d1, d8, window, freq));
        Debug.Log("d1 ~= d9 [true]: " + RoughlyEquals(d1, d9, window, freq));
        /**/
		
		
		//date = System.DateTime.Now.ToString("MM/dd/yyyy");
		//month = System.DateTime.Now.get_Month();
		//day = System.DateTime.Now.get_Day();
		//year = System.DateTime.Now.get_Year();
				
		//currentSeconds = parseInt(System.DateTime.Now.ToString("ss"))
		//currentMinutes = parseInt(System.DateTime.Now.ToString("mm"));
		//currentHours = parseInt(System.DateTime.Now.ToString("hh"));
		//DayNightSystem = currentHours*3600 + currentMinutes*60 + currentSeconds;
		//Rot = DayNightSystem/240;
		//transform.eulerAngles.z = Rot;
		//print(DayNightSystem);
	}
	
	/*
	bool RoughlyEquals(DateTime time, DateTime timeWithWindow, int windowInSeconds, int frequencyInSeconds)
	{

            long delta = (long)((TimeSpan)(timeWithWindow - time)).TotalSeconds % frequencyInSeconds;

            delta = delta > windowInSeconds ? frequencyInSeconds - delta : delta;

            return Math.Abs(delta) < windowInSeconds;

	}
	/**/
}


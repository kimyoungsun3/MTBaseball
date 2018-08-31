using UnityEngine;
using System.Collections;

public class GradeExp : MonoBehaviour {
	
	//레벨 : 총경험치 > 레벨.
	//등급(그레이드) : 총경험치 > 그레이드, 별.
	int gradeExp, 
		grade, gradeOld,
		gradeStar, gradeStarOld;
	int lvexp, lv, lvexpInterMax, lvexpInter;
	
	void Start(){
		initGradeLV();
	}
	
	/// <summary>
	/// Grade 초기화.
	/// </summary>
	public void initGradeLV(){
		gradeExp = 2;
		grade = 1;
		gradeStar = 2;
		
		lv = 1;
		lvexp = 0;
	}
	
	
	/// <summary>
	/// Grade +1, +2, -1.
	/// </summary>
	/// <param name="_exp">
	/// A <see cref="System.Int32"/>
	/// </param>
	public void addGradeExp(int _exp){
		//1. 전의 그레이드와 별을 백업.
		gradeOld = grade;
		gradeStarOld = gradeStar;
		
		if(_exp < 0){
			if(grade == 10 && gradeStar == 0){
				_exp = 0;
				return;
			}
		}
		
		//2. 경험치 누적.
		gradeExp = gradeExp + _exp;		
		grade = gradeExp / 6 + 1;
		gradeStar = gradeExp % 6;
		
		//3. +1, +2 > 승급관리.
		if(gradeExp < 0){
			gradeExp = 0;
			grade = 1;
			gradeStar = 0;
		}else if(grade > 50){
			grade = 50;
			gradeStar = 5;
			gradeExp = grade * 6 - 1;
		}else if(_exp > 0){
			if(grade != gradeOld || gradeStar == 5){
				//gradeOld = ;
				gradeStarOld = 5;
				
				gradeExp = 6 * gradeOld + 2;
				grade = gradeExp / 6 + 1;
				gradeStar = gradeExp % 6;
			}
		}else if(_exp < 0){
			//-1 > 승하관리, 0이하로는 안내려감.
			if(grade != gradeOld){
				gradeExp = 6 * (grade - 1) + 2;
				if(gradeExp < 0)gradeExp = 0;
				grade = gradeExp / 6 + 1;
				gradeStar = gradeExp % 6;
			}
		}			
	}
		
	public int getGradeExp(){ 		return gradeExp; 	}		
	public int getGrade(){			return grade;		}
	public int getGradeStar(){		return gradeStar;	}	
	public int getGradeOld(){		return gradeOld;	}
	public int getGradeStarOld(){	return gradeStarOld;}
	
	public bool addLV(int _exp){
		bool _bLvUP = false;
		int _LVMAX = 50;
		
		//경험치는 지급5, 
		if(_exp > 5)_exp = 5;
		if(lvexp  + _exp < 0){
			//정수범위 초과.
			lvexp = 0x7FFFFFFF;
		}else{
			lvexp += _exp;
		}
		
		//레벨 경험치 계산하기.
		_exp = 0;
		int _lv = 1, _exp2 = 0;
		for(; _lv <= _LVMAX; ++_lv){
			_exp += (int)(_lv*4.5f) + 10;			
			if(lvexp < _exp && lvexp >= _exp2){
				//Debug.Log(_lv+":"+_exp);
				break;
			}else if(_lv + 1 > _LVMAX){
				_lv++;
				break;
			}
			_exp2 = _exp;
		}
		if(_lv <= _LVMAX){
			lvexpInterMax = _exp - _exp2;
			lvexpInter = lvexp - _exp2;
			lvexpInter++;
			if(lvexpInter < 0)lvexpInter = lvexpInterMax;
		}else{
			_lv = _LVMAX;
			lvexpInterMax = _exp - _exp2;
			lvexpInter = lvexpInterMax;
		}
			
		
		//레벨업과 레벨 정리하기.
		if(lv != _lv){
			_bLvUP = true;
		}
		lv = _lv;
		return _bLvUP;
	}
	
	/// <summary>
	/// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/// </summary>
	
	void OnGUI(){
		string _msg;
		int _px = 10, _py = 10;
		int _dx = 100, _dy = 40;		
		
		Rect _r = new Rect(_px, _py, _dx, _dy);	
		if(GUI.Button(_r, "gradeexp:-1"))addGradeExp(-1);
		
		_r = new Rect(_px + _dx, _py, _dx, _dy);	
		if(GUI.Button(_r, "+1"))addGradeExp(+1);
		
		_r = new Rect(_px + _dx*2, _py, _dx, _dy);	
		if(GUI.Button(_r, "+2"))addGradeExp(+2);
		
		//그레이드와 스타을 알고 싶을때.
		_r = new Rect(_px + _dx*3, _py, _dx, _dy);	
		if(GUI.Button(_r, "0"))addGradeExp(0);
		
		
		_r = new Rect(_px, _py + _dy, _dx + 200, _dy);	
		_msg = "old  " + getGradeOld() + " " + getGradeStarOld();
		GUI.Button(_r, _msg);
		
		_r = new Rect(_px, _py + _dy*2, _dx + 200, _dy);	
		_msg = "new " + getGradeExp() + ", " + getGrade() + ", " + getGradeStar();
		GUI.Button(_r, _msg);
	}
	
	
	void Update(){
		int _lvOld = lv;
		int _lvexpOld = lvexp;		
		bool _lvUP = addLV(1);
		Debug.Log("LVUP:" + _lvUP + " lvexp:" + _lvexpOld + " -> " + lvexp + ", LV:" + _lvOld + " -> " + lv + ", " + lvexpInter + "/" + lvexpInterMax);
	}
		
}

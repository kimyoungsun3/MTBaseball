public class PowerData {
	int curTurnTime;		//회차...
	int passTime;			//지난시간.

	int curTurnNum1;
	int curTurnNum2;
	int curTurnNum3;
	int curTurnNum4;
	int curTurnNum5;
	int curTurnNum6;

	public void display(){
		System.out.println(" =====================================================");
		System.out.println(
			" 회차:" + curTurnTime
			+ " 지난시간:" + passTime
			+ " ba11:" + curTurnNum1
					   + "/" + curTurnNum2
					   + "/" + curTurnNum3
					   + "/" + curTurnNum4
					   + "/" + curTurnNum5
			+ " 파워:" + curTurnNum6
		);
		System.out.println(" =====================================================");
	}
}

public class PowerData {
	int curTurnTime;		//ȸ��...
	int passTime;			//�����ð�.

	int curTurnNum1;
	int curTurnNum2;
	int curTurnNum3;
	int curTurnNum4;
	int curTurnNum5;
	int curTurnNum6;

	public void display(){
		System.out.println(" =====================================================");
		System.out.println(
			" ȸ��:" + curTurnTime
			+ " �����ð�:" + passTime
			+ " ba11:" + curTurnNum1
					   + "/" + curTurnNum2
					   + "/" + curTurnNum3
					   + "/" + curTurnNum4
					   + "/" + curTurnNum5
			+ " �Ŀ�:" + curTurnNum6
		);
		System.out.println(" =====================================================");
	}
}

////implicitly 컴파일러는 (Double, Double) 타입의 tuple 생성
////let tipAndTotal = (4.00, 25.19)
//
////explicitly 선언도 가ㅏ능
//let tipAndTotal: (Double, Double) = (4.00, 25.19)
//
////unname Tuple 요소를 접근하는 두가지 방법 중에서 첫번째 인덱스
//tipAndTotal.0
//tipAndTotal.1
//
////unnamed Tutple 요소를 접근하는 두가지 방법 중에서 두번쨰 이름으로 decompose
//let (theTipAmt, theTotal) = tipAndTotal
//theTipAmt
//theTotal
//
////unnamed Tuple과 달리 Named Tutple은 각 요소의 name 지정
//let tipAndTotalNamed = (TipAmt:4.00, total:25.19)
//tipAndTotalNamed.TipAmt
//tipAndTotalNamed.total
//
////let tipAndTotalNamed = (TipAmt:4.00, total:25.19)
////named Tutple의 Explicit syntax를 원하면
//let tipAndTotalNamed2: (tipAmt:Double, total:Double) = (4.00, 25.19)
//
//
//
////tuple을 변환하는 메소드 작성
//let total = 21.19
//let taxPct = 0.06
//let subtotal = total / (taxPct + 1)
//func calcTipWithTipPct(tipPct:Double)->(tipAmt:Double, total:Double){
//    let tipAmt = subtotal * tipPct
//    let finalTotal = total + tipAmt
//    return (tipAmt, finalTotal)
//}
//calcTipWithTipPct(tipPct: 0.20)

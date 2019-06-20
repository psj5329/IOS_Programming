import UIKit

let swiftteam = 13
//타입을 지정 Explicit Type
let IOSteam : Int = 54
let otherTeams = 48
var totalTeam = swiftteam + IOSteam + otherTeams

//totalTeam은 상수로(let) 정의했기 때문에 에러
totalTeam += 1

//swift compiler는 타입을 추론해서 Inferred Type Int로 결정
let swiftTeam = 13

//swift compiler는 실수는 default로 Double로 결정
//실수는 Float 혹은 Double type 가질 수 있음
let priceInferred = 19.99
let priceExplicit : Double = 19.99

//Boolean 타입은 true / false를 가짐
let onSaleInferred = true
let onSaleExplicit : Bool = false

//String 타입
let nameInferred = "박수정"
let nameExplicit : String = "강민경"

//Strinf interpolation : 큰 따옴표 안에 변수 값을 함께 쓸 수 있음
if onSaleInferred {
    print("\(nameInferred) on sale for \(priceInferred)")
} else{
    print("\(nameInferred) at regular price : \(priceInferred)")
}

import Foundation
//1.UITableView 클래스 사용하기 위해서
import UIKit

//2. UITableViewDataSource를 구형하기 위해서 NSObject 상소ㄱ받아야함
//추가로 UITableViewDataSource를 따른다고 선언(2가지 메소드 구현해야 함)
class TestDataSource: NSObject, UITableViewDataSource{
    //3.TipCalculatorModel 클래스를 인스턴스 생성하고 가능한 팁과 토탈을 가지는 빈 딕셔너리와 정렬된 키 배열 생성
    let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
    var possibleTips = [Int: (tipAmt:Double, total:Double)]()
    //딕셔너리를 아래와 같이 선언할 수도 있음
    var sortedKeys:[Int] = []
    
    //4. NSObject init()을 override, possibleTips 딕셔너리 키를 추출한 후 정렬함
    override init(){
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sorted()
        super.init()
    }
    
    //UITableViewDataSource르 위하 첫번째 메소드: TableView Section은 몇개의 row를 가지는가?
    //이 TableView는 한개의 Section을 가지며 row의 개수는 sortedKeys배열 원소 개수 = 즉 팁 딕셔너리 키의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    //두번째 메소드는 각 row에 대해서 호출되며 UITableViewCell의 서브 클래스로써
    //각 row를 표현하는 UITableViewCell을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //2.빌트인 스타일의 table view cell을 생성하거나 custom스타일 cell을 생성할 수 있다
        //여기서는 디폴트 스타일에서 UITableViewCellStyle.value2를 선택
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: nil)
        
        //3.indexPath = TableView의 (Section, row) 튜플을 나타냄
        //여기서는 Section이 한개고 row는 sortedKeys 배열 원소 개수만큼 만들엇음
        //즉 indexPath.row는 0, 1, 2를 가지며 sortedKeys 배열에서 해당하는 tip percentage를 얻음
        let tipPct = sortedKeys[indexPath.row]
        
        //4.possibleTips 딕셔너리는 key(tipPct)에 대한 value가 tuple(tipAmt, total)임
        //딕셔너리에 key를 주고 value를 추출할 때 optional을 사용(해당 key에 대한 value가 없을 수 있음)
        //여기서는 value가 있으리라 확신하므로 !(implicitly unwrapped)를 사용
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        
        //5.빌트인 UITableViewCell value2 스타일은 2가지 subtotal: textLabel, detailTextLabel이 필요
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, total: $%0.2f", tipAmt, total)
        return cell
    }
}
//원래는 위 지우고 다시
//Tip Calculation 클래스 선언
class TipCalculator{
    //상수 선언 : Error
    let total: Double       //post-tax total
    let taxPct: Double      //tax percentage
    let subtotal: Double    //pre-tax subtotal
    
    //class property는 선언할 떄 혹은 initailizer에서 초기값을 지정해야 함
    //초기값을 가지지 않기 위해서는 optional로 선언해야 함
    init(total: Double, taxPct: Double){
        self.total = total
        self.taxPct = taxPct
        subtotal = total / (taxPct + 1)
    }
    
    //tip 계산 함수: tip은 pre-tax subtotal에서 계산해야 함
    func calcTipWithTipPct(tipPct: Double)->Double{
        return subtotal * tipPct
    }
    
    //Dictionary (key/value 쌍을 갖는 자료구조)를 반환하는 함수
    func returnPossibleTips()->[Int: Double]{
        //Inferred array 팁 퍼센트 배열 선언
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        
        //빈 Dictionary 변수 선언
        var retval = [Int: Double]()
        
        //for 루프에서 3개 팁 퍼센트에 대한 팁을 계산하고 Dictionary에 추가
        for possibleTip in possibleTipsInferred{
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(tipPct: possibleTip)
        }
        return retval
    }
    
    /*
    //15% 18% 20%팁을 포함한 가격을 리스트 프린트하는 함수
    //array와 for 루프를 이용해서 다시 작성
    func printPossibleTips(){
        //Inferred와 Explicit array 변수 선언
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit: [Double] = [0.15, 0.18, 0.20]
        
        //for 루프 : possibletipsInferred 배열에서 하나씩 꺼내서 루프 실행
        for possibleTip in possibleTipsInferred{
            print("\(possibleTip * 100)%: \(calcTipWithTipPct(tipPct: possibleTip))")
        }
        
        //다른 스타일의 for 루프
        //..< 연산자는 상한은 포함 안함 반면에 ...연산자는 상한 포함
        //배열의 원소 개수 연산자: .count, 배열 원소 추출 연산자: [index]
        for i in 0..<possibleTipsExplicit.count{
            let possibleTip = possibleTipsExplicit[i]
            print("\(possibleTip * 100)%: \(calcTipWithTipPct(tipPct: possibleTip))")
        }
        
        //print("15% : \(calcTipWithTipPct(tipPct: 0.15))")
        //print("18% : \(calcTipWithTipPct(tipPct: 0.18))")
        //print("20% : \(calcTipWithTipPct(tipPct: 0.10))")
    }*/
}

//클랫 바깥에 인스턴스 생성 및 멤버함수 호출
//래스토랑 계산서 total이 팁을 포함하지 않고 tax만 포함한 것임
//팁은 따로 subtotal(tax 포함하지 않는)에서 15~20%정도 계산해서 테이블 위에 두고온다고 가정
let tipCalc = TipCalculator(total: 33.25, taxPct: 0.06)
//tipCalc.printPossibleTips()
tipCalc.returnPossibleTips()

//테스트 코드 : 하드코딩으로 적당한 크기의 tableView 생성하고 이것의 dataSource는 방금 만든 클래스로 설정
let testDataSource = TestDataSource()
let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 320), style: .plain)
tableView.dataSource = testDataSource
//reloadData() 메소드 호출은 tableView를 refresh함
tableView.reloadData()

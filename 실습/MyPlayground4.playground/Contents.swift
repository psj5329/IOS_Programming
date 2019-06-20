import UIKit
import Foundation   //optional 프로토콜 사용하려면 필요

//아래 protocol은 Speak 메소드 하나를 가진다
//optional 메소드를 가지는 프로토콜은 @objc를 붙여야함
@objc protocol Speaker{
    func Speak()
    //optional 메소드는 optional 태그를 붙ㅌ여야함
    @objc optional func Telljoke()
}

//Speaker protocol을 따르는 (conform) 클래스는 Speak 메소드를 구현해야함
//Java의 abstract class 혹은 interface와 유사
// Telljoke() 메소드를 구현하지 않아도 compile Error 안생김, optional 메소드라서
class Vicki: Speaker{
    func Speak() {
        print("Hello, I am Vicki")
    }
    func Telljoke(){
        print("Q: What did Sushi A say to Sushi B?")
    }
}

class Ray: Speaker{
    func Speak() {
        print("Yo, I am Ray")
    }
    func Telljoke(){
        print("Q: What's the object-oriented way to become wealthy?")
    }
    //프로토콜에 없는 자신만의 메소드 구현 가능
    func WriteTutorial(){
        print("I'm on it!")
    }
}

//클래스 name : 다음에 상속하는 부모 클래스 1개와 따르는 protocol 여러 개를 선언할 수 있음
class Animal{
    
}

class Dog : Animal, Speaker{
    func Speak() {
        print("Woof")
    }
}

//프로토콜을 사용하자
//Speaker는 Ray 타입이 아니라 Speaker 타입이므로 Speaker 메소드만 사용할 수 있다(Java의 업캐스팅과 유사)
var speaker:Speaker = Ray()
speaker.Speak()
//speaker.WriteTutorial()
//speaker를 다시 Ray로 임시 타입 캐스팅하면 WriteTutorial()메소드 호출 가능
(speaker as! Ray).WriteTutorial()
//speaker를 다시 Vicki로 설정할 수 있음
speaker = Vicki()
speaker.Speak()
//Telljoke()는 optional 메소드이므로 호출하기 전에 존재를 check 해야함
speaker.Telljoke?()
speaker = Dog()
speaker.Telljoke?()
//메소드 이름 다음에 ?를 붙이는 것을 Optional Chaining이라 하고
//if let은 Optional Binding이라고 함




//다른 클래스에 이벤트 시작과 조요를 알리고(notify) 싶을 때
//우선 알리고(notify) 싶은 이벤트를 가지는 protocol을 생성해야 함
protocol DateSumulatorDelegate{
    func dateSimulatorDidStart(sim:DateSimulator, a:Speaker, b:Speaker)
    func dateSimulatorDidEnd(sim:DateSimulator, a:Speaker, b:Speaker)
}
//DateSumulatorDelegate 프로토콜을 따르는 클래스 생성
class LoggingDateSimulator: DateSumulatorDelegate{
    func dateSimulatorDidStart(sim: DateSimulator, a: Speaker, b: Speaker) {
        print("Date Started")
    }
    func dateSimulatorDidEnd(sim: DateSimulator, a: Speaker, b: Speaker) {
        print("Date ended")
    }
}

//새로운 클래스, Speaker 프로토ㅗㄹ을 따르는 2개의 인스턴스를 가짐
class DateSimulator{
    let a:Speaker
    let b:Speaker
    //DateSumulatorDelegate 프로토콜을 따르는 변수 생성
    var delegate: DateSumulatorDelegate?
    
    init(a:Speaker, b:Speaker){
        self.a = a
        self.b = b
    }
    
    func simulate(){
        //delegate 변수가 따르는 프로토콜 메소드 호출
        delegate?.dateSimulatorDidStart(sim: self, a: a, b: b)
        print("Off to dinner...")
        a.Speak()
        b.Speak()
        print("Walking back home...")
        a.Telljoke?()
        b.Telljoke?()
        delegate?.dateSimulatorDidEnd(sim: self, a: a, b: b)
    }
}

let sim = DateSimulator(a:Vicki(), b:Ray())
//sim.delegate 변수를 LoggingDateSimulator()로 설정
sim.delegate = LoggingDateSimulator()
sim.simulate()

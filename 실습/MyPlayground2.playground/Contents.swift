import UIKit

func randomIntBetween(low:Int, high:Int) -> Int {
    let range = high - (low - 1)
    return (Int(arc4random()) % range) + (low - 1)
}

//1에서 100 사이의 랜덤 넘버 int 상수 answer 선언
let answer = randomIntBetween(low: 1, high: 100)

//1에서 100 사이 숫자를 입력하라고 print 했으나
//playground에서는 입력이 안됨
print("Enter a number between 1 and 100")

//여기는 그냥 guess 변수 선언
var guess = 7

//랜덤 넘버 answer와 guess 비교
if(guess > answer){
    print("Lower!")
} else if(guess < answer){
    print("Higher!")
} else{
    print("Correct! The answer was \(answer).")
}

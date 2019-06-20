import UIKit

var str: String = "안녕!"
var age: Int = 20

var luckyNumber: Int = 7
var cost0fCandy: Double = 1.25
var hungry: Bool = true
var name: String = "soojeong"

name = "박수정"

var cokeLeft = 7
var fantaLeft = 4
while(cokeLeft > 0)
{
    print("You have \(cokeLeft) coke left")
    cokeLeft -= 1
    if(cokeLeft <= fantaLeft)
    {
        break
    }
}

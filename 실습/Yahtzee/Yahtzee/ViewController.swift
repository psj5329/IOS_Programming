//
//  ViewController.swift
//  Yahtzee
//
//  Created by kpugame on 2019. 5. 27..
//  Copyright © 2019년 SooJeong Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var roll : Int = 0
    var round : Int = 0
    var dice : [Int] = [1, 1, 1, 1, 1]
    var scores : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var used : [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    @IBOutlet weak var OutletRollDice: UIButton!
    
    @IBOutlet weak var OutletDice1: UIButton!
    @IBOutlet weak var OutletDice2: UIButton!
    @IBOutlet weak var OutletDice3: UIButton!
    @IBOutlet weak var OutletDice4: UIButton!
    @IBOutlet weak var OutletDice5: UIButton!
    @IBOutlet weak var OutletCategory1: UIButton!
    @IBOutlet weak var OutletCategory2: UIButton!
    @IBOutlet weak var OutletCategory3: UIButton!
    @IBOutlet weak var OutletCategory4: UIButton!
    @IBOutlet weak var OutletCategory5: UIButton!
    @IBOutlet weak var OutletCategory6: UIButton!
    @IBOutlet weak var OutletUpperTotal: UILabel!
    @IBOutlet weak var OutletUpperBonus: UILabel!
    @IBOutlet weak var OutletCategory7: UIButton!
    @IBOutlet weak var OutletCategory8: UIButton!
    @IBOutlet weak var OutletCategory9: UIButton!
    @IBOutlet weak var OutletCategory10: UIButton!
    @IBOutlet weak var OutletCategory11: UIButton!
    @IBOutlet weak var OutletCategory12: UIButton!
    @IBOutlet weak var OutletCategory13: UIButton!
    @IBOutlet weak var OutletLowerTotal: UILabel!
    @IBOutlet weak var OutletGrandTotal: UILabel!
    
    @IBAction func ActionRollDice(_ sender: Any) {
        audioController.playerEffect(name: SoundDing)
        if (OutletRollDice.isEnabled)
        {
            rollDice()
            switch(roll){
            case 0, 1 :
                roll += 1
                OutletRollDice.setTitle("Roll Again", for: UIControl.State.normal)
                OutletGameMessage.text = "간직할 주사위를 선택한 후 Roll Again 버튼을 누르세요"
                break
            case 2 :
                //roll = 0
                OutletGameMessage.text = "이제 남아있는 Category를 선택하세요"
                OutletRollDice.isEnabled = false
                round += 1
                break
            default:
                break
            }
        }
        drawCategory()
    }
    @IBAction func ActionDice1(_ sender: Any) {
        if(roll != 0) {
            OutletDice1.backgroundColor = UIColor.gray
            OutletDice1.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice1.transform = CGAffineTransform(rotationAngle : 0)}, completion: nil)
            
            audioController.playerEffect(name: SoundWrong)
        }
    }
    @IBAction func ActionDice2(_ sender: Any) {
        if(roll != 0) {
            OutletDice2.backgroundColor = UIColor.gray
            OutletDice2.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice2.transform = CGAffineTransform(rotationAngle : 0)}, completion: nil)
            
            audioController.playerEffect(name: SoundWrong)
        }
    }
    @IBAction func ActionDice3(_ sender: Any) {
        if(roll != 0) {
            OutletDice3.backgroundColor = UIColor.gray
            OutletDice3.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice3.transform = CGAffineTransform(rotationAngle : 0)}, completion: nil)
            
            audioController.playerEffect(name: SoundWrong)
        }
    }
    @IBAction func ActionDice4(_ sender: Any) {
        if(roll != 0) {
            OutletDice4.backgroundColor = UIColor.gray
            OutletDice4.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice4.transform = CGAffineTransform(rotationAngle : 0)}, completion: nil)
            
            audioController.playerEffect(name: SoundWrong)
        }
    }
    @IBAction func ActionDice5(_ sender: Any) {
        if(roll != 0) {
            OutletDice5.backgroundColor = UIColor.gray
            OutletDice5.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice5.transform = CGAffineTransform(rotationAngle : 0)}, completion: nil)
            
            audioController.playerEffect(name: SoundWrong)
        }
    }
    @IBAction func ActionCategory1(_ sender: Any) {
        if(OutletCategory1.isEnabled && roll == 2) {
            scores[0] = upperScores(index: 1)
            used[0] = true
            OutletCategory1.setTitle(String(scores[0]), for: UIControl.State.normal)
            OutletCategory1.isEnabled = false
            OutletCategory1.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory1.imageView?.center.x)!, y: (OutletCategory1.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory1.imageView?.superview?.addSubview(explore)
            OutletCategory1.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory2(_ sender: Any) {
        if(OutletCategory2.isEnabled && roll == 2) {
            scores[1] = upperScores(index: 2)
            used[1] = true
            OutletCategory2.setTitle(String(scores[1]), for: UIControl.State.normal)
            OutletCategory2.isEnabled = false
            OutletCategory2.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory2.imageView?.center.x)!, y: (OutletCategory2.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory2.imageView?.superview?.addSubview(explore)
            OutletCategory2.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory3(_ sender: Any) {
        if(OutletCategory3.isEnabled && roll == 2) {
            scores[2] = upperScores(index: 3)
            used[2] = true
            OutletCategory3.setTitle(String(scores[2]), for: UIControl.State.normal)
            OutletCategory3.isEnabled = false
            OutletCategory3.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory3.imageView?.center.x)!, y: (OutletCategory3.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory3.imageView?.superview?.addSubview(explore)
            OutletCategory3.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory4(_ sender: Any) {
        if(OutletCategory4.isEnabled && roll == 2) {
            scores[3] = upperScores(index: 4)
            used[3] = true
            OutletCategory4.setTitle(String(scores[3]), for: UIControl.State.normal)
            OutletCategory4.isEnabled = false
            OutletCategory4.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory4.imageView?.center.x)!, y: (OutletCategory4.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory4.imageView?.superview?.addSubview(explore)
            OutletCategory4.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory5(_ sender: Any) {
        if(OutletCategory5.isEnabled && roll == 2) {
            scores[4] = upperScores(index: 5)
            used[4] = true
            OutletCategory5.setTitle(String(scores[4]), for: UIControl.State.normal)
            OutletCategory5.isEnabled = false
            OutletCategory5.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory5.imageView?.center.x)!, y: (OutletCategory5.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory5.imageView?.superview?.addSubview(explore)
            OutletCategory5.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory6(_ sender: Any) {
        if(OutletCategory6.isEnabled && roll == 2) {
            scores[5] = upperScores(index: 6)
            used[5] = true
            OutletCategory6.setTitle(String(scores[5]), for: UIControl.State.normal)
            OutletCategory6.isEnabled = false
            OutletCategory6.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory6.imageView?.center.x)!, y: (OutletCategory6.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory6.imageView?.superview?.addSubview(explore)
            OutletCategory6.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory7(_ sender: Any) {
        if(OutletCategory7.isEnabled && roll == 2) {
            scores[6] = scoreThreeOfAKind()
            used[6] = true
            OutletCategory7.setTitle(String(scores[6]), for: UIControl.State.normal)
            OutletCategory7.isEnabled = false
            OutletCategory7.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory7.imageView?.center.x)!, y: (OutletCategory7.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory7.imageView?.superview?.addSubview(explore)
            OutletCategory7.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory8(_ sender: Any) {
        if(OutletCategory8.isEnabled && roll == 2) {
            scores[7] = scoreFourOfKind()
            used[7] = true
            OutletCategory8.setTitle(String(scores[7]), for: UIControl.State.normal)
            OutletCategory8.isEnabled = false
            OutletCategory8.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory8.imageView?.center.x)!, y: (OutletCategory8.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory8.imageView?.superview?.addSubview(explore)
            OutletCategory8.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory9(_ sender: Any) {
        if(OutletCategory9.isEnabled && roll == 2) {
            scores[8] = scoreFullHouse()
            used[8] = true
            OutletCategory9.setTitle(String(scores[8]), for: UIControl.State.normal)
            OutletCategory9.isEnabled = false
            OutletCategory9.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory9.imageView?.center.x)!, y: (OutletCategory9.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory9.imageView?.superview?.addSubview(explore)
            OutletCategory9.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory10(_ sender: Any) {
        if(OutletCategory10.isEnabled && roll == 2) {
            scores[9] = scoreSmallStraight()
            used[9] = true
            OutletCategory10.setTitle(String(scores[9]), for: UIControl.State.normal)
            OutletCategory10.isEnabled = false
            OutletCategory10.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory10.imageView?.center.x)!, y: (OutletCategory10.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory10.imageView?.superview?.addSubview(explore)
            OutletCategory10.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory11(_ sender: Any) {
        if(OutletCategory11.isEnabled && roll == 2) {
            scores[10] = scoreLargeStraight()
            used[10] = true
            OutletCategory11.setTitle(String(scores[10]), for: UIControl.State.normal)
            OutletCategory11.isEnabled = false
            OutletCategory11.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory11.imageView?.center.x)!, y: (OutletCategory11.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory11.imageView?.superview?.addSubview(explore)
            OutletCategory11.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory12(_ sender: Any) {
        if(OutletCategory12.isEnabled && roll == 2) {
            scores[11] = scoreYahtzee()
            used[11] = true
            OutletCategory12.setTitle(String(scores[11]), for: UIControl.State.normal)
            OutletCategory12.isEnabled = false
            OutletCategory12.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory12.imageView?.center.x)!, y: (OutletCategory12.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory12.imageView?.superview?.addSubview(explore)
            OutletCategory12.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    @IBAction func ActionCategory13(_ sender: Any) {
        if(OutletCategory13.isEnabled && roll == 2) {
            scores[12] = scoreChance()
            used[12] = true
            OutletCategory13.setTitle(String(scores[12]), for: UIControl.State.normal)
            OutletCategory13.isEnabled = false
            OutletCategory13.backgroundColor = UIColor.gray
            
            let explore = ExplodeView(frame: CGRect(x: (OutletCategory13.imageView?.center.x)!, y: (OutletCategory13.imageView?.center.y)!, width: 10, height: 10))
            OutletCategory13.imageView?.superview?.addSubview(explore)
            OutletCategory13.imageView?.superview?.sendSubviewToBack(_: explore)
            audioController.playerEffect(name: SoundDing)
            
            self.toDoAfterCategory()
            
            roll = 0
        }
    }
    
    func scoreThreeOfAKind() -> Int{
        var sameNum : Int
        for i in 0..<3 {
            sameNum = 0
            for j in i + 1..<5 {
                if(dice[i] == dice[j]) {
                    sameNum += 1
                }
            }
            if (sameNum >= 2) {
                return sumDice()
            }
        }
        return 0;
    }
    func scoreFourOfKind()->Int{
        var sameNum : Int
        for i in 0..<3{
            sameNum = 0
            for j in i+1..<5{
                if(dice[i] == dice[j]){
                    sameNum += 1
                }
            }
            if ( sameNum >= 3){
                return sumDice()
            }
        }
        return 0;
    }
    func scoreSmallStraight()->Int{
        var check : [Int] = []
        var chance : Bool = true
        for i in 0..<5{
            check.append(dice[i])
        }
        check.sort()
        for i in 0..<4{
            if(check[i]+1 != check[i+1] && chance){
                chance = false
            }else if(check[i]+1 != check[i+1] && !chance){
                return 0
            }
        }
        return 30
    }
    func scoreLargeStraight()->Int{
        var check : [Int] = []
        for i in 0..<5{
            check.append(dice[i])
        }
        check.sort()
        for i in 0..<4{
            if(check[i]+1 != check[i+1]){
                return 0
            }
        }
        return 40
    }
    func scoreFullHouse()->Int{
        if dice[0] == 0{
            return 0
        }
        var check : [Int] = []
        for i in 0..<5{
            check.append(dice[i])
        }
        check.sort()
        if(check[0] == check[2] && check[3] == check[4]){
            return 25
        }else if(check[0] == check[1] && check[2] == check[4]){
            return 25
        }
        return 0
    }
    func scoreChance()->Int{
        return sumDice()
    }
    func scoreYahtzee()->Int{
        if dice[0] == 0{
            return 0
        }
        var check : [Int] = []
        for i in 0..<5{
            check.append(dice[i])
        }
        check.sort()
        if(check[0] == check[4]){
            return 50
        }
        return 0
    }
    
    func drawCategory(){
        if OutletCategory1.isEnabled{
            OutletCategory1.setTitle(String(upperScores(index : 1)), for: UIControl.State.normal)}
        if OutletCategory2.isEnabled{
            OutletCategory2.setTitle(String(upperScores(index : 2)), for: UIControl.State.normal)}
        if OutletCategory3.isEnabled{
            OutletCategory3.setTitle(String(upperScores(index : 3)), for: UIControl.State.normal)}
        if OutletCategory4.isEnabled{
            OutletCategory4.setTitle(String(upperScores(index : 4)), for: UIControl.State.normal)}
        if OutletCategory5.isEnabled{
            OutletCategory5.setTitle(String(upperScores(index : 5)), for: UIControl.State.normal)}
        if OutletCategory6.isEnabled{
            OutletCategory6.setTitle(String(upperScores(index : 6)), for: UIControl.State.normal)}
        if OutletCategory7.isEnabled{
            OutletCategory7.setTitle(String(scoreThreeOfAKind()), for: UIControl.State.normal)}
        if OutletCategory8.isEnabled{
            OutletCategory8.setTitle(String(scoreFourOfKind()), for: UIControl.State.normal)}
        if OutletCategory9.isEnabled{
            OutletCategory9.setTitle(String(scoreFullHouse()), for: UIControl.State.normal)}
        if OutletCategory10.isEnabled{
            OutletCategory10.setTitle(String(scoreSmallStraight()), for: UIControl.State.normal)}
        if OutletCategory11.isEnabled{
            OutletCategory11.setTitle(String(scoreLargeStraight()), for: UIControl.State.normal)}
        if OutletCategory12.isEnabled{
            OutletCategory12.setTitle(String(scoreYahtzee()), for: UIControl.State.normal)}
        if OutletCategory13.isEnabled{
            OutletCategory13.setTitle(String(scoreChance()), for: UIControl.State.normal)}
    }
    
    @IBOutlet weak var OutletGameMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dicePos = [OutletDice1.center, OutletDice2.center, OutletDice3.center, OutletDice4.center, OutletDice5.center]
    }

    func rollDice() {
        if(OutletDice1.isEnabled){
            dice[0] = Int((arc4random() % 6) + 1)
            OutletDice1.setTitle(String(dice[0]), for: UIControl.State.normal)
            
            UIView.animate(withDuration: Double(randomNumber(minX: 1, maxX: 5)) / 10.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice1.center = CGPoint(x: randomNumber(minX: 200, maxX: 600), y: randomNumber(minX: 100, maxX: 150))
                self.OutletDice1.transform = CGAffineTransform(rotationAngle: CGFloat(randomNumber(minX: 0, maxX: 20)))
            }, completion: nil)
        }
        if(OutletDice2.isEnabled){
            dice[1] = Int((arc4random() % 6) + 1)
            OutletDice2.setTitle(String(dice[1]), for: UIControl.State.normal)
            
            UIView.animate(withDuration: Double(randomNumber(minX: 1, maxX: 5)) / 10.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice2.center = CGPoint(x: randomNumber(minX: 200, maxX: 600), y: randomNumber(minX: 200, maxX: 250))
                self.OutletDice2.transform = CGAffineTransform(rotationAngle: CGFloat(randomNumber(minX: 0, maxX: 20)))
            }, completion: nil)
        }
        if(OutletDice3.isEnabled){
            dice[2] = Int((arc4random() % 6) + 1)
            OutletDice3.setTitle(String(dice[2]), for: UIControl.State.normal)
            
            UIView.animate(withDuration: Double(randomNumber(minX: 1, maxX: 5)) / 10.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice3.center = CGPoint(x: randomNumber(minX: 200, maxX: 600), y: randomNumber(minX: 300, maxX: 350))
                self.OutletDice3.transform = CGAffineTransform(rotationAngle: CGFloat(randomNumber(minX: 0, maxX: 20)))
            }, completion: nil)
        }
        if(OutletDice4.isEnabled){
            dice[3] = Int((arc4random() % 6) + 1)
            OutletDice4.setTitle(String(dice[3]), for: UIControl.State.normal)
            
            UIView.animate(withDuration: Double(randomNumber(minX: 1, maxX: 5)) / 10.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice4.center = CGPoint(x: randomNumber(minX: 200, maxX: 600), y: randomNumber(minX: 400, maxX: 450))
                self.OutletDice4.transform = CGAffineTransform(rotationAngle: CGFloat(randomNumber(minX: 0, maxX: 20)))
            }, completion: nil)
        }
        if(OutletDice5.isEnabled){
            dice[4] = Int((arc4random() % 6) + 1)
            OutletDice5.setTitle(String(dice[4]), for: UIControl.State.normal)
            
            UIView.animate(withDuration: Double(randomNumber(minX: 1, maxX: 5)) / 10.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {self.OutletDice5.center = CGPoint(x: randomNumber(minX: 200, maxX: 600), y: randomNumber(minX: 500, maxX: 550))
                self.OutletDice5.transform = CGAffineTransform(rotationAngle: CGFloat(randomNumber(minX: 0, maxX: 20)))
            }, completion: nil)
        }
    }
    
    func upperScores(index : Int) -> Int {
        var sum : Int = 0
        for i in 0..<5{
            if(dice[i] == index) {
                sum += index
            }
        }
        return sum
    }
    
    
    func toDoAfterCategory() {
        if(allUpperUsed()){
            OutletUpperTotal.text = String(getUpperTotal())
            OutletUpperBonus.text = String(getUpperBonus())
        }
        if (allLowerUsed()){
            OutletLowerTotal.text = String(getLowerTotal())
        }
        if (allLowerUsed() && allUpperUsed()) {
            OutletGrandTotal.text = String(getLowerTotal() + getUpperTotal() + getUpperBonus())
            
            audioController.playerEffect(name: SoundWin)
            
            let startX: CGFloat = ScreenWidth - 100
            let startY: CGFloat = 0
            let endY: CGFloat = ScreenHeight + 300
            
            let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
            self.view.addSubview(stars)
            self.view.sendSubviewToBack(_: stars)
            
            UIView.animate(withDuration: 3.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {stars.center = CGPoint(x: startX, y: endY)}, completion: {(value:Bool) in stars.removeFromSuperview()})
        }
        
        OutletRollDice.isEnabled = true
        
        if(OutletDice1.isEnabled == true){
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.OutletDice1.center = self.dicePos[0]
                self.OutletDice1.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
        if(OutletDice2.isEnabled == true){
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.OutletDice2.center = self.dicePos[1]
                self.OutletDice2.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
        if(OutletDice3.isEnabled == true){
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.OutletDice3.center = self.dicePos[2]
                self.OutletDice3.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
        if(OutletDice4.isEnabled == true){
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.OutletDice4.center = self.dicePos[3]
                self.OutletDice4.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
        if(OutletDice5.isEnabled == true){
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.OutletDice5.center = self.dicePos[4]
                self.OutletDice5.transform = CGAffineTransform(rotationAngle: 0)
            }, completion: nil)
        }
        
        OutletDice1.isEnabled = true
        OutletDice1.setTitle("?", for: UIControl.State.normal)
        OutletDice1.backgroundColor = UIColor.blue
        dice[0] = 0
        
        OutletDice2.isEnabled = true
        OutletDice2.setTitle("?", for: UIControl.State.normal)
        OutletDice2.backgroundColor = UIColor.blue
        dice[1] = 0
        
        OutletDice3.isEnabled = true
        OutletDice3.setTitle("?", for: UIControl.State.normal)
        OutletDice3.backgroundColor = UIColor.blue
        dice[2] = 0
        
        OutletDice4.isEnabled = true
        OutletDice4.setTitle("?", for: UIControl.State.normal)
        OutletDice4.backgroundColor = UIColor.blue
        dice[3] = 0
        
        OutletDice5.isEnabled = true
        OutletDice5.setTitle("?", for: UIControl.State.normal)
        OutletDice5.backgroundColor = UIColor.blue
        dice[4] = 0
        
        OutletRollDice.setTitle("Roll Dice", for: UIControl.State.normal)
        roll = 0
        drawCategory()
        OutletGameMessage.text = "Roll Dice 버튼을 누르세요!"
    }
    
    func sumDice() -> Int {
        var sum : Int = 0
        for i in 0..<5{
            sum += dice[i]
        }
        return sum
    }
    
    func allUpperUsed() -> Bool {
        if(OutletCategory1.isEnabled){
            return false}
        if(OutletCategory2.isEnabled){
            return false}
        if(OutletCategory3.isEnabled){
            return false}
        if(OutletCategory4.isEnabled){
            return false}
        if(OutletCategory5.isEnabled){
            return false}
        if(OutletCategory6.isEnabled){
            return false}
        return true
    }
    
    func allLowerUsed() -> Bool {
        if(OutletCategory7.isEnabled){
            return false}
        if(OutletCategory8.isEnabled){
            return false}
        if(OutletCategory9.isEnabled){
            return false}
        if(OutletCategory10.isEnabled){
            return false}
        if(OutletCategory11.isEnabled){
            return false}
        if(OutletCategory12.isEnabled){
            return false}
        if(OutletCategory13.isEnabled){
            return false}
        return true
    }
    
    func getUpperBonus() -> Int {
        if getUpperTotal() >= 63{
            return 35
        }
        return 0
    }
    
    func getLowerTotal() -> Int {
        var sum : Int = 0
        for i in 6..<13{
            sum += scores[i]
        }
        return sum
    }
    
    func getUpperTotal() -> Int {
        var sum : Int = 0
        for i in 0..<6{
            sum += scores[i]
        }
        return sum
    }
    
    var dicePos : [CGPoint] = [CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0)]
    var audioController: AudioController    //오디오 컨트롤러 객체
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
}


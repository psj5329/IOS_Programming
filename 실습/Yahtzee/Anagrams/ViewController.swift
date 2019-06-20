//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//
//Anagrams Part2 에서는 tile을 drag해서 target에 위치하도록 하고
//timer와 score를 갖는 heads-up-display(HUD)를 구현한다.

import UIKit

class ViewController: UIViewController {
    private let controller: GameController
    
    required init?(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let level1 = Level(level: 1)
        // 스크린에 view layer 를 생성 추가하고 GameController 가 관리하게 한다.
        // ScreenWidth, ScreenHeight는 Config.swift에 있는 UI constants
        let gameView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(gameView)
        controller.gameView = gameView
        let hud = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hud)
        controller.hud = hud

        controller.level = level1
        controller.dealRandomAnagram()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    
 }


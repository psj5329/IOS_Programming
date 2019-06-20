//
//  GameController.swift
//  Anagrams
//
//  Created by kpugame on 2019. 5. 16..
//  Copyright © 2019년 Caroline. All rights reserved.
//

import UIKit

class GameController{
    var gameView: UIView!
    var level: Level!
    
    var tiles: [TileView]
    var targets: [TargetView]
    
    init(){
        tiles = []
        targets = []
    }
    func dealRandomAnagram(){
        assert(level.anagrams.count > 0, "No level loaded")
        
        let randomIndex = randomNumber(minX: 0, maxX: UInt32(level.anagrams.count - 1))
        let anagramPair = level.anagrams[randomIndex]
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        let anagram1Length = anagram1.characters.count
        let anagram2Length = anagram2.characters.count
        
        print("phrase1[\(anagram1Length)]: \(anagram1)")
        print("phrase2[\(anagram2Length)]: \(anagram2)")
        
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1Length, anagram2Length))) - TileMargin
        var xOffset = (ScreenWidth - CGFloat(max(anagram1Length, anagram2Length)) * (tileSide + TileMargin)) / 2.0 + TileMargin / 2.0
        xOffset += tileSide / 2.0
        
        for (index, letter) in anagram2.characters.enumerated(){
            if letter != " " {
                let taerget = TargetView(letter: letter, sideLength: tileSide)
                taerget.center = CGPoint(x: xOffset + CGFloat(index) * (tileSide + TileMargin), y: ScreenHeight / 4)
                
                gameView.addSubview(taerget)
                targets.append(taerget)
            }
        }
        
        for (index, letter) in anagram1.characters.enumerated(){
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.center = CGPoint(x: xOffset + CGFloat(index) * (tileSide + TileMargin), y: ScreenHeight / 4 * 3)
                tile.randomize()
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
    }
}

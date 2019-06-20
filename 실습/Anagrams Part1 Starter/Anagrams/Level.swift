//
//  Level.swift
//  Anagrams
//
//  Created by kpugame on 2019. 5. 16..
//  Copyright © 2019년 Caroline. All rights reserved.
//

import Foundation

struct Level{
    let pointsPerTile: Int
    let timeToSolve: Int
    let anagrams: [NSArray]
    
    init(level: Int){
        let fileName = "level\(level)"
        let fileExts = "plist"
        let levelPath = Bundle.main.path(forResource: fileName, ofType: fileExts)
        
        let levelDictionary: NSDictionary? = NSDictionary(contentsOfFile: levelPath!)
        
        assert(levelDictionary != nil, "level configuration file not found!")
        
        self.pointsPerTile = levelDictionary!["pointsPerTile"] as! Int
        self.timeToSolve = levelDictionary!["timeToSolve"] as! Int
        self.anagrams = levelDictionary!["anagrams"] as! [NSArray]
    }
}

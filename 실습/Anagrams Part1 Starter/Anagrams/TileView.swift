//
//  TileView.swift
//  Anagrams
//
//  Created by kpugame on 2019. 5. 16..
//  Copyright © 2019년 Caroline. All rights reserved.
//

import UIKit

class TileView: UIImageView{
    var letter: Character
    var isMatched: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter: Character, sideLength: CGFloat){
        self.letter = letter
        
        let image = UIImage(named: "tile")!
        super.init(image: image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)

        let letterLabl = UILabel(frame: self.bounds)
        letterLabl.textAlignment = NSTextAlignment.center
        letterLabl.textColor = UIColor.white
        letterLabl.backgroundColor = UIColor.clear
        letterLabl.text = String(letter).uppercased()
        letterLabl.font = UIFont(name: "Verdana-Bold", size: 78 * scale)
        self.addSubview(letterLabl)
    }
    
    func randomize(){
        let rotation = CGFloat(randomNumber(minX: 0, maxX: 50)) / 100 - 0.2
        
        self.transform = CGAffineTransform(rotationAngle: rotation)
        
        let yOffset = CGFloat(randomNumber(minX: 0, maxX: 10) - 10)
        self.center = CGPoint(x: self.center.x, y: self.center.y + yOffset)
    }
}

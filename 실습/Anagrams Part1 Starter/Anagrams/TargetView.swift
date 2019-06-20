//
//  TargetView.swift
//  Anagrams
//
//  Created by kpugame on 2019. 5. 16..
//  Copyright © 2019년 Caroline. All rights reserved.
//

import UIKit

class TargetView: UIImageView{
    var letter: Character
    var isMatched: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter: Character, sideLength: CGFloat){
        self.letter = letter
        
        let image = UIImage(named: "slot")!
        super.init(image: image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
    }
}


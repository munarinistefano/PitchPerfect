//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Stefano Munarini on 8/23/15.
//  Copyright © 2015 Stefano Munarini. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var title: String
    var filePathUrl: NSURL
    
    init(title: String, filePathUrl: NSURL){
        self.title = title
        self.filePathUrl = filePathUrl
        
    }
}
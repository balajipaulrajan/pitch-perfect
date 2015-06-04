//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Balaji Paulrajan on 6/2/15.
//  Copyright (c) 2015 Balaji Paulrajan. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl:NSURL!,title:String!) {
        self.filePathUrl = filePathUrl
        self.title = title
        super.init()
    }
}

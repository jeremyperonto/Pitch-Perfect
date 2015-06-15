//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jeremy Peronto on 6/11/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
 }
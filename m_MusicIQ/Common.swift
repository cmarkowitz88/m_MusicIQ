//
//  Common.swift
//  m_MusicIQ
//
//  Created by Craig Markowitz on 1/4/20.
//  Copyright © 2020 Craig Markowitz. All rights reserved.
//

import Foundation

class Common {
    var offline_mode: Bool
    var file_name: String
    
    init(_offline_mode: Bool){
        self.offline_mode = _offline_mode
        self.file_name = "MusicIQ_All_Songs2"
    }
}

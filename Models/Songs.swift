//
//  Songs.swift
//  m_MusicIQ
//
//  Created by Craig Markowitz on 1/4/20.
//  Copyright © 2020 Craig Markowitz. All rights reserved.
//

import Foundation

struct FullResponse: Codable {
    var statusCode: Int
    var body: [Song]
    
    struct Song: Codable {
        var Level: String
        var File_Path: String
        var Answer4: String
        var Answer3: String
        var Answer2: String
        var Answer1: String
        var Score: Int
        var Question: String
        var Hint: String
        var Track_Length: String
        var ID: String
        var Created: String
    }
    
    init(){
        statusCode = 0
        body = []
    }
}





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
    }
}





//
//  Video.swift
//  TestAlamofire
//
//  Created by Olya Tilichenko on 20.04.2018.
//  Copyright © 2018 Olya Tilichenko. All rights reserved.
//

import Foundation

struct Video {
    var title: String
    var date: String
    var description: String
    var thumbnail_image_name: String
    
    init?(json: [String: Any]) {
        guard
            let title = json["title"] as? String,
            let date = json["date"] as? String,
            let description = json["description"] as? String,
            let thumbnail_image_name = json["thumbnail_image_name"] as? String
            else {
                return nil
        }
        self.title = title
        self.date = date
        self.description = description
        self.thumbnail_image_name = thumbnail_image_name
    }
}

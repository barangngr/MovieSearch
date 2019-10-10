//
//  MovieAndSerieRequeestModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 10.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation


class MovieAndSerieRequeestModel{
    
    public var title: String?
    public var year: String?
    public var type: String?
    public var page: Int?
    
    init(title: String?, year: String?, type: String?, page: Int?) {
        self.title = title
        self.year = year
        self.type = type
        self.page = page
    }
      
}

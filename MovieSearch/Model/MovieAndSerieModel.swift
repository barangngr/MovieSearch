//
//  MovieAndSerieModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation

public struct MovieAndSerieModel: Codable{
    
    public var title: String?
    public var year: String?
    public var imdbID: String?
    public var type: String?
    public var poster: String?
  
    
    public init(title: String?, year: String?, imdbID: String?, type: String?, poster: String?){
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
      
    }
    
    
}

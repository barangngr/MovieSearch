//
//  MovieAndSerieModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation

public struct MovieAndSerieResponseModel: Codable{
    
    public var Title: String?
    public var Year: String?
    public var imdbID: String?
    public var `Type`: String?
    public var Poster: String?
    
    
    public init(Title: String?, Year: String?, imdbID: String?, Type: String?, Poster: String?){
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.Type = Type
        self.Poster = Poster
        
    }
}

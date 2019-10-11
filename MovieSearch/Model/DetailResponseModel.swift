//
//  DetailResponseModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation

public struct DetailResponseModel: Codable{
    
    public var Title: String?
    public var Released: String?
    public var Runtime: String?
    public var Genre: String?
    public var Director: String?
    public var Writer: String?
    public var Actors: String?
    public var Plot: String?
    public var Country: String?
    public var Poster: String?
    public var imdbRating: String?
    
    
    public init(Title: String? , Released: String?, Runtime: String?, Genre: String?, Director: String?, Writer: String?, Actors: String?, Plot: String? , Country: String?, Poster: String?, imdbRating: String?){
        self.Title = Title
        self.Released = Released
        self.Runtime = Runtime
        self.Genre = Genre
        self.Director = Director
        self.Writer = Writer
        self.Actors = Actors
        self.Plot = Plot
        self.Country = Country
        self.Poster = Poster
        self.imdbRating = imdbRating
        
    }
}

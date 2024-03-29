//
//  SearchResponseModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation


public struct SearchResponseModel: Codable{
    
    public var Search: [MovieAndSerieResponseModel]?
    public var totalResults: String?
    public var Response: String?
    
    
    public init(Search: [MovieAndSerieResponseModel]?, totalResults: String?, Response: String?){
        self.Search = Search
        self.totalResults = totalResults
        self.Response = Response
    }
}

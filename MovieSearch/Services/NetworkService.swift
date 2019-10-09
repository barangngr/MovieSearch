//
//  NetworkService.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import Moya


enum MetroCityCardService {
    enum BusinessesProvider: TargetType{
        
        var baseURL: URL{
            return URL(string: "http://www.omdbapi.com/?")!
        }
        
        var apikey: String{
            return "cace1cb3"
        }
        
        var path: String{
            switch self {
            case .getSearch:
                return ""
            }
        }
        
        var method: Moya.Method{
            switch self {
            case .getSearch:
                return .get
            }
        }
        
        var sampleData: Data{
            return Data()
        }
        
        var task: Task{
            switch self {
            case .getSearch(let param):
                return .requestParameters(parameters: ["apikey":apikey, "s":param], encoding: URLEncoding.queryString)
            }
        }
        
        var headers: [String : String]?{
            return ["":""]
        }
        
        case getSearch(title: String)
    }
}

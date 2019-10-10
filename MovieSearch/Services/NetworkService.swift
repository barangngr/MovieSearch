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
            case .getSearch, .getDetail, .getSearchWithoutType:
                return ""
            }
        }
        
        var method: Moya.Method{
            switch self {
            case .getSearch, .getDetail, .getSearchWithoutType:
                return .get
            }
        }
        
        var sampleData: Data{
            return Data()
        }
        
        var task: Task{
            switch self {
            case let .getSearch(paramTitle, paramYear, paramType, paramPage):
                return .requestParameters(parameters: ["apikey" : apikey, "s" : paramTitle, "y" : paramYear, "type" : paramType, "page" : paramPage], encoding: URLEncoding.queryString)
            case let .getSearchWithoutType(paramTitle, paramYear, paramPage):
                return .requestParameters(parameters: ["apikey" : apikey, "s" : paramTitle, "y" : paramYear, "page" : paramPage], encoding: URLEncoding.queryString)
            case .getDetail(let param):
                return .requestParameters(parameters: ["apikey" : apikey, "i" : param, "plot" : "full"], encoding: URLEncoding.queryString)
                
            }
        }
        
        var headers: [String : String]?{
            return ["":""]
        }
        
        case getSearch(title: String, year: String, type: String, page: String)
        case getSearchWithoutType(title: String, year: String, page: String)
        case getDetail(id: String)
    }
}

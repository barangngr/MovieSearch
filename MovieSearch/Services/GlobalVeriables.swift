//
//  GlobalVeriables.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import Moya


let service = MoyaProvider<MetroCityCardService.BusinessesProvider>()

struct StoryBoards {
    static var Main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //Designed for multiple storyboard.
}


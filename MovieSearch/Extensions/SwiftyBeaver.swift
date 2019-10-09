//
//  SwiftyBeaver.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import SwiftyBeaver


let logger = SwiftyBeaver.self

extension SwiftyBeaver {
  static func setupConsole() {
    let console = ConsoleDestination()
    console.format = "$DHH:mm:ss.SSS$d $L $C$c $N.$F - $M $X"
    console.levelColor.verbose = "⚒"
    console.levelColor.debug = "🔧"
    console.levelColor.info = "📣"
    console.levelColor.warning = "⚠"
    console.levelColor.error = "🤬"
    #if DEBUG
    console.minLevel = .debug
    #else
    console.minLevel = .error
    #endif
    
    logger.addDestination(console)
  }
}

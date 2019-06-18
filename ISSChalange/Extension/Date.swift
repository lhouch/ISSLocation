//
//  Date.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/18/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit
extension Date
{
    func convertUnixtimeInterval() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        return dateFormatter.string(from: self)
    }
    
}

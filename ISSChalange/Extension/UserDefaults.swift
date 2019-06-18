//
//  UserDefaults.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/18/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit

extension UserDefaults  {
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    //MARK: Retrieve latitude  Coordinate
    func getValueLocationISSCoordinateLatidud() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.ISSLatitude.rawValue)! 
    }
    
    //MARK: Retrieve longitude  Coordinate
    func getValueLocationISSCoordinateLongitude() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.ISSLongitude.rawValue)!
    }
    
    //MARK: save latitude  Coordinate
    func setValueISSLocationCoordinateLatidud(value: String) {
        set(value, forKey: UserDefaultsKeys.ISSLatitude.rawValue)
    }
    
    //MARK: save longitude  Coordinate
    func setValueISSLocationCoordinateLongitude(value: String){
        set(value, forKey: UserDefaultsKeys.ISSLongitude.rawValue)
    }
    
}

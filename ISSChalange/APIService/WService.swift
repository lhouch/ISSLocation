//
//  WService.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import Foundation

class WService: NSObject {
    
    static let sharedInstance = WService()
    
    
    func getISSCurrentLocation(completion: @escaping (Result<IssPositionResponse, Error>) -> ()) {
        guard let url_ = URL(string: ISS_NOW_URL) else { return }
        URLSession.shared.dataTask(with: url_) { (data, resp, err) in
            // if is error response
            if let err = err {
                completion(.failure(err))
                return
            }
            // if is successful response
            do {
                let position = try JSONDecoder().decode(IssPositionResponse.self, from: data!)
                completion(.success(position))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            
            }.resume()
    }
    
    func getISSPassTimess(lat : String, lon : String, completion: @escaping (Result<PassTimesResponse, Error>) -> ()) {
        guard let url_ = URL(string: PASS_URL + "?lat=\(lat)&" + "lon=\(lon)") else { return }
        
        URLSession.shared.dataTask(with: url_) { (data, resp, err) in
            // if is error response
            if let err = err {
                completion(.failure(err))
                return
            }
            // if is successful response
            do {
                let passTimes = try JSONDecoder().decode(PassTimesResponse.self, from: data!)
                completion(.success(passTimes))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            
            }.resume()
    }
    
    
    func getISSAstros(completion: @escaping (Result<AstroResponse, Error>) -> ()) {
        
        
        guard let url_ = URL(string: ASTROS_URL) else { return }
        
        URLSession.shared.dataTask(with: url_) { (data, resp, err) in
            // if is error response
            if let err = err {
                completion(.failure(err))
                return
            }
            // if is successful response
            do {
                let astros = try JSONDecoder().decode(AstroResponse.self, from: data!)
                completion(.success(astros))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            
            }.resume()
    }
    
}

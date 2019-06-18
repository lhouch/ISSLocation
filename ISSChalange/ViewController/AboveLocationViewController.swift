//
//  AboveLocationViewController.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class AboveLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var mTitleLabel: UILabel!
    
    @IBOutlet weak var mDescLabel: UILabel!
    
    let mLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        
    }
    
    
    func initLocationManager() {
        self.mLocationManager.requestAlwaysAuthorization()
        self.mLocationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            mLocationManager.delegate = self
            mLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            mLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        // print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.calculateDistance(UserLatitude: locValue.latitude, UserLongitude: locValue.longitude)
        
    }
    
    
    func calculateDistance(UserLatitude : Double, UserLongitude : Double) {
        let ISSLatitude = UserDefaults.standard.getValueLocationISSCoordinateLatidud()
        let ISSLongitude = UserDefaults.standard.getValueLocationISSCoordinateLongitude()
        
        
        //User location
        let userLocation = CLLocation(latitude: UserLatitude, longitude: UserLongitude)
        //ISS location
        let ISSLocation = CLLocation(latitude: Double(ISSLatitude) as! CLLocationDegrees, longitude: Double(ISSLongitude) as! CLLocationDegrees)
        
        //Measuring distance between ISS and User (in km)
        let distance = userLocation.distance(from: ISSLocation) / 1000
        
        
        if distance <= 60
        {
            self.mTitleLabel.text = "ISS is hovering above your location";
        }
        else{
            self.mTitleLabel.text = "ISS is not hovering above your location";
        }
        self.mDescLabel.text = String("The distance between you and ISS is \(String(format:"%.2f", distance)) Km")
        
        
        
    }
    
    
    
    
}

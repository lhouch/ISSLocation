//
//  ViewController.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit
import MapKit


class MainViewController: UIViewController  {
    
    @IBOutlet weak var mapView: MKMapView!
    var timer : Timer?
    let mLocationManager = CLLocationManager()
    var userLocation : CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        startTracking()
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
    
    
    let regionraduis : CLLocationDistance = 1000000
    
    func centerMapOnLocation(location : CLLocation){
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionraduis, longitudinalMeters: regionraduis)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    func startTracking() {
        self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(refreshLocationISS), userInfo: ["score": 10], repeats: true)
    }
    
    func stopTracking() {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
    }
    
    
    
    @objc func refreshLocationISS(){
        WService.sharedInstance.getISSCurrentLocation{ (res) in
            switch res {
            case .success(let position):
                print(String(describing: position.message!))
                // show artwork on map
                DispatchQueue.main.async {
                    
                    
                    
                    if let latitude : String = position.iss_position?.latitude, let longitude = position.iss_position?.longitude {
                        
                        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double(latitude) as! CLLocationDegrees , longitude:  Double(longitude) as! CLLocationDegrees)
                        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
                        myAnnotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
                        myAnnotation.title = "Point ISS"
                        self.mapView.addAnnotation(myAnnotation)
                        self.centerMapOnLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
                        UserDefaults.standard.setValueISSLocationCoordinateLatidud(value: latitude)
                        UserDefaults.standard.setValueISSLocationCoordinateLongitude(value: longitude)
                    }
                    
                }
                
                
            case .failure(let err):
                print("Failed to fetch position:", err)
                self.stopTracking()
                self.showAlertViewInSuperview("Failed to fetch position", message: err.localizedDescription, completion: {
                    self.stopTracking()
                })
            }
        }
    }
    
    deinit {
        stopTracking()
    }
    
    
}


extension MainViewController : MKMapViewDelegate, CLLocationManagerDelegate  {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "PointISS"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        var pinImage = UIImage(named: "point_blue_ic")
        
        
        //Testing if ISS in above location
        if self.userLocation != nil{
            if self.calculateDistance(ISSLocation: CLLocation(latitude: annotation.coordinate.latitude, longitude:annotation.coordinate.longitude ))
            {
                pinImage = UIImage(named: "point_spring_ic")
            }
        }
        
        
        annotationView!.image = pinImage
        
        return annotationView
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.userLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
    }
    
    
    func calculateDistance(ISSLocation : CLLocation) -> Bool {
        //Measuring distance between ISS and User (in km)
        let distance = self.userLocation!.distance(from: ISSLocation) / 1000
        if distance <= 60
        {
            return true
        }
        else{
            return false
        }
    }
    
}

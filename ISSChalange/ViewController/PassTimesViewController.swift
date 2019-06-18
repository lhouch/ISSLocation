//
//  PassTimesViewController.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit
import MapKit

class PassTimesViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mTableView: UITableView!
    let mLocationManager = CLLocationManager()
    var mListPassTimes = [Pass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
    }
    
    
    func initLocationManager() {
        self.mLocationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.mLocationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            mLocationManager.delegate = self
            mLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            mLocationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.mLocationManager.stopUpdatingLocation()
        self.getPassTimes(lat: "\(locValue.latitude)", lon: "\(locValue.longitude)")
    }
    
    
    func getPassTimes(lat : String, lon : String)  {
        WService.sharedInstance.getISSPassTimess(lat: lat, lon: lon) { (res) in
            switch res {
            case .success(let passTimesRes):
                DispatchQueue.main.async {
                    self.mListPassTimes = passTimesRes.response!
                    self.mTableView.reloadData()
                    
                }
                
            case .failure(let err):
                DispatchQueue.main.async {
                    self.hideActivityIndicatoryInSuperview()
                }
                self.showAlertViewInSuperview("Failed to fetch astros", message: err.localizedDescription, completion: {
                    print("Failed to fetch astros:", err)
                })
            }
        }
    }
    
    
    
}



extension PassTimesViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mListPassTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passTimeTableViewCell", for: indexPath) as! PassTimeTableViewCell
        
        // Configure the cell...
        cell.initcell(pass: self.mListPassTimes[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
}


class PassTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var risetime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initcell(pass : Pass){
        self.risetime?.text = Date(timeIntervalSince1970: pass.risetime!).convertUnixtimeInterval()
        let (h, m, s) = convertSecondsToHMS(pass.duration!)
        self.duration?.text = String(describing: "\(h) Hours, \(m) Minutes, \(s) Seconds")
    }
    
    
    func convertSecondsToHMS(_ seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}

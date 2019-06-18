//
//  PassengersViewController.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit

class PassengersViewController: UIViewController {
    
    
    
    @IBOutlet weak var mTableView: UITableView!
    
    
    var mListAstros : [Astro] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        getListPassengers()
    }
    
    
    func getListPassengers() {
        self.showActivityIndicatoryInSuperview()
        
        WService.sharedInstance.getISSAstros { (res) in
            
            switch res {
            case .success(let astrosRes):
                
                self.mListAstros = astrosRes.people!
                DispatchQueue.main.async {
                    self.mTableView.reloadData()
                    
                    self.hideActivityIndicatoryInSuperview()
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

extension PassengersViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mListAstros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "astroTableViewCell", for: indexPath) as! AstroTableViewCell
        
        // Configure the cell...
        cell.initcell(astro: self.mListAstros[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
}


class AstroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var craft: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func initcell(astro : Astro){
        self.name?.text = astro.name
        self.craft?.text = astro.craft
    }
    
    
    
}

//
//  AccountInfo.swift
//  WaterMe
//
//  Created by Маркі on 13.12.2020.
//

import UIKit

class AccountInfo: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightTextLabel: UILabel!
    @IBOutlet weak var weightCurrent: UILabel!
    @IBOutlet weak var dailyTextLabel: UILabel!
    @IBOutlet weak var dailyCurrent: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.layer.masksToBounds = true
        weightTextLabel.layer.masksToBounds = true
        weightCurrent.layer.masksToBounds = true
        dailyTextLabel.layer.masksToBounds = true
        dailyCurrent.layer.masksToBounds = true
        
        nameLabel.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        weightTextLabel.layer.cornerRadius = 10
        weightCurrent.layer.cornerRadius = 10
        dailyTextLabel.layer.cornerRadius = 10
        dailyCurrent.layer.cornerRadius = 10
        logOutButton.layer.cornerRadius = 10
        
        nameLabel.textAlignment = .center
        weightTextLabel.textAlignment = .center
        weightCurrent.textAlignment = .center
        dailyTextLabel.textAlignment = .center
        dailyCurrent.textAlignment = .center
        
        nameLabel.text = "\(String(describing: UserDefaults.standard.string(forKey: "Name")!))"
        weightCurrent.text = "\(String(describing: UserDefaults.standard.integer(forKey: "Weight"))) kg"
        dailyCurrent.text = "\(String(describing: UserDefaults.standard.integer(forKey: "DailyWater"))) ml"
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
         }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

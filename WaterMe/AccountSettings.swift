//
//  AccountSettings.swift
//  WaterMe
//
//  Created by Маркі on 17.12.2020.
//

import UIKit

class AccountSettings: UITableViewController {
    
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var neededLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = "Name: \(String(describing: UserDefaults.standard.string(forKey: "Name")!))"
        weightLabel.text = "Weight: \(String(describing: UserDefaults.standard.integer(forKey: "Weight"))) kg"
        neededLabel.text = "Needed: \(String(describing: UserDefaults.standard.integer(forKey: "DailyWater"))) ml"
        logOutButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        
        accountImage.layer.masksToBounds = false
        accountImage.layer.cornerRadius = 10
        accountImage.clipsToBounds = true

        if let imageURL = UserDefaults.standard.url(forKey: "AvatarURL") {
            if let data = NSData(contentsOf: imageURL) as NSData? {
                accountImage.image = UIImage(data: data as Data)
            }
        } else {
            accountImage.image = .strokedCheckmark
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }
    
    @IBAction func switchButtonPressed(_ sender: UISwitch) {
        if notificationSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "SendNotifications")
        } else {
            UserDefaults.standard.set(false, forKey: "SendNotifications")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
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

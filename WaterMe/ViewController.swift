//
//  ViewController.swift
//  WaterMe
//
//  Created by Маркі on 08.12.2020.
//

import UIKit
import SwiftUI
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var addWaterButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var hundredMilimeterButton: UIButton!
    @IBOutlet weak var threeHundredMilimeterButton: UIButton!
    @IBOutlet weak var fiveHundredMilimeterButton: UIButton!
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var waterMilimetersStackView: UIStackView!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    
    let viewCtrl = UIHostingController(rootView: WaterPercentView(mililiters: UserDefaults.standard.integer(forKey: "AlreadyDrunk"), neededToDrink: UserDefaults.standard.integer(forKey: "DailyWater")))
    var plusPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        blurEffect.isHidden = true
        view.backgroundColor = UIColor(red: 0.13, green: 0.16, blue: 0.19, alpha: 1.00)
        viewCtrl.view.backgroundColor = .clear
        waterView.addSubview(viewCtrl.view)
        setupConstraints()
        addWaterButton.layer.cornerRadius = 10
        accountButton.layer.cornerRadius = 10
        hundredMilimeterButton.layer.cornerRadius = 10
        threeHundredMilimeterButton.layer.cornerRadius = 10
        fiveHundredMilimeterButton.layer.cornerRadius = 10
        closeButton.layer.cornerRadius = 10
        waterMilimetersStackView.isHidden = true
        closeButton.isHidden = true
        setupNotifications()
    }
    
    fileprivate func setupConstraints() {
        viewCtrl.view.translatesAutoresizingMaskIntoConstraints = false
        viewCtrl.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewCtrl.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewCtrl.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewCtrl.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @IBAction func addWaterButtonPressed(_ sender: UIButton) {
        plusPressed = !plusPressed
        if plusPressed {
            blurEffect.isHidden = false
            blurEffect.contentView.addSubview(closeButton)
            blurEffect.contentView.addSubview(waterMilimetersStackView)
            waterMilimetersStackView.isHidden = false
            closeButton.isHidden = false
        } else {
            blurEffect.isHidden = true
            waterMilimetersStackView.isHidden = true
            closeButton.isHidden = true
        }
    }
    
    func setupNotifications() {
        if UserDefaults.standard.bool(forKey: "SendNotifications") {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            }
            let content = UNMutableNotificationContent()
            content.title = "WaterMe Reminder"
            content.body = "Come back to us and setup your results!"
            content.sound = .default
            // Everyday notification for 12:00
            var date = DateComponents()
            date.hour = 12
            date.minute = 00
            let triger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: triger)
            center.add(request) { (error) in
                if error != nil {
                    print(error!)
                }
            }
        }
    }
    
    @IBAction func hunderedMilimetersPressed(_ sender: UIButton) {
        viewCtrl.rootView.addMilimeters(newMilimeters: 100)
        let currentDrunk = UserDefaults.standard.integer(forKey: "AlreadyDrunk")
        UserDefaults.standard.set(currentDrunk + 100, forKey: "AlreadyDrunk")
    }
    
    @IBAction func threeHunderedMilimetersPressed(_ sender: UIButton) {
        viewCtrl.rootView.addMilimeters(newMilimeters: 300)
        let currentDrunk = UserDefaults.standard.integer(forKey: "AlreadyDrunk")
        UserDefaults.standard.set(currentDrunk + 300, forKey: "AlreadyDrunk")
    }
    
    
    @IBAction func fiveHunderedMilimetersPressed(_ sender: UIButton) {
        viewCtrl.rootView.addMilimeters(newMilimeters: 500)
        let currentDrunk = UserDefaults.standard.integer(forKey: "AlreadyDrunk")
        UserDefaults.standard.set(currentDrunk + 500, forKey: "AlreadyDrunk")
    }
}


//
//  WeightPicker.swift
//  WaterMe
//
//  Created by Маркі on 11.12.2020.
//

import UIKit

class WeightPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var weightScroller: UIPickerView!
    let pickerData = [Int](40...200)
    override func viewDidLoad() {
        super.viewDidLoad()

        weightScroller.setValue(UIColor.white, forKey: "textColor")
        weightScroller.delegate = self
        weightScroller.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            // This method is triggered whenever the user makes a change to the picker selection.
            // The parameter named row and component represents what was selected.
        }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(Int(pickerData[weightScroller.selectedRow(inComponent: 0)]), forKey: "Weight")
        if UserDefaults.standard.bool(forKey: "Male") {
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Weight") * 35, forKey: "DailyWater")
        } else {
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Weight") * 30, forKey: "DailyWater")
        }
        UserDefaults.standard.set(0, forKey: "AlreadyDrunk")
        UserDefaults.standard.set(true, forKey: "SendNotifications")
        
        let date = Date()
        let calendar = Calendar.current
        UserDefaults.standard.set(calendar.component(.month, from: date), forKey: "LastLoginMonth")
        UserDefaults.standard.set(calendar.component(.day, from: date), forKey: "LastLoginDay")
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

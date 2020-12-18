//
//  GenderPicker.swift
//  WaterMe
//
//  Created by Маркі on 11.12.2020.
//

import UIKit


class GenderPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameInputField: UITextField!
    @IBOutlet weak var genderScroller: UIPickerView!
    let pickerData = ["Female", "Male"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        genderScroller.setValue(UIColor.white, forKey: "textColor")
        genderScroller.delegate = self
        genderScroller.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if nameInputField.text == "" {
            let alert = UIAlertController(title: "Name error", message: "Do not forget to enter your name!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            if pickerData[genderScroller.selectedRow(inComponent: 0)] == "Male" {
                UserDefaults.standard.set(true, forKey: "Male")
            } else {
                UserDefaults.standard.set(false, forKey: "Male")
            }
            UserDefaults.standard.set(nameInputField.text, forKey: "Name")
            performSegue(withIdentifier: "weightSelectionSegue", sender: self)
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

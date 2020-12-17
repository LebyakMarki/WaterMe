//
//  ImagePicker.swift
//  WaterMe
//
//  Created by Маркі on 17.12.2020.
//

import UIKit

class ImagePicker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        selectButton.layer.cornerRadius = 10
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose image", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageSelected.image = image
        if let data = image.pngData() {
            // Create URL
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent("avatar.png")
            do {
                try data.write(to: url)
                UserDefaults.standard.set(url, forKey: "AvatarURL")
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "AlreadyDrunk")
        UserDefaults.standard.set(true, forKey: "SendNotifications")
        
        let date = Date()
        let calendar = Calendar.current
        UserDefaults.standard.set(calendar.component(.month, from: date), forKey: "LastLoginMonth")
        UserDefaults.standard.set(calendar.component(.day, from: date), forKey: "LastLoginDay")
    }
}

//
//  CalendarStatistics.swift
//  WaterMe
//
//  Created by Маркі on 18.12.2020.
//
import FSCalendar
import UIKit

class CalendarStatistics: UIViewController, FSCalendarDelegate {

    var calendar = FSCalendar()
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendar.delegate = self
        calendar.today = nil
        backButton.layer.cornerRadius = 10
        calendar.allowsMultipleSelection = true
        let doneDays = UserDefaults.standard.array(forKey: "DoneDays")  as? [Date] ?? [Date]()
        for date in doneDays {
            calendar.select(date)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height)
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.eventDefaultColor = .white
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.selectionColor = UIColor(red: 0.38, green: 0.69, blue: 0.35, alpha: 1.0)
        calendar.appearance.titlePlaceholderColor = UIColor(red: 0.13, green: 0.16, blue: 0.19, alpha: 1.00)
        view.addSubview(calendar)
    }

    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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

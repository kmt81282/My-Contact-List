//
//  DateViewController.swift
//  My Contact List
//
//  Created by Marc Turner on 4/3/23.
//

import UIKit
// 1) Create protocol
protocol DateControllerDelegate {
    func dateChanged(date: Date)
}

class DateViewController: UIViewController {
// 2) Create var to refernece protocol
    var delegate: DateControllerDelegate? = nil
    
    // 3) set variable
    @IBOutlet weak var dtpDate: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let saveButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveDate))
        
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Pick Birthdate"
    }
    
    @objc func saveDate() {
        self.delegate?.dateChanged(date: dtpDate.date)
        self.navigationController?.popViewController(animated: true)
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

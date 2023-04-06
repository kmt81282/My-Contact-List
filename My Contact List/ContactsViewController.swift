//
//  ContactsViewController.swift
//  My Contact List
//
//  Created by Marc Turner on 3/25/23.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController, UITextFieldDelegate, DateControllerDelegate {
    
    var currentContact: Contact?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueContactDate") {
                let dateController = segue.destination as! DateViewController
                dateController.delegate = self
            }
        }

    
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtCell: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblBirthdate: UILabel!
    @IBOutlet weak var btnChange: UIButton!

    
    func dateChanged(date: Date) {
        let context = appDelegate.persistentContainer.viewContext
        if currentContact == nil {
            currentContact = Contact(context: context)
        }
        currentContact?.birthday = date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        lblBirthdate.text = formatter.string(from: date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func changeEditMode(_ sender: Any) {
        let textFields: [UITextField] = [txtName, txtAddress, txtCity, txtState, txtZip, txtPhone, txtCell, txtEmail]
        
        for textfield in textFields {
            textfield.addTarget(self, action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEndOnExit)
        }
        
        func textFieldShouldEndEditing(_textField: UITextField) -> Bool {
            if currentContact == nil {
                let context = appDelegate.persistentContainer.viewContext
                currentContact = Contact(context: context)
            }
            currentContact?.contactName = txtName.text
            currentContact?.streetAddress = txtAddress.text
            currentContact?.city = txtCity.text
            currentContact?.state = txtState.text
            currentContact?.zipCode = txtZip.text
            currentContact?.cellNumber = txtCell.text
            currentContact?.phoneNumber = txtPhone.text
            return true
        }
        if sgmtEditMode.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            btnChange.isHidden = true
            navigationItem.rightBarButtonItem = nil
        }
        else if sgmtEditMode.selectedSegmentIndex == 1 {
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            btnChange.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveContact))
        }
    }
    @objc func saveContact() {
    appDelegate.saveContext()
    sgmtEditMode.selectedSegmentIndex = 0
    changeEditMode(self)
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

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


    
    @IBOutlet weak var scrollView: UIScrollView!
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

    override func viewDidLoad() {
            super.viewDidLoad()
            
            if currentContact != nil {
                txtName.text = currentContact!.contactName
                txtAddress.text = currentContact!.streetAddress
                txtCity.text = currentContact!.city
                txtState.text = currentContact!.state
                txtZip.text = currentContact!.zipCode
                txtPhone.text = currentContact!.phoneNumber
                txtCell.text = currentContact!.cellNumber
                txtEmail.text = currentContact!.email
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                if currentContact!.birthday != nil {
                    lblBirthdate.text = formatter.string(from: currentContact!.birthday as! Date)
                }
            }
            
            // Do any additional setup after loading the view.
            self.changeEditMode(self)
            
            let textFields: [UITextField] = [txtName, txtAddress, txtCity, txtState, txtZip, txtPhone, txtCell, txtEmail]
            
            for textfield in textFields {
                textfield.addTarget(self,
                                    action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)),
                                    for: UIControl.Event.editingDidEnd)
            }
        
        
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            currentContact?.contactName = txtName.text
            currentContact?.streetAddress = txtAddress.text
            currentContact?.city = txtCity.text
            currentContact?.state = txtState.text
            currentContact?.zipCode = txtZip.text
            currentContact?.cellNumber = txtCell.text
            currentContact?.phoneNumber = txtPhone.text
            currentContact?.email = txtEmail.text
            return true
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.registerKeyboardNotifications()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.unregisterKeyboardNotifications()
        }
        
        
        @IBAction func changeEditMode(_ sender: Any) {
            let textFields: [UITextField] = [txtName, txtAddress, txtCity,
                                             txtState, txtZip, txtPhone, txtCell, txtEmail]
            if sgmtEditMode.selectedSegmentIndex == 0 {
                for textField in textFields {
                    textField.isEnabled = false
                    textField.borderStyle = UITextField.BorderStyle.none
                }
                btnChange.isHidden = true
                navigationItem.rightBarButtonItem = nil
            }
            else if sgmtEditMode.selectedSegmentIndex == 1{
                for textField in textFields {
                    textField.isEnabled = true
                    textField.borderStyle = UITextField.BorderStyle.roundedRect
                }
                btnChange.isHidden = false
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                    target: self,
                                                                    action: #selector(self.saveContact))
            }
        }
        
        @objc func registerKeyboardNotifications() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(ContactsViewController.keyboardDidShow(notification:)),
                name: UIResponder.keyboardDidShowNotification, object: nil) //You can use any subclass of UIResponder
                NotificationCenter.default.addObserver(
                self,
                selector: #selector(ContactsViewController.keyboardDidShow(notification:)),
                name: UIResponder.keyboardDidHideNotification, object: nil) //You can use any subclass of UIResponder
        }
        
        func unregisterKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self)
        }
        
    @objc func keyboardDidShow(notification: NSNotification) {
            let userInfo: NSDictionary = notification.userInfo! as NSDictionary
            let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
            let keyboardSize = keyboardInfo.cgRectValue.size
            
            // Get the existing contentInset for the scrollView and set the bottom property to be the height of the keyboard
            var contentInset = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.height
            
            self.scrollView.contentInset = contentInset
            self.scrollView.scrollIndicatorInsets = contentInset
        }
        
        func keyboardWillHide(notification: NSNotification) {
            var contentInset = self.scrollView.contentInset
            contentInset.bottom = 0
            
            self.scrollView.contentInset = contentInset
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
        
    @objc func saveContact() {
            if currentContact == nil{
                let context = appDelegate.persistentContainer.viewContext
                currentContact = Contact(context: context)
            }
            appDelegate.saveContext()
            sgmtEditMode.selectedSegmentIndex = 0
            changeEditMode(self)
        }
        
        func dateChanged(date: Date){
            if currentContact != nil {
                currentContact?.birthday = date as Date?
                appDelegate.saveContext()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                lblBirthdate.text = formatter.string(from: date)
            }
        }
        

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "segueContactDate") {
                let dateController = segue.destination as! DateViewController
                dateController.delegate = self
            }
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
     
    }

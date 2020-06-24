//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Thomas.Tay.sg on 15/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesTitleTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var bottomGuide: NSLayoutConstraint!
    
    
    var currentNote: Notes?

    // MARK: Default Template
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //overrideUserInterfaceStyle = .light
        
        notesTitleTextField.delegate = self
        
        if let gotEditNote = currentNote {
            
            notesTitleTextField.text = gotEditNote.title
            notesTextView.text = gotEditNote.notes
            
            self.navigationItem.title = "Edit Note"
        }
        
        checkValidTitle()
        
        notesTitleTextField.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        notesTitleTextField.sizeToFit()
        
        notesTextView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(NotesViewController.keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotesViewController.keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let titleChecked = textField.text ?? ""
        if !titleChecked.isEmpty {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    func checkValidTitle() {
        
        let titleToCheck = notesTitleTextField.text ?? ""
        saveButton.isEnabled = !titleToCheck.isEmpty
        
    }
    
    // MARK: - Notifications
    
    @objc func keyboardShow(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        
        bottomGuide.constant = (keyboardFrame?.height)!
        
    }
    
    @objc func keyboardHide(_ notification: Notification) {
        bottomGuide.constant = 0
    }
    
    
    
    // MARK: Navigation
    @IBAction func cancelNotes(_ sender: UIBarButtonItem) {
        
        notesTitleTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
        
        let isAddMode = presentingViewController is UINavigationController
        if isAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender as AnyObject? === saveButton {
            
            notesTextView.resignFirstResponder()
            notesTitleTextField.resignFirstResponder()
            
            let myTitle = notesTitleTextField.text!
            let myNotes = notesTextView.text
            
            currentNote = Notes(title: myTitle, notes: myNotes!)
            
        }
        
    
    }
    
    

}


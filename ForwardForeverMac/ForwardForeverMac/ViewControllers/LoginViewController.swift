//
//  ViewController.swift
//  ForwardForeverMac
//
//  Created by TørK on 02/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    @IBOutlet weak var topLabel: NSTextField!
    @IBOutlet weak var usernameLabel: NSTextField!
    @IBOutlet weak var passwordLabel: NSTextField!
    @IBOutlet weak var userTextField: NSTextField!
    @IBOutlet weak var passTextField: NSTextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    @IBAction func registerButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.stringValue = "Login"
        usernameLabel.stringValue = "Username"
        passwordLabel.stringValue = "Password"
        userTextField.placeholderString = "Enter Username"
        passTextField.placeholderString = "Enter Password"
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


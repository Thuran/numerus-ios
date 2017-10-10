//
//  ViewController.swift
//  Numerus
//
//  Created by Thuran on 16/05/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        UserRead.login(email: emailInput.text, password: passwordInput.text) { (resp) in
            if(resp)!{
                self.openViewController(storyboardId: "tabBarController")
            }else{
                self.displayAlert(text: "Credenciais incorretas!")
            }
        }
        
    }
    
}


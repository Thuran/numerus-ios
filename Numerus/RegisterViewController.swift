//
//  RegisterViewController.swift
//  Numerus
//
//  Created by Thuran on 19/09/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var photoInput: UITextField!

    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var birthDateInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var passwordConfirmationInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoInput.text = "https://www.fanspole.com/assets/default_user-c283cfbc3d432e22b1d2f1eef515d0b9.png"
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        
        setImageUrl()
    }

    func setImageUrl(){
        if(photoInput.text != ""){
            do{
                let url:NSURL = NSURL(string: photoInput.text!)!
                let data:NSData = try NSData(contentsOf: url as URL)
                self.profileImage.image = UIImage(data: data as Data)
            }catch{
                
            }
        }
        
    }
    
    func isValidEmail(email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @IBAction func chageUrlImage(_ sender: Any) {
        setImageUrl()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func registerTouch(_ sender: Any) {
        
        if(photoInput.text == ""){
            self.displayAlert(text: "A url da foto é obrigatória")
            return
        }
        
        
        if(!isValidEmail(email: emailInput.text!)){
            self.displayAlert(text: "Email inválido!")
            return
        }
        
        if(nameInput.text == ""){
            self.displayAlert(text: "O nome é obrigatório")
            return
        }
        
        if(emailInput.text == ""){
            self.displayAlert(text: "O email é obrigatório")
            return
        }
        
        if(birthDateInput.text == ""){
            self.displayAlert(text: "A data de nasc. é obrigatória")
            return
        }
        
        if(passwordInput.text != passwordConfirmationInput.text){
            self.displayAlert(text: "A senha e a confirmação de senha estão diferentes")
            return
        }
        
        if((passwordInput.text?.characters.count)! < 5){
            self.displayAlert(text: "A senha deve conter mais de 5 caractéres")
            return
        }
        
        
        let user = RegisterModel()
        user.birthDate = birthDateInput.text
        user.email = emailInput.text
        user.name = nameInput.text
        user.password = passwordInput.text
        user.photo = photoInput.text
        
        RegisterModel.create(register: user) { (err) in
            if(err == nil){
                self.displayAlert(text: "Conta criada com sucesso!")
                self.openViewController(storyboardId: "tabBarController")
            }else{
                self.displayAlert(text: err!)
                
            }
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

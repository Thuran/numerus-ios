//
//  ShareFormulaViewController.swift
//  Numerus
//
//  Created by Thuran on 24/10/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import UIKit
import Darwin

class ShareFormulaViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var contextTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(contextGlobal != ""){
            contextTextView.text = contextGlobal
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func shareButtonTouch(_ sender: Any) {
        
        
        let formula = FormulaCreate()
        formula.authorId = (userGlobal?.id)!
        formula.context = contextTextView.text
        formula.name = titleTextView.text
        formula.rating = String(arc4random_uniform(11))
        
        if(contextTextView.text == ""){
            self.displayAlert(text: "A fórmula inválida!")
            return
        }
        
        if(titleTextView.text == ""){
            self.displayAlert(text: "Preencha o nome da fórmula!")
        }
        
        FormulaCreate.create(formula: formula){ (err) in
            if(err == nil){
                self.success()
                return
            }else{
                self.displayAlert(text: err!)

            }
        }
        
    }
    
    func success(){
        let alert = UIAlertController(title: "Numerus", message: "Fórmula compartilhada com sucesso!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
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

//
//  AddFormulaViewController.swift
//  Numerus
//
//  Created by Thuran on 20/10/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import UIKit

class AddFormulaViewController: UIViewController {

    @IBOutlet weak var expressionTextView: UITextView!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func calculateButtonTouch(_ sender: Any) {
        let math = CalculateExpression()
        math.expr = [expressionTextView.text]
        math.precision = 14
        CalculateExpression.calculate(expr: math){ (response, err) in
            if(err == nil){
                if(response?.error == nil){
                    self.expressionTextView.text = response?.result[0]
                }else{
                    self.displayAlert(text: (response?.error!)!)
                }
            }else{
                self.displayAlert(text: err!)
                
            }
        }
        
    }
    @IBAction func shareButtonTouch(_ sender: Any) {
        contextGlobal = expressionTextView.text
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

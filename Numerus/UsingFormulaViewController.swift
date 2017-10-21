//
//  UsingFormulaViewController.swift
//  Numerus
//
//  Created by Thuran on 20/10/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import UIKit

class UsingFormulaViewController: UIViewController {
    
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var formulaName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var expression: UITextView!
    @IBOutlet weak var rating: UILabel!
    
    var expressionString = ""
    var formulaNameString = ""
    var authorImageString = ""
    var authorNameString = ""
    var ratingString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: authorImageString) {
            if let data = NSData.init(contentsOf: url) {
                authorImage.image = UIImage(data: data as Data)
            }
        }
        authorImage.layer.cornerRadius = 0.5 * authorImage.bounds.size.width
        authorImage.clipsToBounds = true
        authorName.text = authorNameString
        formulaName.text = formulaNameString
        rating.text = ratingString
        expression.text = expressionString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

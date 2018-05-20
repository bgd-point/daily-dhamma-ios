//
//  ViewController.swift
//  Daily Dhamma
//
//  Created by Martien DT on 5/20/18.
//  Copyright © 2018 Martien Dermawan Tanama. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var questionTextView: UITextView!
    
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello World");
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        print(ref)
        
        ref.child("dhamma-today").observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            print(value)
            
            let questionHtml = value["question"] as? String ?? ""
            let answerHtml = value["answer"] as? String ?? ""
            
            let questionHtmlData = NSString(string: questionHtml).data(using: String.Encoding.unicode.rawValue)
            let answerHtmlData = NSString(string: answerHtml).data(using: String.Encoding.unicode.rawValue)
            
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            
            let questionAttributedString = try! NSAttributedString(data: questionHtmlData!, options: options, documentAttributes: nil)
            let answerAttributedString = try! NSAttributedString(data: answerHtmlData!, options: options, documentAttributes: nil)
            
            // self.questionTextView.isScrollEnabled = false
            self.questionTextView.isEditable = false
            self.questionTextView.attributedText = questionAttributedString
            self.questionTextView.sizeToFit()
            
            self.answerTextView.isScrollEnabled = false
            self.answerTextView.isEditable = false
            self.answerTextView.attributedText = answerAttributedString
            self.answerTextView.sizeToFit()
            
            
        })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


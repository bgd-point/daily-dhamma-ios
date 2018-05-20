//
//  RandomViewController.swift
//  Daily Dhamma
//
//  Created by Martien DT on 5/21/18.
//  Copyright © 2018 Martien Dermawan Tanama. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RandomViewController: UIViewController {
    
    @IBOutlet var questionTextView: UITextView!
    
    @IBOutlet var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
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
            
            
            self.questionTextView.isScrollEnabled = false
            self.questionTextView.isEditable = false
            self.questionTextView.attributedText = questionAttributedString
            self.questionTextView.sizeToFit()
            self.questionTextView.font = .systemFont(ofSize: 14)
            
            self.answerTextView.isScrollEnabled = false
            self.answerTextView.isEditable = false
            self.answerTextView.attributedText = answerAttributedString
            self.answerTextView.sizeToFit()
            self.answerTextView.font = .systemFont(ofSize: 14)
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


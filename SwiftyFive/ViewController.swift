//
//  ViewController.swift
//  SwiftyFive
//
//  Created by Grant Warman on 6/26/14.
//  Copyright (c) 2014 BottleCap. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField
    @IBOutlet var label: UILabel
    @IBOutlet var party: UILabel

    
    var names: Array<String>
    var presses: Int = 0
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        names = Array<String>()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Who's at your party?"
        textField.delegate = self
        
        var keyboardDoneView: UIToolbar = UIToolbar()
        keyboardDoneView.sizeToFit()
        
        var spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: "doneClicked:")
        keyboardDoneView.setItems([spacer, doneButton], animated: false)
        textField.inputAccessoryView = keyboardDoneView


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneClicked(AnyObject){
        textField.resignFirstResponder()

        var dareController: DareController? = DareController()
        dareController!.names = names
        
        self.navigationController.pushViewController(dareController, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool{
        var text = textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if text.utf16count > 0{
            var name = text.substringToIndex(1).uppercaseString + text.substringFromIndex(1)
            
            names.append(name)
            party.text = "\n".join(names)
            party.sizeToFit()
            textField.text = ""
        }
        return true
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

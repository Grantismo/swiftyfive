//
//  DareController.swift
//  SwiftyFive
//
//  Created by Grant Warman on 6/27/14.
//  Copyright (c) 2014 BottleCap. All rights reserved.
//

import UIKit

class DareController: UIViewController {
    
    @IBOutlet var label: UILabel
    var names: Array<String> = []

    
    convenience init(){
        self.init(nibName: nil, bundle: nil)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = self.dareText()
        label.sizeToFit()
        
        var nextButton: UIBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "nextDare:")
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = nextButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dareText() -> String{
        var nextDareText: String
        if let dareText = DareManager().dare(names){
            
            nextDareText = dareText
        }else{
            nextDareText = "not enough people for that dare :P"
        }
        return nextDareText
    }
    
    @IBAction func nextDare(AnyObject){
        var dareController: DareController? = DareController()
        dareController!.names = names
        
        self.navigationController.pushViewController(dareController, animated: true)
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

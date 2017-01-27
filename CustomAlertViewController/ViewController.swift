//
//  ViewController.swift
//  CustomAlertViewController
//
//  Created by Sagar Mane on 23/01/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func alertButtonSelected(_ sender: Any) {
        let actionArray: NSMutableArray = NSMutableArray()
        actionArray.add("Show Profile")
        actionArray.add("Call")
        
        let alertController:CustomAlertViewController = CustomAlertViewController(headerImage: UIImage(named: "userProfile")!,
                                                                                  headerTitle: "Edmond Halley",
                                                                                  headerSubText: "Technical Lead",
                                                                                  actionArray: actionArray) as CustomAlertViewController
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }

}


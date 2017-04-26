//
//  ViewController.swift
//  CustomAlertViewController
//
//  Created by Sagar Mane on 23/01/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

enum ItemIndex {
    case ProfileIndex
    case CallIndex
}

class ViewController: UIViewController, CustomAlertViewControllerDelegate {

    func getItemDictionary(title: String, index: ItemIndex) -> NSMutableDictionary {
        
        let dictionary = NSMutableDictionary()
        dictionary.setObject(title, forKey: "title" as NSCopying)
        dictionary.setObject(index, forKey: "index" as NSCopying)
        
        return dictionary
    }
    
    @IBAction func alertButtonSelected(_ sender: Any) {
        let actionArray: NSMutableArray = NSMutableArray()
        
        var itemDictionary  = getItemDictionary(title: "Show Profile", index: ItemIndex.ProfileIndex)
        actionArray.add(itemDictionary)
        
        itemDictionary  = getItemDictionary(title: "Call", index: ItemIndex.CallIndex)
        actionArray.add(itemDictionary)
        
        let alertController:CustomAlertViewController = CustomAlertViewController(headerImage: UIImage(named: "userProfile")!,
                                                                                  headerTitle: "Edmond Halley",
                                                                                  headerSubText: "Tech Lead",
                                                                                  actionArray: actionArray) as CustomAlertViewController
        alertController.delegate = self
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    /* This is callback method from CustomAlertViewController about item selection */
    
    func OptionSelected(itemDictionary: NSMutableDictionary) {
        
        let index = itemDictionary.object(forKey: "index") as! ItemIndex
        
        switch index {
        case .ProfileIndex:
            print("Profile option selected")
        case .CallIndex:
            print("Call option selected")
        }
    }
}


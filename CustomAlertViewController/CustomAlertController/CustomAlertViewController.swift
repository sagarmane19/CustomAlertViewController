//
//  CustomAlertViewController.swift
//  mangoios
//
//  Created by Sagar Mane on 20/01/17.
//
//

import UIKit

class DocumentHeaderView: UIView {
    
    @IBOutlet
    var headerImageView: UIImageView?
    
    @IBOutlet
    var headerNameLabel: UILabel?
    
    @IBOutlet
    var headerSubTextLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class DocumentHeaderCell: UITableViewCell {
    
    @IBOutlet
    var headerImageView: UIImageView?
    
    @IBOutlet
    var headerNameLabel: UILabel?
    
    @IBOutlet
    var headerSubTextLabel: UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

@objc protocol CustomAlertViewControllerDelegate {
    func OptionSelected(optionText: NSString)
}

class CustomAlertViewController: UIAlertController, UITableViewDataSource, UITableViewDelegate {
    
    var controller: UITableViewController
    var myHeaderImage: UIImage?
    var myHeaderTitle: String?
    var myHeaderSubText: String?
    
    var delegate: CustomAlertViewControllerDelegate?
    var myactionArray: NSMutableArray?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        controller = UITableViewController(style: .plain)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        controller.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        controller.tableView.dataSource = self
        controller.tableView.delegate = self
        controller.tableView.addObserver(self, forKeyPath: "contentSize", options: [.initial, .new], context: nil)
        self.setValue(controller, forKey: "contentViewController")
    }
    
    convenience init(headerImage: UIImage,
                     headerTitle: String?,
                     headerSubText:String?,
                     actionArray: NSMutableArray) {
        self.init(nibName: nil, bundle: nil)
        myHeaderImage = headerImage
        myHeaderTitle = headerTitle
        myHeaderSubText = headerSubText
        
        myactionArray = NSMutableArray(array: actionArray);
        
        controller.tableView.rowHeight = UITableViewAutomaticDimension
        controller.tableView.estimatedRowHeight = 44
        
        controller.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        controller.tableView.estimatedSectionHeaderHeight = 25;
        
        controller.tableView.register(UINib(nibName: "DocumentHeaderCell", bundle: nil), forCellReuseIdentifier: "DocumentHeaderCell")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentSize" else {
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            controller.preferredContentSize = CGSize(width: 300, height: controller.tableView.contentSize.height)
        }
        else {
            controller.preferredContentSize = controller.tableView.contentSize
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        controller.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("DocumentHeaderView", owner: self, options: nil)?.first as! DocumentHeaderView
        headerView.headerImageView?.image       = myHeaderImage
        headerView.headerNameLabel?.text        = myHeaderTitle
        headerView.headerSubTextLabel?.text     = myHeaderSubText
        return headerView
    }
    
    /*func headerView(forSection section: Int) -> UITableViewHeaderFooterView {
        let headerFooterView:UITableViewHeaderFooterView = UITableViewHeaderFooterView()
        
        let headerView:DocumentHeaderView = DocumentHeaderView()
        headerView.headerImageView?.image       = myHeaderImage
        headerView.headerNameLabel?.text        = myHeaderTitle
        headerView.headerSubTextLabel?.text     = myHeaderSubText
        headerFooterView.contentView.addSubview(headerView)
        return headerFooterView
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myactionArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "Identifier_\(indexPath.section)"
        
        let title: String = myactionArray?.object(at: indexPath.row) as! String
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:identifier)
        }
        cell?.textLabel?.text = title
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 18.0)
        cell?.textLabel?.textColor = UIColor.init(colorLiteralRed: 35/255, green: 115/255, blue: 251/255, alpha: 1.0)
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.dismiss(animated: true, completion: {
            let title: NSString = self.myactionArray?.object(at: indexPath.row) as! NSString
            self.delegate?.OptionSelected(optionText: title)
        })
    }
}

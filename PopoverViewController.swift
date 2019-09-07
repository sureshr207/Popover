//
//  PopoverViewController.swift
//  PopoverViewController
//
//  Created by Suresh on 7/9/19.
//  Copyright © 2019 Suresh All rights reserved.
//

import Foundation
import UIKit

public typealias list = [String]

open class CustomPopover: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    // Public properties
    open var sender = UIView()
    open var dropdownList = [String]()
    open var size: CGSize = CGSize(width: 250, height: 219)
    open var arrowDirection: UIPopoverArrowDirection = .any
    open var separatorColor: UIColor = .lightGray
    open var borderColor: UIColor = .lightGray
    open var borderWidth: CGFloat = 1
    open var barHeight: CGFloat = 44
    open var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 19)
    open var titleColor: UIColor = .blue
    open var textFont: UIFont = UIFont.systemFont(ofSize: 17)
    open var textColor: UIColor = .black
    open var selectedData: list?
    open var arrowBackgroundColor: UIColor = .lightGray
    
    // Public closures
    open var didSelectDataHandler: ((_ selectedData: String?) -> ())?
    
    // Private constants
    fileprivate let cellIdentifier = "Cell"
    
    // Private properties
    fileprivate var navigationBar: UINavigationBar!
    fileprivate var titleLabel: UILabel!
    fileprivate var tableView: UITableView!
    
    public init(for sender: UIView, title: String, didSelectDataHandler: ((_ selectedData: String?) -> ())? = nil) {
        super.init(nibName: nil, bundle: nil)
        if title.isEmpty {
            barHeight = 0
        }
        modalPresentationStyle = .popover
        setSourceView(sender)
        self.sender = sender
        self.title = title
        self.didSelectDataHandler = didSelectDataHandler
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationBar()
        addTableView()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setProperties()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // Set position for the popover coordinating with the sender
    open func setSourceView(_ sender: UIView) {
        guard let popoverPC = popoverPresentationController else { return }
        popoverPC.sourceView = sender
        popoverPC.sourceRect = sender.bounds
        popoverPC.delegate = self
        
    }
    
    open func reloadData() {
        if tableView != nil {
            titleLabel.text = self.title ?? ""
            tableView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    // Set properties based on options passed to the initializer
    fileprivate func setProperties() {
        guard let popoverPC = popoverPresentationController else { return }
        popoverPC.permittedArrowDirections = arrowDirection
        popoverPC.backgroundColor = arrowBackgroundColor
        size.height = CGFloat(dropdownList.count * 44)
        preferredContentSize = size
        view.frame.size = size
        view.superview?.layer.cornerRadius = 0
        view.superview?.layer.borderWidth = borderWidth
        view.superview?.layer.borderColor = borderColor.cgColor
        
        setNavigationBar()
        setTableView()
    }
    
    // Add navigation bar and table view
    fileprivate func addNavigationBar() {
        if barHeight == 0 { return }
        
        navigationBar = UINavigationBar()
        titleLabel = UILabel()
        navigationBar.addSubview(titleLabel)
        view.addSubview(navigationBar)
    }
    
    fileprivate func addTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    }
    
    // Set navigation bar properties
    fileprivate func setNavigationBar() {
        if barHeight == 0 { return }
        
        // Set navigation bar
        navigationBar.frame = CGRect(x: 0, y: 0, width: size.width, height: barHeight)
        
        // Set title
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.text = self.title ?? ""
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.frame.origin = CGPoint(x: (size.width - titleLabel.frame.width)/2, y: (barHeight - titleLabel.frame.height)/2)
    }
    
    // Set table view properties
    fileprivate func setTableView() {
        tableView.frame = CGRect(x: 0, y: barHeight, width: size.width, height: size.height - barHeight)
        tableView.separatorInset.left = 0
        tableView.separatorColor = separatorColor
    }
    
    // MARK: - TableView Delegate Methods
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownList.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        cell.textLabel?.text = dropdownList[indexPath.row]
        cell.textLabel?.font = textFont
        cell.textLabel?.textColor = textColor
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        didSelectDataHandler?(dropdownList[indexPath.row])
    }
    
    // MARK: - PopoverPC Delegate Methods
    
    open func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

//
//  ViewController.swift
//  MVVM-Rxswift
//
//  Created by dengrui on 16/5/12.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit
import RxSwift
//屏幕的长宽
let kScreenWidth = UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height
private let kMessageCell = "kMessageCell"

class ViewController: UIViewController {
    
    private let messagesViewModel = DRWMessageViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupUI() {
    
        view.addSubview(tableView)
        let nib = UINib(nibName: "DRWMessageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: kMessageCell)
 
    }
    
    private func requestData() {
    
        messagesViewModel.loadMessage().subscribe(onNext: { (count) -> Void in
            
            }, onError: { (error) -> Void in
                
            }, onCompleted: { () -> Void in
                
            }) { () -> Void in
                
                self.tableView.reloadData()
                
        }.addDisposableTo(disposeBag)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        return tableView
    }()

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return messagesViewModel.messages?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kMessageCell, forIndexPath: indexPath) as! DRWMessageCell
        cell.message = messagesViewModel.messages![indexPath.row]
        return cell
    }
    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 120
//    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
}
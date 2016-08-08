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
    var dataSource: [DRResult<DRWMessageModel>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        requestPullDown()
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
    /**
     下拉刷新
     */
    private func requestPullDown() {
        weak var tempSelf = self
        messagesViewModel.loadMessage(false).subscribeNext { (success) -> Void in
            if success {
            tempSelf!.dataSource = tempSelf!.messagesViewModel.list
            }
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
    }
    /**
     上拉加载-由于数据没有加分页,所以嘿嘿你懂得 这里 只是写一个例子
     */
//    private func requestPullUp() {
//        weak var tempSelf = self
//        messagesViewModel.loadMessage(false).subscribeNext { (success) -> Void in
//            if success {
//                tempSelf!.dataSource = tempSelf!.messagesViewModel.list
//            }
//            self.tableView.reloadData()
//            }.addDisposableTo(disposeBag)
//    }
    
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

        return dataSource?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kMessageCell, forIndexPath: indexPath) as! DRWMessageCell
        cell.message = dataSource![indexPath.row].element
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
}
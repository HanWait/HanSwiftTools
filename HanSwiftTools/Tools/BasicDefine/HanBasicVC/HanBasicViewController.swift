//
//  HanBasicViewController.swift
//  HanSwiftTools
//
//  Created by Han on 2019/6/26.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanBasicViewController: UIViewController {
    
    
    var navView:HanBasicNavigationView!
    var tableView:UITableView?
    var dataSourceArray:[(Any)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        
        self.createUI()
       
    }
    
    //MARK: - 创建UI视图
    /// 创建顶部 导航栏
    private func createUI(){
        
        self.view.backgroundColor = UIColor.white
        
        navView = HanBasicNavigationView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: kTopHeight))
        navView.leftBtn.addTarget(self, action: #selector(leftBtnClicked), for: .touchUpInside)
        navView.rightBtn.addTarget(self, action: #selector(rightBtnClicked), for: .touchUpInside)
        self.view.addSubview(navView)
    }
    /// 创建表
    private func createTableView(top: CGFloat,bottom:CGFloat,isTop:Bool,isGroup:Bool){
        if isGroup == true{
            tableView = UITableView.init(frame: CGRect.init(x: 0, y: kTopHeight + top, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (kTopHeight + top) - bottom), style: .grouped)
        }else{
            tableView = UITableView.init(frame: CGRect.init(x: 0, y: kTopHeight + top, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (kTopHeight + top) - bottom))
        }
        tableView?.layer.masksToBounds = true
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }
    
    func createTableView(top: CGFloat,bottom:CGFloat,isTop:Bool) {
        
    }
    
    
    //MARK: - 按钮点击事件
    /// 返回（左边）按钮点击事件
    @objc func leftBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    /// 右边按钮点击事件
    @objc func rightBtnClicked() {
    }

}
extension HanBasicViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.0000001
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.0000001
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

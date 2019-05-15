//
//  HanProgressVC.swift
//  HanSwiftTools
//
//  Created by Han on 2019/5/14.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

class HanProgressVC: UIViewController {
    /// 普通单色直线进度条
    @IBOutlet weak var hanPStraightProgressView: HanProgressView!
    /// 动态单色直线进度条
    @IBOutlet weak var hanPStraightMoveProgressView: HanProgressView!
    /// 普通多色直线进度条
    @IBOutlet weak var hanPStraightColorsProgressView: HanProgressView!
    /// 动态多色直线进度条
    @IBOutlet weak var hanPStraightMoveColorsProgressView: HanProgressView!
    private var progress:CGFloat = 0.1
    override func viewDidLoad() {
        super.viewDidLoad()

        self.straightProgressView()
        self.straightMoveProgressView()
        self.straightProgressColorsView()
        self.straightMoveProgressColorsView()
        
        
    }

    
    private func straightProgressView() {
        self.progress = 0.5
        hanPStraightProgressView.progress = self.progress
        hanPStraightProgressView.type = .straight
        hanPStraightProgressView.colorArray = [UIColor.brown.cgColor]
        hanPStraightProgressView.bgProgressColor = UIColor.orange

    }
    private func straightMoveProgressView() {
        hanPStraightProgressView.type = .straight
        hanPStraightMoveProgressView.moveProgress = 0.8
    }
    private func straightProgressColorsView() {
        
        self.progress = 0.5
        hanPStraightColorsProgressView.progress = self.progress
        hanPStraightColorsProgressView.colorArray = [UIColor.cyan.cgColor,UIColor.purple.cgColor,UIColor.green.cgColor]
        hanPStraightColorsProgressView.bgProgressColor = UIColor.red
        hanPStraightColorsProgressView.type = .straightGradient
    }
    private func straightMoveProgressColorsView() {
        hanPStraightMoveColorsProgressView.type = .straightGradient
        hanPStraightMoveColorsProgressView.colorArray = [UIColor.red.cgColor,UIColor.blue.cgColor]
        hanPStraightMoveColorsProgressView.moveProgress = 0.8
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        
        
        if self.progress >= 0.999999{
            self.progress = 0
        }else{
            self.progress = self.progress  + 0.1
        }
        
        hanPStraightProgressView.progress = self.progress
        hanPStraightMoveProgressView.moveProgress = self.progress
        
        hanPStraightColorsProgressView.progress = self.progress
        hanPStraightMoveColorsProgressView.moveProgress = self.progress
        
    }
    
}

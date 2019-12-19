//
//  HanReachability.swift
//  HanNetworkSwift
//
//  Created by Han on 2019/12/18.
//  Copyright © 2019 Han. All rights reserved.
//

import UIKit

public enum HanNetworkStatus {
       case HanNotReachable
       case HanWiFi
       case HanWWAN
   }

public protocol HanNetworkDelegate {
    func hanNetworkStatus(_ status:HanNetworkStatus)
}

class HanReachability: NSObject {
    
    
    typealias HanNetBlock = (_ status:HanNetworkStatus) -> Void
    
    private var reachability: Reachability?
    
    
    public var hanNetBlock:HanNetBlock?
    
    open var delegate:HanNetworkDelegate?
    
    
    static let shared: HanReachability = {
        let instance = HanReachability()
        return instance
    }()

    override init() {
       super.init();
        self.addReachability()
        self.addNotification()
    }
    
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(addReachability), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func addReachability()  {
        self.stopNotifier()
        self.reachability = try! Reachability.init(hostname: "www.apple.com")
        NotificationCenter.default.addObserver(
                          self,
                          selector: #selector(reachabilityChanged(_:)),
                          name: .reachabilityChanged,
                          object: nil
                      )
        self.startNotifier()
    }
    
    @objc private func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            if ((self.hanNetBlock) != nil) {
                self.hanNetBlock?(HanNetworkStatus.HanWiFi)
            }
            if ((self.delegate) != nil){
                self.delegate?.hanNetworkStatus(HanNetworkStatus.HanWiFi)
            }
            break
        case .cellular:
            if ((self.hanNetBlock) != nil) {
                self.hanNetBlock?(HanNetworkStatus.HanWWAN)
            }
            if ((self.delegate) != nil){
                self.delegate?.hanNetworkStatus(HanNetworkStatus.HanWWAN)
            }
            break
        case .unavailable:
            if ((self.hanNetBlock) != nil) {
                self.hanNetBlock?(HanNetworkStatus.HanNotReachable)
            }
            if ((self.delegate) != nil){
                self.delegate?.hanNetworkStatus(HanNetworkStatus.HanNotReachable)
            }
            break
        default:
            if ((self.hanNetBlock) != nil) {
                self.hanNetBlock?(HanNetworkStatus.HanNotReachable)
            }
            if ((self.delegate) != nil){
                self.delegate?.hanNetworkStatus(HanNetworkStatus.HanNotReachable)
            }
            break
        }
    }
    
    
    deinit {
        stopNotifier()
    }
    
   private func stopNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
   private func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
}


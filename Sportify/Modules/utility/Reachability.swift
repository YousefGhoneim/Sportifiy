//
//  Reachability.swift
//  Sportify
//
//  Created by Ahmed on 5/22/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

import Reachability

class ReachabilityManager {

    static let shared = ReachabilityManager()
    private var reachability: Reachability?

    // Notification name
    static let reachabilityChangedNotification = Notification.Name("ReachabilityChanged")

    private init() {
        do {
            reachability = try Reachability()
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

        reachability?.whenReachable = { _ in
            NotificationCenter.default.post(name: ReachabilityManager.reachabilityChangedNotification, object: true)
        }

        reachability?.whenUnreachable = { _ in
            NotificationCenter.default.post(name: ReachabilityManager.reachabilityChangedNotification, object: false)
        }
    }

    var isConnected: Bool {
        return reachability?.connection != .unavailable
    }

    deinit {
        reachability?.stopNotifier()
    }
}

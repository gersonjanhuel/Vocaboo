//
//  AppDelegate.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import SwiftUI
import CloudKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // read the userInfo payload
        if let category = userInfo["aps"] as? NSDictionary {
            if let categoryName = category["category"] as? String, categoryName == "TrendingVocab" {
                // post a notification to refresh the trending vocabs list
                NotificationCenter.default.post(name: .trendingUpdateNotification, object: nil)
            }
        }
    }
    
}

// custom Notification Name
extension Notification.Name {
    static let trendingUpdateNotification = Notification.Name("trendingUpdateNotification")
}

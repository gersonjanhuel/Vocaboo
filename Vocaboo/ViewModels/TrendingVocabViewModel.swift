//
//  TrendingVocabViewModel.swift
//  Vocaboo
//
//  Created by Gerson Janhuel on 02/08/21.
//

import Foundation
import CloudKit

class TrendingVocabViewModel: ObservableObject {
    // our array of trending vocabularies
    @Published var trendingVocabs: [TrendingVocab] = []
    
    // our CloudKit Public database
    let database = CKContainer(identifier: "iCloud.gersonjanhuel.VocabooTest").publicCloudDatabase
    
    // query our data from CloudKit
    func fetchTrendingVocabs() {
        // CloudKit query from our record type
        let query = CKQuery(recordType: "TrendingVocab", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: .default) { records, error in
            guard let records = records, error == nil else { return }
            
            // cast all records become TrendingVocab model and add it to our array
            DispatchQueue.main.async { [self] in
                self.trendingVocabs = records.compactMap { TrendingVocab(id: UUID(), recordID: $0.recordID, word: $0["word"] as! String) }
            }
        }
    }
    
    // subscribe to database change
    func subscribeToCloudKitDatabase() {
        let subscriptionID = "trending-vocab-list-updated"
        let subscriptionSavedKey = "ckSubscriptionSaved"
        
        // Use a local flag to avoid saving the subscription more than once.
        let alreadySaved = UserDefaults.standard.bool(forKey: subscriptionSavedKey)
        guard !alreadySaved else {
            return
        }
        
        // create query subscription
        let subscription = CKQuerySubscription(recordType: "TrendingVocab", predicate: NSPredicate(value: true), subscriptionID: subscriptionID, options: [.firesOnRecordCreation, .firesOnRecordDeletion, .firesOnRecordUpdate])
        
        // setup notification for silent push notification
        let notification = CKSubscription.NotificationInfo()
        notification.shouldSendContentAvailable = true
        notification.category = "TrendingVocab"

        subscription.notificationInfo = notification
        
        // create the subscription modification operation 
        let operation = CKModifySubscriptionsOperation(subscriptionsToSave: [subscription], subscriptionIDsToDelete: [])
        operation.modifySubscriptionsCompletionBlock = { (_, _, error) in
            guard error == nil else { return }
            
            // success, then save to User Default
            UserDefaults.standard.set(true, forKey: subscriptionSavedKey)
        }
        operation.qualityOfService = .utility
            
        database.add(operation)
    }
}

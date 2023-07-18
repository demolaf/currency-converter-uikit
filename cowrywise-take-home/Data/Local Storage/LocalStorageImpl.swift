//
//  LocalStorageRepositoryImpl.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import Foundation
import RealmSwift

class LocalStorageImpl: LocalStorage {
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
        debugPrint(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func read() {
        
    }
    
    func write() {
        
    }
}

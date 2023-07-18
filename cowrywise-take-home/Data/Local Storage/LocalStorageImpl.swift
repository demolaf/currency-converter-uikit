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
        // debugPrint(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func create<ObjectType: Object>(object: ObjectType) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func read<ObjectType: Object>(object: ObjectType.Type, completion: @escaping (ObjectType?, Error?) -> Void) {
        do {
            try realm.write {
                let object = realm.object(ofType: ObjectType.self, forPrimaryKey: ObjectType.primaryKey())
                completion(object, nil)
            }
        } catch {
            debugPrint(error)
            completion(nil, error)
        }
    }
    
    func readAll<ObjectType: Object>(object: ObjectType.Type, completion: @escaping (Results<ObjectType>?, Error?) -> Void) {
        do {
            try realm.write {
                let results = realm.objects(object)
                completion(results, nil)
            }
        } catch {
            debugPrint(error)
            completion(nil, error)
        }
    }
}

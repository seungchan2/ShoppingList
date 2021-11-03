//
//  RealmModel.swift
//  ShoppingList
//
//  Created by 김승찬 on 2021/11/03.
//

import Foundation
import RealmSwift

class Product: Object {
    @Persisted var productTitle: String     // 제목 (필수)
    @Persisted var isChecked: Int // 내용 (옵션)
    @Persisted var isStared: Int // 즐겨찾기 기능 (필수)
    

    // PK 필수: Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(productTitle: String){
        self.init()
        
        self.productTitle = productTitle
        self.isChecked = 0
        self.isStared = 0
        // 지금 사용하고 있지 않아서 false

    }
     
    
}

//
//  Model.swift
//  BellMemoApp
//
//  Created by Byeol Kim on 9/21/24.
//

import UIKit

struct Memo: Equatable {
    let id: String = UUID().uuidString
    var title: String
    var content: String
//    var category: Category
}

//enum Category: String, CaseIterable {
//    case work = "업무"
//    case personal = "개인"
//    case ideas = "아이디어"
//    case todos = "할 일"
//}

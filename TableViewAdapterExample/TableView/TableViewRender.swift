//
//  TableViewRender.swift
//  TableViewAdapterExample
//
//  Created by seokho on 2021/06/28.
//

import UIKit
import RxSwift
import RxCocoa

protocol Item: Equatable {
    var displayName: String { get }
}

struct TableViewRender<T: Item> {
    private let data: [T]
    private var lastSeleted: T?
    let selected = PublishSubject<T>()

    var counter: Int {
        return data.count
    }

    func getItem(_ index: Int) -> T? {
        if self.counter > index {
            return data[index]
        }

        return nil
    }

    func isSeleted(_ index: Int) -> Bool {
        if data[index] == lastSeleted {
            return true
        }

        return false
    }

    init(data: [T]) {
        self.data = data
    }
}

//
//  TableViewAdapter.swift
//  TableViewAdapterExample
//
//  Created by seokho on 2021/06/28.
//
import Foundation
import UIKit

class TableViewAdapter<T: Item>: NSObject, UITableViewDataSource, UITableViewDelegate {
    let render: TableViewRender<T>

    init(
        render: TableViewRender<T>
    ) {
        self.render = render

    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return render.counter
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExampleCell.self), for: indexPath) as? ExampleCell else {
            return UITableViewCell()
        }

        cell.config(name: render.getItem(indexPath.row)?.displayName ?? "")
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let seletedData = render.getItem(indexPath.row) {
            render.selected.onNext(seletedData)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    deinit {
        Swift.print("날라간다.")
    }
}

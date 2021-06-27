//
//  ViewController.swift
//  TableViewAdapterExample
//
//  Created by seokho on 2021/06/28.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    lazy var mapper = ViewMapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        let tableView = mapper.mapTableView()
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Swift.print("로드완료")
    }


}

struct ViewMapper {
    
    func mapTableView() -> UITableView {
        return UITableView().then {
            let render = TableViewRender(data: Job.allCases)
            let adapter = TableViewAdapter(render: render)
            $0.dataSource = adapter
            $0.delegate = adapter
            
            $0.reloadData()
        }
    }
}

enum Job: String, Item, CaseIterable {
    
    case student
    case teacher
    case actor
    case backer
    case chef
    case doctor
    
    var displayName: String {
        self.rawValue
    }
}

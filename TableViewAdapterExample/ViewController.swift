//
//  ViewController.swift
//  TableViewAdapterExample
//
//  Created by seokho on 2021/06/28.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewBindable {
    var cellSeleted: PublishRelay<String> { get }
    
    var seletedData: Signal<String> { get}
    
    var disposeBag: DisposeBag { get }
}

struct ViewModel: ViewBindable {
    //input
    let cellSeleted = PublishRelay<String>()
    
    //output
    let seletedData: Signal<String>
    
    let disposeBag = DisposeBag()
    
    init() {
        seletedData = cellSeleted
            .asSignal(onErrorSignalWith: .empty())
    }
}

class ViewController: UIViewController {
    
    lazy var mapper = ViewMapper()
    
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        let tableView = mapper.mapTableView(viewModel: viewModel)
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.bind(viewModel: viewModel)
    }
    
    func bind(viewModel: ViewBindable) {
        
        viewModel.seletedData
            .emit(onNext: {
                Swift.print($0)
            })
            .disposed(by: disposeBag)
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Swift.print("로드완료")
    }

}

struct ViewMapper {
    
    lazy var render = TableViewRender(data: Job.allCases)
    lazy var adapter = TableViewAdapter(render: render)
    
    mutating func mapTableView(viewModel: ViewBindable) -> UITableView {
        let tableView = UITableView()
        tableView.register(ExampleCell.self, forCellReuseIdentifier: String(describing: ExampleCell.self))
        tableView.dataSource = adapter
        tableView.delegate = adapter
        
        render.selected
            .map { $0.displayName }
            .bind(to: viewModel.cellSeleted)
            .disposed(by: viewModel.disposeBag)
        
        return tableView
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

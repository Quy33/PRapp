//
//  ViewController.swift
//  PRapp
//
//  Created by Mcrew Tech on 27/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPlusOne: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnDeleteAll: UIButton!
    @IBOutlet weak var txtFieldAdd: UITextField!
    @IBOutlet weak var switchBtn: UIButton!
    
    let dataSource = PublishRelay<[Product]>()
    let bag = DisposeBag()
    let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DataBinding()
    }
    
    func DataBinding(){
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "cell")){
            index, model, cell in
            cell.textLabel?.text = model.item
        }.disposed(by: bag)
        var array = [Product(item: "hello")]
        viewModel.items.accept(array)
        viewModel.items.bind(to: dataSource).disposed(by: bag)
        
        btnPlusOne.rx.tap.asDriver().drive(onNext: {
            if !self.txtFieldAdd.text!.isEmpty{
                array.append(Product(item: self.txtFieldAdd!.text!))
            }
            self.viewModel.items.accept(array)
            self.viewModel.items.bind(to: self.dataSource)
                .disposed(by: self.bag)
            self.txtFieldAdd.text = ""
        })
        .disposed(by: bag)
        
        btnDeleteAll.rx.tap.asDriver().drive(onNext: {
            array.removeAll()
            self.viewModel.items.accept(array)
            self.viewModel.items.bind(to: self.dataSource)
                .disposed(by: self.bag)
        })
        .disposed(by: bag)
        
        self.tableView.rx
            .modelSelected(Product.self)
            .bind{ item in
                self.viewModel.items.accept(array)
                let DetailVC = (self.storyboard?.instantiateViewController(identifier: "view"))! as DetailViewController
                DetailVC.name = item.item
                self.navigationController?.pushViewController(DetailVC, animated: true)
            }.disposed(by: bag)
        
        self.tableView.rx.modelDeleted(Product.self).bind { item in
            print(item.item)
        }.disposed(by: bag)

    }
    

    
    
    
}

struct ProductViewModel {
    var items = BehaviorRelay.init(value: [Product]())
}
struct Product {
    var item : String
}

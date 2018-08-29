//
//  ViewController.swift
//  MVVM
//
//  Created by Sanooj on 29/08/2018.
//  Copyright © 2018 Sanooj. All rights reserved.
//

import UIKit


struct UIModel {
    let firstTitle: String
    let firstSubtitle: String
    let secondTitle: String
    let secondSubTitle: String
}

protocol SingleViewContainerDataSource {
    func modelFor<Model,ViewContainer>(viewController: ViewContainer) -> Model?
}

protocol CollectionOfViewsContainerDataSource {
    func modelsFor<Model,ViewContainer>(viewController: ViewContainer) -> [Model]
}

protocol ViewContainerDataDestination {
    associatedtype DataSource
    var dataSource: DataSource? { get }
    func register(dataSource:DataSource, withInstance viewController:Self)
}

protocol CViewControllerDataSource: SingleViewContainerDataSource {}

protocol ViewConfigurator {
    associatedtype View
    associatedtype Model
    func configure(view: View , with model:Model)
}

class ViewController: UIViewController {

    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstSubtitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondSubtitleLabel: UILabel!

    typealias DataSource = CViewControllerDataSource
    private(set) var dataSource: CViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let model: UIModel? = dataSource?.modelFor(viewController: self)
        self.configure(view: self, with: model!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: ViewContainerDataDestination {
    func register(dataSource: CViewControllerDataSource, withInstance viewController: ViewController) {
        viewController.dataSource = dataSource
    }
}

extension ViewController: ViewConfigurator {
    typealias View = ViewController
    typealias Model = UIModel
    func configure(view: ViewController , with model:UIModel) {
        view.firstTitleLabel?.text = model.firstTitle
        view.firstSubtitleLabel?.text = model.firstSubtitle
        view.secondTitleLabel?.text = model.secondTitle
        view.secondSubtitleLabel?.text = model.secondSubTitle
    }
}



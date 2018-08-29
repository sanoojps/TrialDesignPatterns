
//
//  Presenter.swift
//  MVVM
//
//  Created by Sanooj on 29/08/2018.
//  Copyright © 2018 Sanooj. All rights reserved.
//

import Foundation

class PresenterViewModel {
    let dummy: UIModel =
        UIModel.init(firstTitle: "Good", firstSubtitle: "boy",
                     secondTitle: "Bad", secondSubTitle: "Boy")
}

extension PresenterViewModel: CViewControllerDataSource {
    func modelFor<Model, ViewContainer>(viewController: ViewContainer) -> Model? {
        return dummy as? Model
    }
    
}

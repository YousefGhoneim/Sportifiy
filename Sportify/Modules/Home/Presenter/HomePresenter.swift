//
//  HomePresenter.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    private weak var viewController: UIViewController?
    private var sports: [Sport] = []

    init(view: HomeViewProtocol, viewController: UIViewController) {
        self.view = view
        self.viewController = viewController
        self.sports = [
            Sport(name: "Football", imageName: "football"),
            Sport(name: "BasketBall", imageName: "basket"),
            Sport(name: "BaseBall", imageName: "baseball"),
            Sport(name: "Tennis", imageName: "tennis")
        ]
    }

    func viewDidLoad() {
        view?.showSports(sports)
    }

    func didSelectSport(named name: String) {
        guard let selected = sports.first(where: { $0.name == name }) else { return }
        print("Selected sport: \(selected.name)")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let leaguesVC = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as? LeaguesViewController {
            leaguesVC.selectedSport = selected.name
            viewController?.navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }

}

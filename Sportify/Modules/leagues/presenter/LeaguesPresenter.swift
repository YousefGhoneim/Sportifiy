//
//  LeaguesPresenter.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    func fetchLeagues()
}

class LeaguesPresenter: LeaguesPresenterProtocol {

    private let networkService: NetworkServiceProtocol
    private weak var view: LeaguesViewProtocol?
    private let sportName: String

    init(view: LeaguesViewProtocol, sportName: String, networkService: NetworkServiceProtocol = NetworkService()) {
        self.view = view
        self.sportName = sportName
        self.networkService = networkService
    }

    func fetchLeagues() {
        networkService.fetchLeagues(forSport: sportName) { [weak self] result in
            switch result {
            case .success(let leagues):
                self?.view?.showLeagues(leagues)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}

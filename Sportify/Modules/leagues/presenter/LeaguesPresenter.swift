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
    
    private var service: NetworkManagerProtocol!
    
    private weak var view: LeaguesTableViewController?
    private var sportName: String

    init(service: NetworkManagerProtocol, view: LeaguesTableViewController, sportName: String) {
        self.service = service
        self.view = view
        self.sportName = sportName
    }
    
    var leaguesTableViewController: LeaguesTableViewController!
    
    func attatchView(tvController: LeaguesTableViewController){
        leaguesTableViewController = tvController
    }
    
    func fetchLeagues() {
           service.fetchLeagues(forSport: sportName) { [weak self] result in
               switch result {
               case .success(let leagues):
                   self?.view?.showLeagues(leagues)
               case .failure(let error):
                   self?.view?.showError(error.localizedDescription)
               }
           }
       }
    
    
}

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
    
    
    
    private weak var view: LeaguesTableViewController?
    private var sportName: String

    init(view: LeaguesTableViewController, sportName: String) {
        self.view = view
        self.sportName = sportName
    }
    
    var leaguesTableViewController: LeaguesTableViewController!
    
    func attatchView(tvController: LeaguesTableViewController){
        leaguesTableViewController = tvController
    }
    
    func fetchLeagues() {
           NetworkManager.fetchLeagues(forSport: sportName) { [weak self] result in
               switch result {
               case .success(let leagues):
                   self?.view?.showLeagues(leagues)
               case .failure(let error):
                   self?.view?.showError(error.localizedDescription)
               }
           }
       }
    
    
}

//
//  HomeContracts.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

protocol HomeViewProtocol: AnyObject {
    func showSports(_ sports: [Sport])
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectSport(named name: String)
}


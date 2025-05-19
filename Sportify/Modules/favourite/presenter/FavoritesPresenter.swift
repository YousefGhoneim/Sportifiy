//
//  FavoritesPresenter.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 17/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation


import Foundation
import CoreData
import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    func fetchFavorites()
    func deleteLeague(at index: Int)
    var favorites: [Leagues] { get }
}

class FavoritesPresenter: FavoritesPresenterProtocol {

    private weak var view: FavoritesViewProtocol?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private(set) var favorites: [Leagues] = []

    init(view: FavoritesViewProtocol) {
        self.view = view
    }

    func fetchFavorites() {
        let fetchRequest: NSFetchRequest<Leagues> = Leagues.fetchRequest()
        do {
            favorites = try context.fetch(fetchRequest)
            view?.showLeagues(favorites)
        } catch {
            view?.showError("Failed to load saved leagues.")
        }
    }

    func deleteLeague(at index: Int) {
        let league = favorites[index]
        context.delete(league)

        do {
            try context.save()
            favorites.remove(at: index)
            view?.showLeagues(favorites)
        } catch {
            view?.showError("Failed to delete league.")
        }
    }
}

//
//  HomeViewController.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {

    // MARK: - IBOutlets for Sport Views
    @IBOutlet weak var footballView: UIView!
    @IBOutlet weak var basketballView: UIView!
    @IBOutlet weak var baseballView: UIView!
    @IBOutlet weak var tennisView: UIView!

    var presenter: HomePresenterProtocol!
    private var sports: [Sport] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self, viewController: self)
        presenter.viewDidLoad()
        setupGestureRecognizers()
    }

    func showSports(_ sports: [Sport]) {
        self.sports = sports
    }

    private func setupGestureRecognizers() {
        let footballTap = UITapGestureRecognizer(target: self, action: #selector(didTapFootball))
        footballView.addGestureRecognizer(footballTap)
        footballView.isUserInteractionEnabled = true

        let basketballTap = UITapGestureRecognizer(target: self, action: #selector(didTapBasketball))
        basketballView.addGestureRecognizer(basketballTap)
        basketballView.isUserInteractionEnabled = true

        let baseballTap = UITapGestureRecognizer(target: self, action: #selector(didTapCricket))
        baseballView.addGestureRecognizer(baseballTap)
        baseballView.isUserInteractionEnabled = true

        let tennisTap = UITapGestureRecognizer(target: self, action: #selector(didTapTennis))
        tennisView.addGestureRecognizer(tennisTap)
        tennisView.isUserInteractionEnabled = true
    }

    @objc private func didTapFootball() {
        presenter.didSelectSport(named: "Football")
    }

    @objc private func didTapBasketball() {
        presenter.didSelectSport(named: "BasketBall")
    }

    @objc private func didTapCricket() {
        presenter.didSelectSport(named: "Cricket")
    }

    @objc private func didTapTennis() {
        presenter.didSelectSport(named: "Tennis")
    }
}

//
//  SplashViewController.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 21/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        animationView = AnimationView(name: "SportsAnimation") // no .json
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .playOnce
        animationView?.animationSpeed = 1.0

        if let animationView = animationView {
            view.addSubview(animationView)
            animationView.play { [weak self] finished in
                guard finished else { return }
                self?.showMainApp()
            }
        }
    }

    private func showMainApp() {
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}

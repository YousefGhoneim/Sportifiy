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

        animationView = AnimationView(name: "SportsAnimation")
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
        guard let window = UIApplication.shared.windows.first else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate the Navigation Controller
        let navController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController

        window.rootViewController = navController
        window.makeKeyAndVisible()

        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil)
    }
}

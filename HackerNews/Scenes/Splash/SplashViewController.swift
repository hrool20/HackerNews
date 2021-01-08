//
//  SplashViewController.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var splashPresenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = Constants.Localizable.APP_NAME
        splashPresenter.startAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SplashViewController: SplashViewControllerProtocol {
    func goToHitOptions() {
        let navigationController = PrincipalNavigationController(rootViewController: Router.shared.getHitOptions())
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true, completion: nil)
    }
}

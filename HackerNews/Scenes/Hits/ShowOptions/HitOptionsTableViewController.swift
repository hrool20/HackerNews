//
//  HitOptionsTableViewController.swift
//  HackerNews
//
//  Created by Hugo Rosado on 1/6/21.
//  Copyright © 2021 Hugo Rosado. All rights reserved.
//

import UIKit

class HitOptionsTableViewController: UITableViewController {
    
    private var hits: [Hit]?
    private var order: HitOrder!
    private var lottieRefreshControl: LottieRefreshControl!
    var hitsPresenter: HitOptionsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        order = .descendant
        
        lottieRefreshControl = LottieRefreshControl()
        lottieRefreshControl.addTarget(self, action: #selector(didRefreshTableView), for: .valueChanged)
        tableView.refreshControl = lottieRefreshControl
        
        tableView.register(HitOptionTableViewCell.getNIB(), forCellReuseIdentifier: HitOptionTableViewCell.reuseIdentifier)
        
        hitsPresenter.loadHits(orderedBy: order, isAnUpdate: false)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lottieRefreshControl.updateProgress(with: scrollView.contentOffset.y)
    }
    
    @objc private func showOptions() {
        let alertController = UIAlertController(title: title ?? Constants.Localizable.APP_NAME, message: nil, preferredStyle: .actionSheet)
        let restartAction = UIAlertAction(title: Constants.Localizable.RESTORE_NEWS, style: .default) { [weak self] (_) in
            self?.showQuestion(title: "", message: Constants.Localizable.RESTORE_NEWS_QUESTION, closure: { (isSuccessful) in
                guard let self = self else { return }
                guard isSuccessful else { return }
                self.hitsPresenter.removeDeletedHits()
                self.hitsPresenter.loadHits(orderedBy: self.order, isAnUpdate: false)
            })
        }
        let cancelAction = UIAlertAction(title: Constants.Localizable.CANCEL, style: .cancel, handler: nil)
        alertController.addAction(restartAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func didRefreshTableView() {
        hitsPresenter.loadHits(orderedBy: order, isAnUpdate: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - TableViewDelegate && TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HitOptionTableViewCell.reuseIdentifier, for: indexPath) as! HitOptionTableViewCell
        guard let hit = hits?[indexPath.row] else {
            return cell
        }
        let title = hit.title ?? hit.storyTitle ?? ""
        let description = "\(hit.author) - \(hitsPresenter.calculateDateDifference(date: hit.createdAt))"
        cell.option = (title, description)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let hit = hits?[indexPath.row], let url = hit.url ?? hit.storyUrl else { return }
        let vc = Router.shared.getMainWebview(title: nil, url: url)
        show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let hit = hits?.remove(at: indexPath.row) else { return }
            hitsPresenter.saveDeletedHit(hit: hit)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }

}
extension HitOptionsTableViewController: HitOptionsTableViewControllerProtocol {
    func updateNavigationBar(_ shouldShowRightItems: Bool) {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_app_logo.png").resizeImage(targetSize: CGSize(width: 35.0, height: 35.0)))
        navigationItem.titleView = imageView
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_gear.png").resizeImage(targetSize: CGSize(width: 30.0, height: 30.0)), style: .plain, target: self, action: #selector(showOptions))
        navigationItem.rightBarButtonItems = (shouldShowRightItems) ? [barButton] : []
    }
    
    func updateHits(_ hits: [Hit]) {
        self.hits = hits
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}

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
    var hitsPresenter: HitOptionsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Hints"
        
        tableView.register(HitOptionTableViewCell.getNIB(), forCellReuseIdentifier: HitOptionTableViewCell.reuseIdentifier)

        hitsPresenter.loadHits(orderedBy: .ascendant)
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
        guard let hit = hits?[indexPath.row], let createdAt = hit.createdAt else {
            return cell
        }
        let title = hit.title ?? hit.storyTitle ?? ""
        let description = "\(hit.author) - \(DateFormatterHandler.shared.string(from: createdAt, withFormat: "dd/MM/yyyy hh:mm:ss"))"
        cell.option = (title, description)
        return cell
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

}
extension HitOptionsTableViewController: HitOptionsTableViewControllerProtocol {
    func updateHits(_ hits: [Hit]) {
        self.hits = hits
        tableView.reloadData()
    }
}

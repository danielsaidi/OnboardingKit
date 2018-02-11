//
//  ViewController+TableView.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func listOption(at indexPath: IndexPath) -> TableViewOption {
        return options[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "Cell"
        let option = listOption(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: id)
            ?? UITableViewCell(style: .default, reuseIdentifier: id)
        cell.textLabel?.text = option.title
        cell.detailTextLabel?.text = option.description
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = listOption(at: indexPath)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        switch option {
        case .hint: showHint(forUser: userId, from: cell)
        case .reset: resetDisplayState()
        case .tutorial: showTutorial(forUser: userId, from: cell)
        case .localizedTutorial: showLocalizedTutorial(forUser: userId, from: cell)
        }
    }
}

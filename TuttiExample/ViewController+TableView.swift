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
        return sections[indexPath.section].options[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
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
        case .hint(let userId): showHint(forUser: userId, from: cell)
        case .reset: resetDisplayState()
        case .tutorial(let userId): showTutorial(forUser: userId, from: cell)
        case .localizedTutorial(let userId): showLocalizedTutorial(forUser: userId, from: cell)
        }
    }
}

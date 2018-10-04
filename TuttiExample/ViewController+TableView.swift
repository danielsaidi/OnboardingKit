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
        let section = options[indexPath.section]
        return section.1[indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return options[section].0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].1.count
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
        case .hint: show(getHint(forUser: userId), from: cell)
        case .deferredHint: show(getDeferredHint(forUser: userId), from: cell)
        case .dismissCurrentHint:
            hintPresenter.dismiss(hint: getHint(forUser: userId))
            hintPresenter.dismiss(hint: getDeferredHint(forUser: userId))
        case .reset: resetDisplayState()
        case .tutorial: show(getTutorial(forUser: userId), from: cell)
        case .localizedTutorial: show(getLocalizedTutorial(forUser: userId), from: cell)
        case .deferredTutorial: show(getDeferredTutorial(forUser: userId), from: cell)
        }
    }
}

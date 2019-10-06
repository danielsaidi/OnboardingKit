//
//  ViewController+User.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

extension ViewController {
    
    func setupUser() {
        let user = userId
        let title = "Enter a user name"
        let message = "The display states of all hints and alerts are unique to each user."
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .alert)
        sheet.addTextField { (textField) in textField.text = user ?? "" }
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.userId = sheet.textFields?.first?.text
            let id = self?.userId?.trimmingCharacters(in: .whitespaces)
            if (id?.count ?? 0) == 0 {
                self?.userId = nil
            }
            self?.alertUserChange()
        }
        sheet.addAction(ok)
        present(sheet, animated: true, completion: nil)
    }
}


// MARK: - Actions

extension ViewController {
    
    @IBAction func setupUser(_ sender: Any) {
        setupUser()
    }
}


// MARK: - Private Functions

private extension ViewController {
    
    func alertUserChange() {
        alert(title: "The user was changed", message: alertUserChangeMessage)
    }
    
    var alertUserChangeMessage: String {
        guard let userId = userId else { return "The app will now show user-unspecific hints and alerts." }
        return "The app will now show hints and alerts for user '\(userId)'."
    }
}

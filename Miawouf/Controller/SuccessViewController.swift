//
//  SuccessViewController.swift
//  Miawouf
//
//  Created by Andreea Draghici on 2022-05-05.
//

import UIKit

class SuccessViewController: UIViewController {

    var pet: Pet!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabel()
    }
    
    private func setTextLabel() {
        if let name = pet.name {
            label.text = """
Wouf de bienvenue à \(name)!

Vouz avez bien été ajouté/e à notre base de données. Nous vous enverrons un SMS dès que nous avons une ame soeur à vous proposer !
"""
        }
    }

    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}

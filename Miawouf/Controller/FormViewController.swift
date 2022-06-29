//
//  FormViewController.swift
//  Miawouf
//
//  Created by Andreea Draghici on 2022-05-05.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var racePickerView: UIPickerView!
    @IBOutlet weak var majoritySwitch: UISwitch!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    
    @IBAction func validate(_ sender: Any) {
        let pet = createPetObject()
        checkPetStatus(pet)
    }
    
    private func checkPetStatus(_ pet: Pet) {
        //s'assurer qu'on a le bon pet
        switch pet.status {

        case .accepted:
            performSegue(withIdentifier: "segueToSuccess", sender: pet)
        case .rejected(let error):
            presentAlert(with: error)
        }

    }
    
    private func presentAlert(with error:String) {
        //un controleur
        let alert:UIAlertController = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        //une action - nil pour que l'alerte se cache apres , on veut pas rien faire avec
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //associer l'alert avec l'action
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func createPetObject() -> Pet {
        let name = nameTextField.text
        let phone = phoneTextField.text
        let hasMajority = majoritySwitch.isOn
        let gender: Pet.Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .male : .female
        let raceIndex = racePickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        
        return Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //make sure we are in the good segue
        if segue.identifier == "segueToSuccess" {
            //vue controlleur ver les segue est redirigé - ici SuccessViewController
            //if destination n'est pas un SuccesVueController successVC sera nil
            let successVC = segue.destination as? SuccessViewController
            //recupere l'elem dans le sender et s'assurer qu'il est de bon type
            //pour ca nous avons besoin d'un var pet dans le SuccesVue controller pour recevoir la valeur qu'on va lui passer 
            let pet = sender as? Pet
            successVC?.pet = pet
        }
    }
}

extension FormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogRaces.count
    }
}

extension FormViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogRaces[row]
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

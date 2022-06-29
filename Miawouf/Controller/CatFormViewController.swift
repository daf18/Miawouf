//
//  CatFormViewController.swift
//  Miawouf
//
//  Created by Andreea Draghici on 2022-05-06.
//

import UIKit

class CatFormViewController: UIViewController {

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
            createPetObject()
        }
        
        private func createPetObject() {
            let name = nameTextField.text
            let phone = phoneTextField.text
            let hasMajority = majoritySwitch.isOn
            let gender: Pet.Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .male : .female
            let raceIndex = racePickerView.selectedRow(inComponent: 0)
            let race = dogRaces[raceIndex]
            
            let cat = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
        }
    }

    extension CatFormViewController: UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return catRaces.count
        }
    }

    extension CatFormViewController: UIPickerViewDelegate {
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return catRaces[row]
        }
    }

    extension CatFormViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }


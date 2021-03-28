//
//  UIPickerViewDelegate+Ex.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 25.03.21.
//

import Foundation

import UIKit

extension IYCreateInviteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var picker: Int = 0
        switch pickerView {
        case typeOfEventPicker:
            picker = IYNameOfEvent.allCases.count
        case numberOfPersonsPicker:
            picker = IYNumberOfPersons.allCases.count
        default:
            break
        }
        return picker
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var picker: String? = nil
        switch pickerView {
        case typeOfEventPicker:
            picker = IYNameOfEvent.allCases[row].rawValue
        case numberOfPersonsPicker:
            picker = IYNumberOfPersons.allCases[row].rawValue
        default:
            break
        }
        return picker
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case typeOfEventPicker:
            self.typeOfEventTextField.text = IYNameOfEvent.allCases[row].rawValue
        case numberOfPersonsPicker:
            self.numberOfPersonsTextField.text = IYNumberOfPersons.allCases[row].rawValue
        default:
            break
        }
    }

}

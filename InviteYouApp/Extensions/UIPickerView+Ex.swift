//
//  UIPickerView+Ex.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 13.04.21.
//

import UIKit

extension IYCreateInviteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var picker: Int = 0
        switch pickerView {
        case typeOfEventPicker:
            picker = IYTypeOfEvent.allCases.count
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
            picker = IYTypeOfEvent.allCases[row].rawValue
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
            typeOfEventTextField.text = IYTypeOfEvent.allCases[row].rawValue
        case numberOfPersonsPicker:
            numberOfPersonsTextField.text = IYNumberOfPersons.allCases[row].rawValue
        default:
            break
        }
    }
}

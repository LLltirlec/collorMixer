//
//  ViewController.swift
//  collorMixer
//
//  Created by Евгений Ефимов on 29.04.2023.
//

import UIKit

final class PickerViewController: UIViewController {
    
    @IBOutlet weak var collorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!
    
    var color: Color!
    unowned var delegate: PickerViewControllerDeligate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getColor()
        changeViewCollor()
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        changeViewCollor()
        
        switch sender{
        case redSlider:
            redValue.text = String(format: "%.2f", redSlider.value)
            color.red = redSlider.value
            redColorTextField.text = String(format: "%.2f", redSlider.value)
        case greenSlider:
            greenValue.text = String(format: "%.2f", greenSlider.value)
            color.green = greenSlider.value
            greenColorTextField.text = String(format: "%.2f", greenSlider.value)
        default:
            blueValue.text = String(format: "%.2f", blueSlider.value)
            color.blue = blueSlider.value
            blueColorTextField.text = String(format: "%.2f", blueSlider.value)
        }
        
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setNewColor(for: color)
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        let roundingDepth = 0.04
        
        collorView.layer.cornerRadius = collorView.frame.width * roundingDepth
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    
    private func getColor() {
        redSlider.value = color.red
        greenSlider.value = color.green
        blueSlider.value = color.blue
        
        redValue.text = String(format: "%.2f",color.red)
        greenValue.text = String(format: "%.2f",color.green)
        blueValue.text = String(format: "%.2f",color.blue)
        
        redColorTextField.text = String(format: "%.2f",color.red)
        greenColorTextField.text = String(format: "%.2f",color.green)
        blueColorTextField.text = String(format: "%.2f",color.blue)
    }
    
    private func changeViewCollor() {
        collorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
}


extension PickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redColorTextField:
            color.red = Float(redColorTextField.text ?? "") ?? 0
            redValue.text = redColorTextField.text
            redSlider.value = Float(redColorTextField.text ?? "") ?? 0
        case greenColorTextField:
            color.green = Float(greenColorTextField.text ?? "") ?? 0
            greenValue.text = greenColorTextField.text
            greenSlider.value = Float(greenColorTextField.text ?? "") ?? 0
        default:
            color.blue = Float(blueColorTextField.text ?? "") ?? 0
            blueValue.text = blueColorTextField.text
            blueSlider.value = Float(blueColorTextField.text ?? "") ?? 0
        }
        
        changeViewCollor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "," {
                textField.text = textField.text! + "."
                return false
            }
            return true
    }
}

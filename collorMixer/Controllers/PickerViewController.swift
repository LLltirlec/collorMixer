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
    
    var color: Color!
    unowned var delegate: PickerViewControllerDeligate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getColor()
        changeViewCollor()
        changeLabelValue()
    }

    @IBAction func sliderValueChanged() {
        changeViewCollor()
        changeLabelValue()
        changeModelValue()
        
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setNewColor(for: color)
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        let roundingDepth = 0.04
        
        collorView.layer.cornerRadius = collorView.frame.width * roundingDepth
    }
    
    private func getColor() {
        redSlider.value = color.red
        greenSlider.value = color.green
        blueSlider.value = color.blue
    }
    
    private func changeViewCollor() {
        collorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func changeLabelValue() {
        redValue.text = String(format: "%.2f", redSlider.value)
        greenValue.text = String(format: "%.2f", greenSlider.value)
        blueValue.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func changeModelValue() {
        color.red = redSlider.value
        color.green = greenSlider.value
        color.blue = blueSlider.value
    }
}


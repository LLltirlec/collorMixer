//
//  ViewController.swift
//  collorMixer
//
//  Created by Евгений Ефимов on 29.04.2023.
//

import UIKit

extension UIView {
}

class ViewController: UIViewController {

    @IBOutlet weak var collorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeViewCollor()
    }

    @IBAction func redSliderChanged() {
        changeViewCollor()
    }
    @IBAction func greenSliderChanged() {
        changeViewCollor()
    }
    @IBAction func blueSliderChange() {
        changeViewCollor()
    }
    
    private func changeViewCollor() {
        collorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        changeLabelValue()
    }
    
    private func changeLabelValue() {
        redValue.text = (round(redSlider.value * 100) / 100).formatted()
        greenValue.text = (round(greenSlider.value * 100) / 100).formatted()
        blueValue.text = (round(blueSlider.value * 100) / 100).formatted()
    }
}


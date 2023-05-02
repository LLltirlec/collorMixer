//
//  ViewController.swift
//  collorMixer
//
//  Created by Евгений Ефимов on 29.04.2023.
//

import UIKit

extension UISlider {
    
}

final class ViewController: UIViewController {

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
        changeLabelValue()
    }

    @IBAction func sliderValueChanged() {
        changeViewCollor()
        changeLabelValue()
    }
    
    override func viewDidLayoutSubviews() {
        let roundingDepth = 0.04
        
        collorView.layer.cornerRadius = collorView.frame.width * roundingDepth
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
}


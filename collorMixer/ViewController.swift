//
//  ViewController.swift
//  collorMixer
//
//  Created by Евгений Ефимов on 29.04.2023.
//

import UIKit

extension UIViewController {
    func hexStringFromColor(_ color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        return hexString
     }
    
    func fastAlert(title: String, message: String, closeAfter: Double) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        present(alert, animated: true)
        
        let seconds = closeAfter
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func saveData(data: Float, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadData(key: String) -> Float {
        if UserDefaults.standard.object(forKey: key) != nil {
            return UserDefaults.standard.float(forKey: key)
        }
        else{
            return 0.5
        }
    }
}

final class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var hexValueField: UITextField!
    @IBOutlet weak var copyToClipbButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = loadData(key: "redColor")
        greenSlider.value = loadData(key: "greenColor")
        blueSlider.value = loadData(key: "blueColor")
        
        changeViewCollor()
    }
    override func viewDidLayoutSubviews() {
        let roundingDepth = 0.02
        
        colorView.layer.cornerRadius = colorView.frame.width * roundingDepth
        copyToClipbButton.layer.cornerRadius = copyToClipbButton.frame.width * roundingDepth
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
    
    @IBAction func copyToClipbButtonTapped() {
        UIPasteboard.general.string = hexValueField.text
        fastAlert(
            title: "BAADA BOOM",
            message: "Hex value has been copied",
            closeAfter: 0.7
        )
    }
    
    private func changeViewCollor() {
        let color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        
        colorView.backgroundColor = color
        changeLabelValue()
        hexValueField.text = hexStringFromColor(color)
        
        saveData(data: redSlider.value, key: "redColor")
        saveData(data: greenSlider.value, key: "greenColor")
        saveData(data: blueSlider.value, key: "blueColor")
    }
    
    private func changeLabelValue() {
        redValue.text = (round(redSlider.value * 100) / 100).formatted()
        greenValue.text = (round(greenSlider.value * 100) / 100).formatted()
        blueValue.text = (round(blueSlider.value * 100) / 100).formatted()
    }
}


//
//  ViewController.swift
//  collorMixer
//
//  Created by Евгений Ефимов on 29.04.2023.
//

import UIKit
// MARK: Extensions
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

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
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
    @IBOutlet weak var colorWell: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let red = loadData(key: "redColor")
        let green = loadData(key: "greenColor")
        let blue = loadData(key: "blueColor")
        
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        
        colorWell.selectedColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        colorWell.supportsAlpha = false
        colorWell.addTarget(self, action: #selector(colorWellChanged), for: .valueChanged)
        
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
    
    @objc private func colorWellChanged() {
        colorView.backgroundColor = colorWell.selectedColor
        
        redSlider.value = Float(colorView.backgroundColor!.rgba.red)
        greenSlider.value = Float(colorView.backgroundColor!.rgba.green)
        blueSlider.value = Float(colorView.backgroundColor!.rgba.blue)
        
        changeLabelValue()
        hexValueField.text = hexStringFromColor(colorView.backgroundColor!)
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


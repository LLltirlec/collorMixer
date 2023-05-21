//
//  MainViewController.swift
//  collorMixer
//
//  Created by Евгений Ефимов on 21.05.2023.
//

import UIKit

protocol PickerViewControllerDeligate: AnyObject {
    func setNewColor(for color: Color)
}

final class MainViewController: UIViewController {

    private var color = Color(red: 0.2, green: 0.3, blue: 0.4){
        didSet{
            view.backgroundColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pickerVC = segue.destination as? PickerViewController else { return }
        
        pickerVC.color = color
        pickerVC.delegate = self
    }
    
}

extension MainViewController: PickerViewControllerDeligate {
    func setNewColor(for color: Color) {
        self.color = color
    }
    
}

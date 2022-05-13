//
//  ConverterViewController.swift
//  Cook Book
//
//  Created by Justin on 4/10/22.
//

/*
 Referenced https://www.youtube.com/watch?v=EsheQe6U_WE 
 */
 

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var numberInput: UITextField!
  
    
    let data = ["Select One", "Teaspoon", "Tablespoon", "Fluid Ounce", "Cup", "Quart", "Gallon", "Milliliter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        picker.layer.cornerRadius = 10
        
        picker.backgroundColor = UIColor.appColor(.blue)
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.view.backgroundColor = UIColor.white
                picker.tintColor = UIColor.black
                numberInput.textColor = UIColor.black
                quantityLabel.textColor = UIColor.black
                unitLabel.textColor = UIColor.black
                numberInput.textColor = UIColor.black
                output.backgroundColor = UIColor.white
                output.textColor = UIColor.black
            } else {
                self.view.backgroundColor = UIColor.appColor(.dark)
                picker.tintColor = UIColor.black
                numberInput.textColor = UIColor.white
                quantityLabel.textColor = UIColor.white
                unitLabel.textColor = UIColor.white
                numberInput.textColor = UIColor.black
                output.backgroundColor = UIColor.appColor(.transparent)
                output.textColor = UIColor.white
            }
        picker.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //convert(convertBtn, num: numberInput.text!
        output.numberOfLines = 20
        let temp = numberInput.text!
        if data[row] == "Fluid Ounce"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.flounce()
            output.text = measurement
        }
        else if data[row] == "Teaspoon"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.teaspoon()
            output.text = measurement
        }
        else if data[row] == "Tablespoon"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.tablespoon()
            output.text = measurement
        }
        else if data[row] == "Cup"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.cups()
            output.text = measurement
        }
        else if data[row] == "Quart"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.quarts()
            output.text = measurement
        }
        else if data[row] == "Gallon"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.gallon()
            output.text = measurement
        }
        else if data[row] == "Milliliter"{
            let stringToInt = Double(temp)
            let measurement = stringToInt?.ml()
            output.text = measurement
        }
    }

}

extension ConverterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
}

extension ConverterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}

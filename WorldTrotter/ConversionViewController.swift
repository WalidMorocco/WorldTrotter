//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Amar, Walid  on 2/16/22.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else{
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }

    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else{
            celsiusLabel.text = "???"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let remplacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil, remplacementTextHasDecimalSeparator != nil{
            return false
        } else {
            return true
        }
    }
    
    
    //let isMetric = currentLocale.usesMetricSystem
    //let currencySymbol = currentLocale.currencySymbol
    
}


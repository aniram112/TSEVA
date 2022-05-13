//
//  ViewController.swift
//  TSEVA
//
//  Created by Marina Roshchupkina on 16.01.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import UIKit
import Foundation
import ChromaColorPicker

class MainViewController: UIViewController,UITextFieldDelegate {
    //labels with colors
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    //labels with text
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textLabel4: UILabel!
    @IBOutlet weak var textLabel5: UILabel!
    @IBOutlet weak var textLabel6: UILabel!
    
    //scrolling picker of color types
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [
        "ANALOGOUS",
        "COMPLEMENTARY",
        "TRIADIC",
        "TETRADIC",
        "NEUTRAL",
        "SHADES",
        "TINTS",
        "TONES"
    ]
    var colorpicker: ChromaColorPicker?
    
    var textField = UITextField(
        frame: CGRect(x: UIScreen.main.bounds.width/2-150, y:47 , width: 300, height: 300)
    )
    var currPalette = App.shared.paletteNames[0]
    
    // MARK: - Add actions
    private func addLongPress() {
        [label1,label2,label3,label4,label5,label6].forEach {
            $0?.layer.masksToBounds = true
            $0?.layer.cornerRadius = 10
            $0?.isUserInteractionEnabled = true
            $0?.addGestureRecognizer(
                UILongPressGestureRecognizer(
                    target: self,
                    action: #selector(addToPalette)
                )
            )
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.picker.dataSource = self
        self.picker.delegate = self
        picker.tag = 1
        addLongPress()
        
        let xcentre = UIScreen.main.bounds.width/2-150
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: xcentre, y: 120, width: 300, height: 300))
        neatColorPicker.delegate = self as ChromaColorPickerDelegate
        neatColorPicker.padding = -10
        neatColorPicker.stroke = 20
        neatColorPicker.hexLabel.textColor = UIColor.black
        neatColorPicker.addTarget(self, action: #selector(MainViewController.colorChanged), for: .valueChanged)
        colorpicker = neatColorPicker
        view.addSubview(colorpicker!)
        
        let tapAction = UITapGestureRecognizer(target: self, action:#selector(actionTapped(_:)))
        colorpicker?.hexLabel.isUserInteractionEnabled = true
        colorpicker?.hexLabel.addGestureRecognizer(tapAction)
        
        textField.textAlignment = .center
        textField.delegate = self
        textField.isHidden = true
        textField.text = "#FF0000"
        textField.font = UIFont(name: "Menlo-Regular", size: 20)
        textField.textColor = .black
        textField.addTarget(self, action: #selector(MainViewController.textFieldDidEndEditing(_:)), for: .editingDidEnd)
        view.addSubview(textField)
        
    }
    
    func ChangeColorInLabels(){
        let strColor = colorpicker?.hexLabel.text
        let color1 = hexStringToUIColor(hex: strColor!)
        label1.backgroundColor = color1
        textLabel1.text = colorpicker?.hexLabel.text
        label2.backgroundColor = UIColor.white
        label3.backgroundColor = UIColor.white
        label4.backgroundColor = UIColor.white
        label5.backgroundColor = UIColor.white
        label6.backgroundColor = UIColor.white
        
        textLabel2.text = ""
        textLabel3.text = ""
        textLabel4.text = ""
        textLabel5.text = ""
        textLabel6.text = ""
        switch picker.selectedRow(inComponent: 0) {
        //analogous
        case 0:
            label2.backgroundColor = color1.analagous1
            label3.backgroundColor = color1.analagous2
            label4.backgroundColor = color1.analagous3
            label5.backgroundColor = color1.analagous4
            label6.backgroundColor = color1.analagous5
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            textLabel4.text = label4.backgroundColor?.hexString
            textLabel5.text = label5.backgroundColor?.hexString
            textLabel6.text = label6.backgroundColor?.hexString
            
        //complementary // case 2
        case 1:
            label2.backgroundColor =  color1.complement
            
            textLabel2.text = label2.backgroundColor?.hexString
            
        //triadic
        case 2:
            label2.backgroundColor = color1.triadic0
            label3.backgroundColor = color1.triadic1
            
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            
            
        //tetradic
        case 3:
            label2.backgroundColor = color1.tetradic0
            label3.backgroundColor = color1.tetradic1
            label4.backgroundColor = color1.tetradic2
            
            
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            textLabel4.text = label4.backgroundColor?.hexString
            
            
        //neutral
        case 4:
            label2.backgroundColor = color1.neutral1
            label3.backgroundColor = color1.neutral2
            label4.backgroundColor = color1.neutral3
            label5.backgroundColor = color1.neutral4
            label6.backgroundColor = color1.neutral5
            
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            textLabel4.text = label4.backgroundColor?.hexString
            textLabel5.text = label5.backgroundColor?.hexString
            textLabel6.text = label6.backgroundColor?.hexString
            
        //shades
        case 5:
            label2.backgroundColor = color1.darker(by: 12)
            label3.backgroundColor = color1.darker(by: 24)
            label4.backgroundColor = color1.darker(by: 36)
            label5.backgroundColor = color1.darker(by: 48)
            label6.backgroundColor = color1.darker(by: 60)
            
            
            // label7.backgroundColor = color1.darker(by: 60)
            //label8.backgroundColor = color1.darker(by: 70)
            
            
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            textLabel4.text = label4.backgroundColor?.hexString
            textLabel5.text = label5.backgroundColor?.hexString
            textLabel6.text = label6.backgroundColor?.hexString
            
        //tints
        case 6:
            label2.backgroundColor = color1.lighter(by: 12)
            label3.backgroundColor = color1.lighter(by: 24)
            label4.backgroundColor = color1.lighter(by: 36)
            label5.backgroundColor = color1.lighter(by: 48)
            label6.backgroundColor = color1.lighter(by: 60)
            //label7.backgroundColor = color1.lighter(by: 60)
            //label8.backgroundColor = color1.lighter(by: 70)
            
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            textLabel4.text = label4.backgroundColor?.hexString
            textLabel5.text = label5.backgroundColor?.hexString
            textLabel6.text = label6.backgroundColor?.hexString
            
        //tones
        case 7:
            label2.backgroundColor = color1.withHueSaturation(satur: 15, bright: 70)
            label3.backgroundColor = color1.withHueSaturation(satur: 30, bright: 65)
            label4.backgroundColor = color1.withHueSaturation(satur: 45, bright: 60)
            label5.backgroundColor = color1.withHueSaturation(satur: 60, bright: 55)
            label6.backgroundColor = color1.withHueSaturation(satur: 75, bright: 50)
            //label7.backgroundColor = color1.withHueSaturation(satur: 55).darker(by: 40)
            //label8.backgroundColor = color1.withHueSaturation(satur: 60).darker(by: 40)
            
            textLabel2.text = label2.backgroundColor?.hexString
            textLabel3.text = label3.backgroundColor?.hexString
            textLabel4.text = label4.backgroundColor?.hexString
            textLabel5.text = label5.backgroundColor?.hexString
            textLabel6.text = label6.backgroundColor?.hexString
            
        default:
            label2.backgroundColor = UIColor.white
            label3.backgroundColor = UIColor.white
            label4.backgroundColor = UIColor.white
            label5.backgroundColor = UIColor.white
            label6.backgroundColor = UIColor.white
            
            textLabel2.text = ""
            textLabel3.text = ""
            textLabel4.text = ""
            textLabel5.text = ""
            textLabel6.text = ""
            
        }
    }
    
    @objc func colorChanged() {
        ChangeColorInLabels()
    }
    
    @objc func addToPalette(sender: Any) {
        // убрать !
        let rec = sender as! UILongPressGestureRecognizer
        let label = rec.view as! UILabel
        let color = label.backgroundColor ?? .black
        //colorPickerDidChooseColor(colorpicker!, color: label.backgroundColor ?? .black)
        
        let alert = UIAlertController(title: "Choose palette", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        pickerFrame.tag = 2
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (UIAlertAction) in
                    App.shared.palettes[self.currPalette]?.append(color.hexString)
                    saveData()
                }
            )
        )
        
        self.present(alert,animated: true, completion: nil )
        App.shared.data.append(color.hexString)
    }
    
    @objc
    func actionTapped(_ sender: UITapGestureRecognizer) {
        colorpicker?.hexLabel.isHidden = true
        colorpicker?.hexLabel.isEnabled = false
        
        textField.text = colorpicker?.hexLabel.text
        textField.isHidden = false
        textField.isEnabled = true
        
        let color = hexStringToUIColor(hex: (colorpicker?.hexLabel.text)!)
        colorpicker?.adjustToColor(color)
        ChangeColorInLabels()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.isHidden = true
        colorpicker?.hexLabel.isEnabled = true
        colorpicker?.hexLabel.isHidden = false
        colorpicker?.hexLabel.text = textField.text
        let color = hexStringToUIColor(hex: (colorpicker?.hexLabel.text)!)
        colorpicker?.adjustToColor(color)
        ChangeColorInLabels()
    }
    
    /*
     @IBAction func press(_ sender: Any) {
     print(colorpicker?.hexLabel.text)
     }
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        colorpicker?.adjustToColor(App.shared.imageColor)
        //colorpicker?.hexLabel.text =
        ChangeColorInLabels()
    }
    
}

extension MainViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return pickerData.count
        } else {
            return App.shared.paletteNames.count
        }
        
    }
}

extension MainViewController : UIPickerViewDelegate {
    
    //    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    //        return pickerData[row]
    //    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "Menlo-Regular", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        if (pickerView.tag == 1){
            pickerLabel?.textColor = .black
            pickerLabel?.text = pickerData[row]
        }
        else{
            pickerLabel?.text = App.shared.paletteNames[row]
        }
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            ChangeColorInLabels()
        }
        else{
            currPalette = App.shared.paletteNames[row]
        }
    }
}



extension MainViewController : ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        
        
        let alert = UIAlertController(title: "Choose palette", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        //alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        pickerFrame.tag = 2
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            App.shared.palettes[self.currPalette]?.append(color.hexString)
            saveData()
            
        }))
        
        self.present(alert,animated: true, completion: nil )
        //App.shared.data.append(color.hexString)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


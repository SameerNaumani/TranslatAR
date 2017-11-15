//
//  ViewTitle.swift
//  
//
//  Created by Geri Elise Madanguit on 11/12/17.
//

import UIKit

class ViewTitleController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 6
    }
    
    
    @IBOutlet public var picker: UIPickerView!
    //@IBOutlet weak var PickerView: UIPickerView!
    var picker_languages:[String]=[String]()
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewARController = segue.destination as? ViewController {
            viewARController.lang = picker.dataSource
        }
        
        
        /*
        //you can get selected value on pickerview
        var selectedValue = pickerData1[pickerview1.selectedRowInComponent(0)]
        
        var pic1 = String(selectedValue)
        print("picker1 count :----------\(pic1)")
        
        
        //datapassed is the variable we declare in another view control.
        svc.dataPassed=pic1
        

        */
        
        
        
    }
    
    func langPicked(text:String?){
        picker.dataSource = text
    }
    */
    override func viewDidLoad(){
        super.viewDidLoad()
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self

        picker_languages = ["English",
                            "Spanish",
                            "French",
                            "German",
                            "Portuguese",
                            "Chinese"]
        
        //self.picker_languages.generate = (self as UIPickerViewDelegate)
        //self.picker_languages.dataSource = (self as UIPickerViewDataSource)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func pickerViewIndex() -> Int {
//        return self.picker_languages.selectedRow(inComponent: 0)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.picker_languages[row]
    }
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker_languages.count
    }
    
    
    
}

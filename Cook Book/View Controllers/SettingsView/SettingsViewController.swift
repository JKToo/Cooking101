//
//  SettingsViewController.swift
//  Cook Book
//
//  Created by Justin on 4/13/22.
//
// Referenced https://www.youtube.com/watch?v=Hf_sianDJWY

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeTxt: UILabel!
    @IBOutlet weak var themeSegment: UISegmentedControl!
    
    let userDefaults = UserDefaults.standard
    let theme_key = "themeKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.view.backgroundColor = UIColor.white
                themeSegment.backgroundColor = UIColor.gray
                themeTxt.textColor = UIColor.black
            } else {
                self.view.backgroundColor = UIColor.appColor(.dark)
                themeSegment.backgroundColor = UIColor.appColor(.blue)
                themeTxt.textColor = UIColor.white
            }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        switch themeSegment.selectedSegmentIndex{
        case 0:
            userDefaults.set(true, forKey: "themeKey")
        case 1:
            userDefaults.set(false, forKey: "themeKey")
        default:
        userDefaults.set(true, forKey: "themeKey")
        }
        updateTheme()
    }
    
    func updateTheme(){
        let theme = userDefaults.bool(forKey: "themeKey")
        if (theme ){
            themeSegment.selectedSegmentIndex = 0
            view.backgroundColor = UIColor.white
            themeTxt.textColor = UIColor.black
        } else {
            themeSegment.selectedSegmentIndex = 1
            view.backgroundColor = UIColor.black
            themeTxt.textColor = UIColor.white
        }
    }

}

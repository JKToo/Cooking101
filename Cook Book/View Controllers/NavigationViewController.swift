//
//  TimerNavigationViewController.swift
//  Cook Book
//
//  Created by Justin on 4/15/22.
//

import UIKit

class NavigationViewController: UINavigationController{
    
        let appearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                UINavigationBar.appearance().standardAppearance = appearance
            } else {
                appearance.titleTextAttributes = [.foregroundColor: UIColor.appColor(.blue) ?? .black]
                UINavigationBar.appearance().standardAppearance = appearance
            }
       
    }

}

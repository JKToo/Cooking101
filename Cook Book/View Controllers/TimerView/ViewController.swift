//
//  ViewController.swift
//  Cook Book
//
//  Created by Justin on 4/30/22.
//

import UIKit

class ViewController: UINavigationController {

    @IBAction func press(_ sender: Any) {
        //https://www.youtube.com/watch?v=P-AXtFoRLTg
        let alarm = UIStoryboard(name: "Main", bundle: nil)
        let controller = alarm.instantiateViewController(withIdentifier: "AlarmController") as! AlarmViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

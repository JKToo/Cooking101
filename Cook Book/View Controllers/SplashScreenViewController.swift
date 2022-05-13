//
//  SplashScreenViewController.swift
//  Cook Book
//
//  Created by Justin on 5/1/22.
//
//https://www.youtube.com/watch?v=cS5H1H8cUUk
import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashImg: UIImageView!
    @IBOutlet weak var splashTxt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashTxt.alpha = 0
        splashImg.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: {
            self.splashImg.alpha = 0.6
        }) { (true) in
            self.getText()
        }
    }
    
    func getText(){
        UIView.animate(withDuration: 2, animations: {
            self.splashTxt.alpha = 0.6
        }) { (true) in
            self.goToMain()
        }
    }
    
    func goToMain(){
        //https://www.youtube.com/watch?v=P-AXtFoRLTg
        let proceed = UIStoryboard(name: "Main", bundle: nil)
        let controller = proceed.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.present(controller, animated: true, completion: nil)
    }
}

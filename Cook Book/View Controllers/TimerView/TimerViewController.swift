//
//  TimerViewController.swift
//  Cook Book
//
//  Created by Justin on 4/14/22.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var player: AVAudioPlayer?
    
        var hoursToInt = 0
        var minutesToInt = 0
        var secondsToInt = 1
        var increment = 0
    
    var hours = [String] ()
    var minutes = [String] ()
    var seconds = [String] ()
    

    var timer = [Timer]()
    @IBAction func startBtn(_ sender: Any) {
        countDown(hr: hoursToInt, min: minutesToInt, sec: secondsToInt)
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        let hourTime = 0...23
        let minuteTime = 0...59
        let secondsTime = 1...59
        
        for i in secondsTime{
            seconds.append(String(i))
        }
        for i in minuteTime{
            minutes.append(String(i))
        }
        
        for i in hourTime{
            hours.append(String(i))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickerView.layer.cornerRadius = 10
        
        pickerView.backgroundColor = UIColor.appColor(.blue)
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.view.backgroundColor = UIColor.white
                textLabel.textColor = UIColor.black
            } else {
                self.view.backgroundColor = UIColor.appColor(.dark)
                textLabel.textColor = UIColor.white
            }
        
    }
    
    //Referenced https://stackoverflow.com/questions/26794703/swift-integer-conversion-to-hours-minutes-seconds
   func timePrint(time: TimeInterval) {
       let hour = Int(time) / 3600
       let minute = Int(time) / 60 % 60
       let second = Int(time) % 60

       self.textLabel.text = String(format: "%02i:%02i:%02i", hour, minute, second)
   }
    
    func countDown(hr: Int, min: Int, sec: Int){
        increment += 1

        var totalInSeconds = (hr * 3600) + (min * 60) + (sec)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.increment > 1 {
                Timer.invalidate()
                if totalInSeconds > 0 {
                    self.timePrint(time: Double(totalInSeconds))
                    totalInSeconds -= 1
                } else {
                    self.timePrint(time: Double(totalInSeconds))
                    Timer.invalidate()
                }
                self.increment = 1
            }
            else {
                if totalInSeconds > 0 {
                self.timePrint(time: Double(totalInSeconds))
                totalInSeconds -= 1
                } else {
                    self.timePrint(time: Double(totalInSeconds))
                    self.increment = 0
                    Timer.invalidate()
                    
                    //https://www.youtube.com/watch?v=P-AXtFoRLTg
                    let alarm = UIStoryboard(name: "Main", bundle: nil)
                    let controller = alarm.instantiateViewController(withIdentifier: "AlarmViewController") as! AlarmViewController
                    self.present(controller, animated: true, completion: nil)
                    
                   
                }
            }
        }
    }

    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if component == 0 {
            return 1
        } else if component == 1 {
            return hours.count
        } else if component == 2 {
            return 1
        } else if component == 3{
            return minutes.count
        } else if component == 4 {
            return 1
        } else { return seconds.count}
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "H: "
        } else if component == 1 {
            return hours[row]
        } else if component == 2{
            return "M: "
        } else if component == 3 {
            return minutes[row]
        } else if component == 4 {
            return "S: "
        } else { return seconds[row]}
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == 1{
           hoursToInt = Int(hours[row]) ?? 0
        } else if component == 3 {
            minutesToInt = Int(minutes[row]) ?? 0
        } else if component == 5{
            secondsToInt = Int(seconds[row]) ?? 0
        }

//        countDown(hr: hoursTemp, min: minutesTemp, sec: secondsTemp)
    }
}

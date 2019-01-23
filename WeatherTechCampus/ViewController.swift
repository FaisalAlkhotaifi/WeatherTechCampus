//
//  ViewController.swift
//  WeatherTechCampus
//
//  Created by TechCampus on 1/20/19.
//  Copyright © 2019 TechCampus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherGetterDelegate {
 
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lbl: UILabel!
    
    var getWeather: GetWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let weather = GetWeather.init()
//        weather.getWeather(city: "Beirut")
        getWeather = GetWeather(delegate: self)
        lbl.text = ""
    }

    @IBAction func getWeatherTapped(_ sender: Any) {
        let city = textField.text
        getWeather.getWeatherByCity(city: city!)
    }
    
    func didGetWeather(weather: Weather) {
        DispatchQueue.main.async {
            self.lbl.text = "\(Int(round(weather.tempCelsius)))°"
        }
    }
    
    func didNotGetWeather(error: Error) {
        let alert = UIAlertController(title: "error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion:  nil)
    }

}


//
//  ViewController.swift
//  whats the weather
//
//  Created by Matthew Jones on 7/28/17.
//  Copyright © 2017 jones code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailsView: UILabel!
    @IBOutlet weak var cityInput: UITextField!
    @IBAction func goButton(_ sender: Any) {
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityInput.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
            let request = NSMutableURLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                var message = ""
                
                if let error = error {
                    print(error)
                } else {
                    if let unwrappedData = data {
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                            if contentArray.count > 1 {
                                stringSeperator = "</span>"
                                let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                                if newContentArray.count > 1 {
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                    print(message)
                                }
                            }
                        }
                    }
                }
                if message == "" {
                    message = "The weather there couldn't be found. Please try again."
                }
                DispatchQueue.main.sync(execute: {
                    self.detailsView.text = message
                })
            }
        task.resume()
        } else {
            detailsView.text = "The weather there couldn't be found. Please try again."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var forecastCity: UILabel!
    @IBOutlet weak var weatherCV: UICollectionView!
    
    @IBOutlet weak var searchButton: UITextField!
    
    var cityName = ""
    
    public var forecast = [PeriodsData](){
        didSet {
            DispatchQueue.main.async {
                self.weatherCV.reloadData()
            }
        }
    }
    private var imagePickerVC: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCV.dataSource = self
        weatherCV.delegate = self
        searchButton.delegate = self
        print(DataPersistenceManager.documentsDirectory())
        
        WeatherAPIClient.searchWeather(zipcode: "43228", isZipcode: true) { (appError, periods) in
            if let error = appError {
                print(error.errorMessage())
            }
            if let periods = periods {
                self.forecast = periods
                dump(self.forecast)
            }
        }
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        weatherCV.reloadData()
    //    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailedViewController
            else { return }
        guard let cell = sender as? WeatherCollectionViewCell
            else { return }
        guard let indexpath = weatherCV.indexPath(for: cell) else{return}
        let forecast = self.forecast[indexpath.row]
        destination.dayInfo = forecast
        destination.cityName = self.cityName
    
}
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCV.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell()}
        let day = forecast[indexPath.row]
        forecastCity.text = "Weather forecast for \(cityName)"
        cell.dateLabel.text = "\(day.validTime)"
        cell.iconImage.image = UIImage(named: day.icon)
        cell.highTempLabel.text = "High:\(day.maxTempF) F"
        cell.lowTempLabel.text = "Low:\(day.minTempF) F"
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: weatherCV.frame.width, height: weatherCV.frame.height)
    }
}




extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return true}
        ZipCodeHelper.getLocationName(from: text) { (error, cityName) in
            if let error = error {
                print(error)
                
            } else if let cityName = cityName {
                self.cityName = cityName
            }
            
            WeatherAPIClient.searchWeather(zipcode: text, isZipcode: true, completionHandler: { (error, periods) in
                if let periods = periods {
                self.forecast = periods
                }
            })
            
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let destination = segue.destination as? DetailedViewController
                else { return }
            guard let cell = sender as? WeatherCollectionViewCell
                else { return }
            guard let indexpath = weatherCV.indexPath(for: cell) else{return}
            let forecast = self.forecast[indexpath.row]
            destination.dayInfo = forecast
            destination.cityName = self.cityName
    }
}
}

//
//  ViewController.swift
//  MyMap
//
//  Created by USER1 on 2020/05/16.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController ,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Text Fieldのdeldgate通知先を設定
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!

    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる(1)
        textField.resignFirstResponder()
        
       // 入力された文字を取り出す(2)
        if let searchKey = textField.text {
            // 入力された文字をでバックエリアに表示(3)
            print(searchKey)
            
            // CLGeocoderインスタンスを取得(5)
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得(6)
            geocoder.geocodeAddressString(searchKey, completionHandler: {(placemarks,error) in
               
                // 位置情報が存在する場合は、unwrapPlacemarksに取り出す(7)
                if let unwrapPlacemarks = placemarks {
                    
                    // 1件目の情報を取り出す(8)
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        // 位置情報を取り出す(9)
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度をtargetCoordinateに取り出す(10)
                            let targetCoordinate =  location.coordinate
                            
                            // 緯度経度をでバックエリアに表示(11)
                            print(targetCoordinate)
                            
                            // MKPointAnnotationのインスタンスを取得し、ピンを生成(12)
                            let pin = MKPointAnnotation()
                            
                            // ピンの置く場所に緯度経度を設定(13)
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定(14)
                            pin.title = searchKey
                            
                            // ピンを地図に置く(15)
                            self.dispMap.addAnnotation(pin)
                            
                            // 緯度経度を中心にして半径500mの範囲を表示(16)
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters:
                                500.0, longitudinalMeters: 500.0)
                            
                            
                        }
                    }
                }
            })
        }
       
       // デフォルト動作を行うのでtrueを返す(4)
       return true
    }

    @IBAction func changeMapButton(_ sender: Any) {
        //
        //
        //
        //
        if dispMap.mapType == .standard {
            dispMap.mapType = .satellite
        } else if dispMap.mapType == .satellite {
            dispMap.mapType = .hybrid
        } else if dispMap.mapType == .hybrid{
            dispMap.mapType = .satelliteFlyover
        } else if dispMap.mapType == .satelliteFlyover {
            dispMap.mapType = .hybridFlyover
        } else if dispMap.mapType == .hybridFlyover {
            dispMap.mapType = .mutedStandard
        } else {
            dispMap.mapType = .standard
        }
        
    }
}


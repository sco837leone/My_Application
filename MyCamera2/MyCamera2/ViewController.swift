//
//  ViewController.swift
//  MyCamera
//
//  Created by Swift-Beginners on 2019/08/14.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    // カメラを起動するをタップすると実行
    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("カメラは利用できます")
            // (1)UIImagePickerControllerのインスタンスを作成
            let imagePickerController = UIImagePickerController()
            // (2)sourceTypeにcameraを設定
            imagePickerController.sourceType = .camera
            // (3)delegate設定
            imagePickerController.delegate = self
            // (4)モーダルビューで表示
            present(imagePickerController, animated: true, completion: nil)
        } else {
            print("カメラは利用できません")
        }
    }
    
    // SNSに投稿するをタップすると実行
    @IBAction func shareButtonAction(_ sender: Any) {
        // 表示画像をアンラップしてシェア画像を取り出す
        if let shareImage = pictureImage.image {
            // UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            // UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            // iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            // UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    // (1)撮影が終わったときに呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // (2)撮影した画像を配置したcaptureImageに渡す
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // (3)モーダルビューを閉じる
        dismiss(animated: true, completion: {
            // エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    
    // 次の画面遷移をする時に渡す画像を格納する場所
    var captureImage : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面のインスタンスを格納
        if let nextViewController = segue.destination as? EffectViewController {
            // 次の画面のインスタンスに取得した画像を渡す
            nextViewController.originalImage = captureImage
        }
        
    }
}


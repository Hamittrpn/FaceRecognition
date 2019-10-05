//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Hamit  Tırpan on 5.10.2019.
//  Copyright © 2019 Hamit  Tırpan. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // FaceRecognize yapabilmek için info.plist'ten ayar eklemek gerekli (Privacy -FaceID)
    @IBAction func signInClicked(_ sender: Any) {
        let  authContext = LAContext()
        
        // canEvaluatePolicy bir NSError beklediği için oluşturdum.
        var error : NSError?
        
        // Eğer telefon özellik olarak Yüz tanımaya sahipse... Biometric -> Yüz ya da parmak izi
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            // localized Reason : Neden bu işlemi yapıyorsun ?
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                if success == true{
                    // Dispatch kullandım.Çünkü eğer arkaplanda bir işlem yapıyorsak, yani UI'da kullanıcının etkileşimini etkileyecek bir işlem yapıyorsam, bu işlemleri artık farkı bir seviyede, farklı bir thread'de yapmam gerekiyor.Bu yüzden performSegue ve myLabel'mı main thread'te kullanmam gerekiyor.
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error"
                    }
                }
            }
        }
    }
}


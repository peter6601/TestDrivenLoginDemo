//
//  LoginViewController.swift
//  TestDrivenLoginDemo
//
//  Created by 丁暐哲 on 2018/11/20.
//  Copyright © 2018 PeterDinDin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAccount: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var llAccountError: UILabel!
    @IBOutlet weak var llpasswordError: UILabel!
    var vm: LoginViewModel = LoginViewModel()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        var output = vm.outputs
        output.submitButtonEnble = { (isEnable) in
            self.btnLogin.isEnabled = isEnable
            self.btnLogin.backgroundColor = isEnable ? UIColor(withHex: 0x06B3E9) : UIColor(withHex: 0xd7dce2)
        }
        vm.inputs.viewDidLoad()
        output.alertMessage = { (info) in
           let alert =  UIAlertController(title: nil, message: info, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        tfAccount.addTarget(self, action: #selector(tfAccountEdit), for: .editingChanged)
        tfName.addTarget(self, action: #selector(tfNameEdit), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(tfPasswordEdit), for: .editingChanged)
        btnLogin.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)

    }
    
   @objc func tfAccountEdit(_ sender: UITextField) {
        vm.inputs.emailChanged(email: sender.text)
    }
    @objc func tfNameEdit(_ sender: UITextField) {
        vm.inputs.nameChanged(name: sender.text)
    }
    @objc func tfPasswordEdit(_ sender: UITextField) {
        vm.inputs.passwordChanged(password: sender.text)
    }
    
    @objc func btnLoginTapped(_ sender: UIButton) {
        vm.inputs.submitButtonPressed()
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Float) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        let newAlpha = CGFloat(alpha)
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
    convenience init(withHex hex: Int) {
        let newRed = CGFloat((hex & 0xFF0000) >> 16) / 255
        let newGreen = CGFloat((hex & 0x00FF00) >> 8) / 255
        let newBlue = CGFloat((hex & 0x0000FF)) / 255
        let newAlpha = CGFloat(1.0)
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
    }
}

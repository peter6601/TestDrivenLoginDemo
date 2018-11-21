//
//  LoginViewModel.swift
//  TestDrivenLoginDemo
//
//  Created by 丁暐哲 on 2018/11/20.
//  Copyright © 2018 PeterDinDin. All rights reserved.
//

import Foundation


protocol LoginViewModelInputs {
    func nameChanged(name: String?)
    func emailChanged(email: String?)
    func passwordChanged(password: String?)
    func submitButtonPressed()
    func viewDidLoad()
    
}

protocol LoginViewModelOutputs {
    var alertMessage: ((String) -> ())? {get set }
    var submitButtonEnble: ((Bool) -> ())? {get set }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

class LoginViewModel: LoginViewModelType, LoginViewModelInputs, LoginViewModelOutputs {
    
    var alertMessage: ((String) -> ())?
    var submitButtonEnble: ((Bool) -> ())?
    
    init() {
    
    }
    private var tappedCount: Int = 0
    let submitButtonCompletion: (()->())? = nil
    func submitButtonPressed() {
        let result = checkLoginIsValid(name: nameString, email: emailString, password: passwordString)
        guard result.isSuccess else{
            tappedCount += 1
            if tappedCount >= 3 {
                submitButtonEnble?(false)
                 alertMessage?("Too Many Attempts")
                print("much false button")
            } else {
                alertMessage?(result.info)
                print("false button")
            }
            return
        }
        alertMessage?(result.info)
        tappedCount = 0
        submitButtonCompletion?()
    }
    
    let viewDidLoadCompletion: (()->())? = nil
    func viewDidLoad() {
        submitButtonEnble?(false)
        viewDidLoadCompletion?()
    }
    
    
    private var nameString: String? = nil {
        didSet {
            submitButtonEnble?(checkSubmitButtonEnbled(name: nameString, email: emailString, password: passwordString))
        }
    }
    func nameChanged(name: String?) {
        nameString = name
    }
    
    private var emailString :String? = nil{
        didSet {
            submitButtonEnble?(checkSubmitButtonEnbled(name: nameString, email: emailString, password: passwordString))
        }
    }
    func emailChanged(email: String?) {
        emailString = email
    }
    
    var passwordString:String? = nil{
        didSet {
            submitButtonEnble?(checkSubmitButtonEnbled(name: nameString, email: emailString, password: passwordString))
        }
    }
    func passwordChanged(password: String?) {
        passwordString = password
    }
    
    
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
    
}

extension LoginViewModel {
    
    func checkSubmitButtonEnbled(name: String?, email: String?, password: String?) -> Bool {
        guard let name = name, let email = email , let password = password,
            !name.isEmpty, !email.isEmpty, !password.isEmpty else {
                return false
        }
        return true
    }
    
    func checkLoginIsValid(name: String?, email: String?, password: String?) -> (isSuccess: Bool, info: String){
        guard let name = name, let email = email , let password = password,
            !name.isEmpty, !email.isEmpty, !password.isEmpty else {
                return (false, "UnSuccessful")
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailTest.evaluate(with: email) else {
            return (false, "UnSuccessful" )
        }
        return(true, "Successful")
    }
    
}

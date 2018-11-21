//
//  TestDrivenLoginDemoTests.swift
//  TestDrivenLoginDemoTests
//
//  Created by 丁暐哲 on 2018/11/20.
//  Copyright © 2018 PeterDinDin. All rights reserved.
//

import XCTest
@testable import TestDrivenLoginDemo

class TestDrivenLoginDemoTests: XCTestCase {
    let vm = LoginViewModel()

    override func setUp() {
        vm.inputs.viewDidLoad()
    }
    
    
    func testSumbittButtonEnbled() {
        var outputs = vm.outputs
        var list: [Bool] = []
        outputs.submitButtonEnble = { (isEnable) in
            list.append(isEnable)
            if list.count >= 4 {
                XCTAssertEqual(list, [false, false,true, false])
            }
        }
        vm.inputs.nameChanged(name: "DinDin")
        vm.inputs.emailChanged(email: "DinDin@gmail.com")
        vm.inputs.passwordChanged(password: "1234")
        vm.inputs.nameChanged(name: "")
        
    }
    
    func testSuccesSingUp() {
        var outputs = vm.outputs
        outputs.alertMessage = { (info) in
            XCTAssertEqual(info, "Successful")
        }
        vm.inputs.nameChanged(name: "DinDin")
        vm.inputs.emailChanged(email: "DinDin@gmail.com")
        vm.inputs.passwordChanged(password: "1234")
        vm.inputs.submitButtonPressed()
        
    }
    
    func testUnSuccesSingUp() {
        var outputs = vm.outputs
        outputs.alertMessage = { (info) in
            XCTAssertEqual(info, "UnSuccessful")
        }
        vm.inputs.nameChanged(name: "DinDin")
        vm.inputs.emailChanged(email: "DinDin@gmail")
        vm.inputs.passwordChanged(password: "1234")
        vm.inputs.submitButtonPressed()
        
    }
    
    func testTooManyAttempts() {
        var outputs = vm.outputs
        var list: [Bool] = []
        var messageList: [String] = []
        let testList = [false,false, true, false]
        outputs.alertMessage = { (info) in
            messageList.append(info)
            if messageList.count >= 3 {
                XCTAssertEqual(messageList, ["UnSuccessful", "UnSuccessful", "Too Many Attempts"])
            }
        }
        
        outputs.submitButtonEnble = { (isEnable) in
            list.append(isEnable)
            if list.count >= 4 {
                XCTAssertEqual(testList, list)
            }
        }
        vm.inputs.nameChanged(name: "DinDin")
        vm.inputs.emailChanged(email: "DinDin@gmail")
        vm.inputs.passwordChanged(password: "1234")
        vm.inputs.submitButtonPressed()
        vm.inputs.submitButtonPressed()
        vm.inputs.submitButtonPressed()
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
}

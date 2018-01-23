//
//  ViewController.swift
//  TouchID-Swift
//
//  Created by Shaoting Zhou on 2018/1/23.
//  Copyright © 2018年 Shaoting Zhou. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建LAContext
        let context = LAContext.init()
        
        //这个属性是设置指纹输入失败之后的弹出框的选项
        context.localizedFallbackTitle  = "没有忘记密码"
        
        var error:NSError? = nil
        if(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)){
            print("支持指纹识别")
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请按home键指纹解锁", reply: { (success, err) in
                if(success){
                    print("验证成功,刷新界面")
                }else{
                    print("发生错误:\(String(describing: error))")
                    let error:LAError = err! as! LAError
                    switch (error.code) {
                    case .systemCancel:
                        print("系统取消授权，如其他APP切入")
                        break
                    case .userCancel:
                        print("用户取消验证Touch ID")
                        break
                    case .authenticationFailed:
                        print("授权失败")
                        break
                    case .userFallback:
                        print("用户返回")
                        break
                    case .passcodeNotSet:
                        print("用户尚未位置指纹")
                        break
                    case .touchIDNotAvailable:
                        print("设备Touch ID未响应")
                        break
                    case .touchIDNotEnrolled:
                        print("设备Touch ID不可用")
                        break
                    case .touchIDLockout:
                        print("ouch ID锁住")
                        break
                    case .appCancel:
                        print("app验证Touch ID")
                        break
                    case .invalidContext:
                        print("无效Touch ID")
                        break
                    case .notInteractive:
                        print("不可交互")
                        break
                    }
                }
                
                
            })
            
        }else{
            print("不支持touchID")
        
        }
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


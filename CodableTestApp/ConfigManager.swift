//
//  ConfigManager.swift
//  CodableTestApp
//
//  Created by YooSeunghwan on 2018/05/02.
//  Copyright © 2018年 Yoo. All rights reserved.
//

import Foundation

class ConfigManager {
    static let sharedInstance : ConfigManager = {
        let instance = ConfigManager()
        return instance
    }()
    
    //API
    public var ApiPath:String?
    public var ApiQuery:String?
    public var ApiSort:String?
    public var ApiOrder:String?
    // TODO : これの以下に追加
    
    private init() {
        ApiPath = Bundle.main.object(forInfoDictionaryKey: "ApiPath") as? String
        ApiQuery = Bundle.main.object(forInfoDictionaryKey: "ApiQuery") as? String
        ApiSort = Bundle.main.object(forInfoDictionaryKey: "ApiSort") as? String
        ApiOrder = Bundle.main.object(forInfoDictionaryKey: "ApiOrder") as? String
        // これの以下に追加
    }
    
    func description(){
        #if DEBUG
        print("↓↓↓↓↓ envelopement ↓↓↓↓↓")
        print("")
        print("API section")
        print("ApiPath : \(ApiPath!)")
        print("ApiQuery : \(ApiQuery!)")
        print("ApiSort : \(ApiSort!)")
        print("ApiOrder : \(ApiOrder!)")
        print("")
        print("↑↑↑↑↑ envelopement ↑↑↑↑↑")
        #endif
    }
}

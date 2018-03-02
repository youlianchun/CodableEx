//
//  ViewController.swift
//  CodableEx
//
//  Created by YLCHUN on 2018/3/2.
//  Copyright © 2018年 YLCHUN. All rights reserved.
//

import UIKit

class CodableModel2 : CodableExProtocol
{
    var num : String?
    var flag : String?
    enum CodingKeys : String, CodingKey
    {
        case num
        case flag
    }
    convenience required init(from decoder: Decoder) throws
    {// 自定义decoder
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        num = try container.decode(String.self, forKey: .num)
        flag = try container.decode(String.self, forKey: .flag)
    }
    public func encode(to encoder: Encoder) throws
    {// 自定义encoder
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(num, forKey: .num)
        try container.encode(flag, forKey: .flag)
    }
}

enum ModelType: Int, Codable
{
    case TA
    case TB
}

class CodableModel : CodableExProtocol
{
    var num : String?
    var flag : String?
    var model : Array<CodableModel2>?
    var mt : ModelType?
    
    enum CodingKeys : String, CodingKey
    {
        case num
        case flag = "flag_f"
        case model
        case mt
    }
}

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        defer {
            
        }
        super.viewDidLoad()
        codableEx()
    }
    
    func codableEx()
    {
        let dict : [String : Any] = ["num":"001", "flag_f":"A", "mt":0 , "model":[["num":"0011", "flag":"A"]]]
        
        let arr : Array<[String : Any]> = [
            ["num":"001", "flag_f":"A", "mt":0 , "model":[["num":"0011", "flag":"A"]]],
            ["num":"002", "flag_f":"A", "mt":1 , "model":[["num":"0021", "flag":"B"]]]
        ]
        
        let model : CodableModel? = dict.decode()

        let models : Array<CodableModel>? = arr.decode()
        
        let dict2 : [String : Any]? = model?.encode()
        
        let arr2 = models?.encode()
        
        let json : String? = model?.encode()
        
        let data : Data? = model?.encode()

        print(dict2!, arr2!, json!, data!)

    }

}




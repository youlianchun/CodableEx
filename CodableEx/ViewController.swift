//
//  ViewController.swift
//  CodableEx
//
//  Created by YLCHUN on 2018/3/2.
//  Copyright © 2018年 YLCHUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        codableEx()
    }
    
    func codableEx()
    {
        let dict : [String:Any] = ["num":"001", "flag_f":"A", "mt":0 , "model":[["num":"0011", "flag":"A"]]]

        let arr : Array<[String:Any]> = [
            ["num":"001", "flag_f":"A", "mt":0 , "model":[["num":"0011", "flag":"A"]]],
            ["num":"002", "flag_f":"A", "mt":1 , "model":[["num":"0021", "flag":"B"]]]
        ]

        do {
            let model   : CodableModel         = try dict.decode()
            let models  : [CodableModel]       = try arr.decode()
            let arr2    : Array<[String:Any]>  = try models.encode()
            let dict2   : [String:Any]         = try model.encode()
            
            let json    : String               = try CodableEx().encode(model)
            let json2   : String               = try CodableEx().encode(models)
            
            
            print(dict2, arr2, json, json2)
            
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }
}

extension RawRepresentable{ var rawName : String { get{ return "\(self)" } } }

func enumValue<E:RawRepresentable>(value:E.RawValue) -> E? { return E(rawValue: value) }



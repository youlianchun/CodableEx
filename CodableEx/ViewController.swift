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

        let model   : CodableModel?         = dict.decode()
        let models  : [CodableModel]?       = arr.decode()
        let arr2    : Array<[String:Any]>?  = models?.encode()
        let dict2   : [String:Any]?         = model?.encode()
        let json    : String?               = model?.encode()
        let data    : Data?                 = model?.encode()

        print(dict2!, arr2!, json!, data!)

    }
}

extension RawRepresentable{ var rawName : String { get{ return "\(self)" } } }

func enumValue<E:RawRepresentable>(value:E.RawValue) -> E? { return E(rawValue: value) }



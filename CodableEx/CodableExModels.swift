//
//  CodableExModels.swift
//  CodableExTests
//
//  Created by YLCHUN on 2018/3/5.
//  Copyright © 2018年 YLCHUN. All rights reserved.
//

import Foundation

class CodableModel2 : CodableExProtocol
{
    var num : String?
    var flag : String?
    
    func finishEncode() ->Void
    {
        print("finishEncode\(self)")
    }
    
    func finishDecode() ->Void
    {
        print("finishDecode\(self)")
    }
    
    //    enum CodingKeys : String, CodingKey
    //    {
    //        case num
    //        case flag
    //    }
    //    convenience required init(from decoder: Decoder) throws
    //    {// 自定义decoder
    //        let container = try decoder.container(keyedBy: CodingKeys.self)
    //        self.init()
    //        num = try container.decode(String.self, forKey: .num)
    //        flag = try container.decode(String.self, forKey: .flag)
    //    }
    //    public func encode(to encoder: Encoder) throws
    //    {// 自定义encoder
    //        var container = encoder.container(keyedBy: CodingKeys.self)
    //        try container.encode(num, forKey: .num)
    //        try container.encode(flag, forKey: .flag)
    //    }
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
    
    func finishEncode() ->Void
    {
        print("finishEncode\(self)")
    }
    
    func finishDecode() ->Void
    {
        print("finishDecode\(self)")
    }
}

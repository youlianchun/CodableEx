# CodableEx
swift 4.0 模型解析，基于Codable
### CodableEx api
```
public protocol CodableExProtocol : Decodable, Encodable {

    public func finishEncode()

    public func finishDecode()
}

extension CodableExProtocol {

    internal func finishEncode()

    internal func finishDecode()

    internal func encode() throws -> [String : Any]
}

extension Array where Element : Encodable {

    internal func encode() throws -> Array<[String : Any]>
}

extension Dictionary where Key == String {

    internal func decode<T>() throws -> T where T : Decodable
}

extension Array where Element == [String : Any] {

    internal func decode<T>() throws -> Array<T> where T : Decodable
}

final internal class CodableEx {

    internal func decode<T>(_ dict: [String : Any]) throws -> T where T : Decodable

    internal func decode<T>(_ arr: Array<[String : Any]>) throws -> Array<T> where T : Decodable

    internal func encode<T>(_ model: T) throws -> [String : Any] where T : Encodable

    internal func encode<T>(_ models: Array<T>) throws -> Array<[String : Any]> where T : Encodable
}

extension CodableEx {

    internal func decode<T>(_ json: String) throws -> T where T : Decodable

    internal func decode<T>(_ json: String) throws -> Array<T> where T : Decodable

    internal func encode<T>(_ model: T) throws -> String where T : Encodable

    internal func encode<T>(_ models: Array<T>) throws -> String where T : Encodable
}
```
#### 使用示例
model class

```
class CodableModel2 : CodableExProtocol
{
    
    var num : String?
    var flag : String?
    
    func finishEncode() ->Void {
        print("finishEncode\(self)")
    }
    
    func finishDecode() ->Void {
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
    
    func finishEncode() ->Void {
        print("finishEncode\(self)")
    }
    
    func finishDecode() ->Void {
        print("finishDecode\(self)")
    }
}
```
使用方式
```
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
```

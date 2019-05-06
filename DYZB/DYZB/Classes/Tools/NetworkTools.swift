//
//  NetworkTools.swift
//  AlamofireTest
//
//  Created by 赵斌 on 2019/1/24.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}
class NetworkTools {
    
    
    class func requestData(type : MethodType ,URLString : String , parameters : [String : Any]? = nil, finishedCallback :  @escaping ( _ result : Any) -> ()){
        //获取类型
        let method = (type == MethodType.GET ? HTTPMethod.get : HTTPMethod.post)
      
        
        Alamofire.request(URLString,  method:  method, parameters: parameters).responseJSON{(response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallback(result)
        }
}
}

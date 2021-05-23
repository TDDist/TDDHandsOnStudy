//
//  VarianceError.swift
//  Variance
//
//  Created by 스마트스터디_김도형 on 2021/04/10.
//

import Foundation

enum VarianceError: LocalizedError {
    case numsEmptyError
    case numsOnlyOneElementError
    
    var errorDescription: String? {
        switch self {
        case .numsEmptyError:
            return "nums 배열의 원소가 비어있으면 안됩니다"
        case .numsOnlyOneElementError:
            return "nums 배열의 원소가 하나만 있으면 안됩니다. Nan Error 를 일으킵니다."
        }
    }
}

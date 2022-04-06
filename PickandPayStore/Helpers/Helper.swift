//
//  Helper.swift
//  PickandPayStore
//
//  Created by iMac on 4/5/22.
//

import Foundation

func delay(durationInSeconds seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

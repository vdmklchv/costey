//
//  UpdateUIProtocol.swift
//  Costey
//
//  Created by Vadim Colcev on 12/18/20.
//

import Foundation

protocol UpdateUIProtocol {
    var onDataRefresh: (() -> Void)? { get set }
}

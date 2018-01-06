//
//  CompletionHandlerType.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

typealias CompletionHandlerType<T> = (() throws -> T) -> Void

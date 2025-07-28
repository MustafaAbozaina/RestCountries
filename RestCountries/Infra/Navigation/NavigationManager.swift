//
//  NavigationManager.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ target: NavigationTarget) {
        path.append(target)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum NavigationTarget: Hashable {
    case countryDetails(Country)
}

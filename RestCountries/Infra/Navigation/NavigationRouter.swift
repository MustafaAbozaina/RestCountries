//
//  NavigationRouter.swift
//  RestCountries
//
//  Created by Mustafa Abozaina on 7/28/25.
//


protocol NavigationRouter {
    var navigationManager: NavigationManager { get  set }
    init(navigationManager: NavigationManager)
}

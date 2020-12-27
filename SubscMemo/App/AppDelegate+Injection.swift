//
//  AppDelegate+Injection.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/14.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {

        // register application components
        register { AuthenticationService() }.scope(application)
        register { FirestoreSubscRepository() as SubscRepository }.scope(application)
        register { FirestoreExploreSubscRepository() as ExploreSubscRepository }.scope(application)
    }
}

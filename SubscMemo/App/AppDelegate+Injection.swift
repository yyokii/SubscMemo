//
//  AppDelegate+Injection.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/14.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {

        register { AuthenticationService() }.scope(.application)

        // Repositoryの登録
        register { FirestoreAnnouncementBannerRepository() as AnnouncementBannerRepository }.scope(.application)
        register { FirestoreExploreSubscRepository() as ExploreSubscRepository }.scope(.application)
        register { FirestoreUserProfileRepository() as UserProfileRepository }.scope(.application)
        register { FirestoreSubscCategoryRepository() as SubscCategoryRepository }.scope(.application)
        register { FirestoreSubscribedServiceRepository() as SubscribedServiceRepository }.scope(.application)

    }
}

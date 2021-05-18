//
//  SubscItemViewDataTranslator.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/13.
//

//struct SubscItemViewDatasTranslator: Translator {
//
//    struct InputData {
//        let item: SubscribedItem
//        let categories: [SubscCategory]
//    }
//
//    func translate(from input: SubscItem) -> SubscItemViewData {
//
//        let categoryName = input.categories.first {
//            input.item.mainCategoryID == $0.categoryID
//        }?.name ?? ""
//
//        return SubscItemViewData(name: input.item.name,
//                                 price: input.item.price,
//                                 category: categoryName,
//                                 plan: input.item.planName,
//                                 description: input.item.description,
//                                 iconImageURL: input.item.iconImageURL,
//                                 serviceID: input.item.serviceID)
//    }
//}

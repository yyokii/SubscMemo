//
//  UserProfileView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/15.
//

import SwiftUI

struct UserProfileView: View {

    @ObservedObject var userProfileVM = UserProfileViewModel()

    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 20, height: 20)
            Text(userProfileVM.name)
        }
        .padding()
    }
}

#if DEBUG
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userProfileVM: demoUserProfileVM)
    }
}
#endif

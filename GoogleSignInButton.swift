//
//  GoogleSignInButton.swift
//  iosApp
//
//  Created by Pratidnya Lakmable on 3/7/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: View {
    @EnvironmentObject var vm: UserAuthModel
        
        fileprivate func SignOutButton() -> Button<Text> {
            Button(action: {
                vm.signOut()
            }) {
                Text("Sign Out")
            }
        }
        
        fileprivate func ProfilePic() -> some View {
            AsyncImage(url: URL(string: vm.profilePicUrl))
                .frame(width: 100, height: 100)
        }
        
        fileprivate func UserInfo() -> Text {
            return Text(vm.givenName)
        }
        
        var body: some View {
            VStack{
                UserInfo()
                ProfilePic()
                if(vm.isLoggedIn){
                    SignOutButton()
                }
            }.navigationTitle("Login")
        }
}

struct GoogleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInButton()
    }
}

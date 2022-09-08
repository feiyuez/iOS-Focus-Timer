//
//  ProfileView.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/12/21.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showSettingSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                        .frame(height: 30)
                    
                    Text("Past Goals")
                        .font(.title)
                        .fontWeight(.semibold)
                    GoalList()
                    
                    Spacer()
                }
                .padding(20)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//  StartView.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/12/21.
//

import SwiftUI

struct StartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var timerModel = TimerModel()
    
    @State var showGoalSheet = false
    @State var showMainView1 = false
    @State var showMainView2 = false
    @State var editConfirmed = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                    .frame(height: 30)
                
                Text("Quick Start")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("A standard 25:5 focus pattern repeating 4 times.")
                
                NavigationLink(destination: MainView(),
                           isActive: $showMainView1) {
                    Button(action: {
                        let newGoal = Goal(context: viewContext)
                        newGoal.timestamp = Date()
                        newGoal.numOfSessions = 4
                        newGoal.lengthOfFocus = 25
                        newGoal.lengthOfRelax = 5
                        newGoal.completedFocus = 0
                        do {
                            try viewContext.save()
                            print("Goal saved.")
                        } catch {
                            print(error.localizedDescription)
                        }
                        timerModel.setTimer(focus: 25, relax: 5, sessions: 8)
                        showMainView1 = true
                    }) {
                        Text("GO NOW")
                            .font(.headline)
                            .padding(15)
                            .background(Color.orange)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                }
                
                Spacer()
                    .frame(height: 40)
                
                Text("Customize")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Set a unique timer that fits your learning habits.")
                
                Button(action: {
                    showGoalSheet = true
                }) {
                    Text("EDIT & GO")
                        .font(.headline)
                        .padding(15)
                        .background(Color.orange)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                .padding(.top)
                .sheet(isPresented: $showGoalSheet, onDismiss: {
                    if editConfirmed == true {
                        showMainView2 = true
                    }
                }, content: {
                    GoalSheet(edited: $editConfirmed)
                })
                
                NavigationLink(
                    destination: MainView(),
                    isActive: $showMainView2,
                    label: {
                        EmptyView()
                    })
                    .onDisappear(perform: {
                        editConfirmed = false
                    })
                
                Spacer()
            }
            .padding(20)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

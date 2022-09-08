//
//  GoalSheet.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/13/21.
//

import SwiftUI

struct GoalSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var timerModel = TimerModel()
    
    @State var numOfSessions: Int16 = 4
    @State var lengthOfFocus: Int16 = 5
    @State var lengthOfRelax: Int16 = 1
    
    @Binding var edited: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Focus Pattern")) {
                    Stepper("\(lengthOfFocus * 5) mintues focus", value: $lengthOfFocus, in: 1...12)
                    Stepper("\(lengthOfRelax * 5) mintues break", value: $lengthOfRelax, in: 1...12)
                }
                Section(header: Text("Goal"), footer: Text("Each session is composed of one focus and one break.")) {
                    Stepper("\(numOfSessions) sessions", value: $numOfSessions, in: 1...12)
                }
                
                Button(action: {
                    let newGoal = Goal(context: viewContext)
                    newGoal.timestamp = Date()
                    newGoal.numOfSessions = numOfSessions
                    newGoal.lengthOfFocus = lengthOfFocus * 5
                    newGoal.lengthOfRelax = lengthOfRelax * 5
                    newGoal.completedFocus = 0
                    do {
                        try viewContext.save()
                        print("Goal saved.")
                    } catch {
                        print(error.localizedDescription)
                    }
                    timerModel.setTimer(focus: Int(lengthOfFocus * 5), relax: Int(lengthOfRelax * 5), sessions: Int(numOfSessions * 2))
                    edited = true
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Start")
                })
            }
            .navigationBarTitle("Customize")
        }
    }
}

struct GoalSheet_Previews: PreviewProvider {
    static var previews: some View {
        GoalSheet(numOfSessions: 2, lengthOfFocus: 25, lengthOfRelax: 5, edited: .constant(false))
    }
}

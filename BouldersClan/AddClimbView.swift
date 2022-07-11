//
//  AddClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct AddClimbView: View {
    @ObservedObject var climbs: Climbs
    @Binding var isShowingGridView: Bool
    
    @State private var isSent = true
    @State private var grade = 0
    @State private var attempts = 1
    @State private var selectedColourIndex = 0
    @State private var date = Date.now
    let colours = ["White", "Green", "Blue", "Black", "Pink", "Red", "Purple", "Yellow", "Orange"]
    @State private var selectedColour = "White"
    
    func gradeCalculation(_ direction: Bool) {
        if direction == true && grade < 10 {
            grade += 1
        }
        
        if direction == false && grade > 0 {
            grade -= 1
        }
    
    }
    
    func resetClimb() {
        attempts = 1
        isSent = true
        isShowingGridView = isShowingGridView
    }
    
    var body: some View {
        VStack {
            Section() {
                Text("Current Project")
                    .font(.title)
                
                // Display mode switcher.
                Button("Switch view") {
                    isShowingGridView.toggle()
                }
            }
            HStack(alignment: .top) {
                // Grade Stack.
                VStack {
                    Button("V\(grade)") {
                        gradeCalculation(true)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    Button("-") {
                        gradeCalculation(false)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                Spacer()
                // Attemps Stack.
                VStack {
                    Button("\(attempts)") {
                        attempts += 1
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    Button("-") {
                        if attempts > 1 {
                            attempts -= 1
                        }
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                Spacer()
                Button (isSent ? "Sent" : "No send") {
                    isSent.toggle()
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                Spacer()
                Picker("Grade color", selection: $selectedColour, content: {
                    ForEach(colours, id: \.self, content: { color in
                        Text(color)
                    })
                })
                .pickerStyle(.menu)
                Spacer()
                Button("Save") {
                    withAnimation {
                        let item = Climb(
                                grade: grade,
                                isSent: isSent,
                                attempts: attempts,
                                selectedColourIndex: selectedColourIndex,
                                colours: colours,
                                selectedColour: selectedColour,
                                date: date
                            )
                        // Add climb into array.
                        climbs.items.insert(item, at: 0)
                    }
                    resetClimb()
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            .padding()
            .frame(alignment: .bottom)

        }
    }
}

struct AddClimbView_Previews: PreviewProvider {
    static var previews: some View {
        AddClimbView(climbs: Climbs(), isShowingGridView: .constant(true))
    }
}

//
//  AddClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import CoreData
import SwiftUI

struct AddClimbView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isShowingGridView: Bool
    
    @State private var isSent = true
    @State private var grade = 0
    @State private var attempts = 1
    @State private var selectedColourIndex = 0
    @State private var date = Date.now
    let colours = ["White", "Green", "Blue", "Black", "Pink", "Red", "Purple", "Yellow", "Orange"]
    @State private var routeColour = "White"
    
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
            HStack() {
                Text("Add climb")
                    .font(.title)
                
                Spacer()
                
                // Display mode switcher.
                Button {
                    isShowingGridView.toggle()
                } label: {
                    Label("Grid", systemImage: isShowingGridView ? "rectangle.grid.1x2" : "square.grid.3x3")
                        .labelStyle(.iconOnly)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical)
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
                // Maybe use toggle if text can be moved?
                // Toggle(isSent ? "Sent" : "No send", isOn: $isSent).toggleStyle(.switch)
                Button (isSent ? "Sent" : "No send") {
                    isSent.toggle()
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                Spacer()
                Picker("Grade color", selection: $routeColour, content: {
                    ForEach(colours, id: \.self, content: { color in
                        Text(color)
                    })
                })
                .pickerStyle(.menu)
                Spacer()
                Button("Save") {
                    withAnimation {
                        let climb = Climb(context: moc)
                        climb.id = UUID()
                        climb.grade = Int16(grade)
                        climb.attempts = Int16(attempts)
                        climb.isSent = isSent
                        climb.routeColour = routeColour
                        climb.date = Date.now
                        climb.isKeyProject = climb.attempts > 5 && climb.isSent == false
                        climb.selectedColourIndex = Int16(selectedColourIndex)

                        if moc.hasChanges {
                          try? moc.save()
                        }
                    }
                    resetClimb()
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            .frame(alignment: .bottom)

        }
        .padding(.horizontal)
        .background(Color.gray.opacity(0.1))
    }
}

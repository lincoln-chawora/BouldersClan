//
//  ClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var climb: Climb
    @State private var climbNote = ""
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var addFromLibrary = true
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                VStack {
                    Text(climb.formattedGrade)
                        .padding(20)
                        .font(.largeTitle)
                        .foregroundColor(routeColour(climb.routeColour!, colorScheme))
                        .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour!, colorScheme), lineWidth: 3))
                }
                    
                Spacer()
                
                VStack(alignment: .leading) {
                    // @todo: Fix toggling issue
                    Button {
                        climb.isKeyProject.toggle()
                        climb.isKeyProject = climb.isKeyProject
                        if moc.hasChanges {
                            try? moc.save()
                        }
                    } label: {
                        Label("Project", systemImage: climb.isKeyProject ? "star.fill" : "star")
                            .font(.title2)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Text(climb.climbDate)
                    Text(climb.climbTime)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.vertical, 3)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Attemps")
                    if climb.attempts == 1 && climb.isSent {
                        Label("Flashed", systemImage: "bolt.fill")
                            .font(.title)
                            .foregroundColor(.yellow)
                    } else {
                        Text(climb.formattedAttempts(short: false))
                            .font(.title)
                    }
                    
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Status")
                    Text(climb.isSent ? "Sent" : "No send")
                        .font(.title)
                        .foregroundColor(climb.isSent ? .green : .red)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.vertical, 3)
            
            VStack (alignment: .leading) {
                TextField("Notes", text: $climbNote)
                    .foregroundColor(.secondary)
                
                // @todo: Fix data persistance issue here
                Button("Save note") {
                    climb.notes = climbNote
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
                .padding(.top)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical, 3)
                
                HStack {
                    
                    Button("Add picture from library") {
                        addFromLibrary = true
                        print("Library status from defa: \(addFromLibrary)")
                        showingImagePicker = true
                    }
                    .buttonStyle(.bordered)
                    
                    // FIX BUT WITH ADD FROM LIBRARY NOT CHANGING AND ALSO ONLY ALLOW THIS OPTION IF DEVICE HAS CAMERA.
                    Button("Take picture") {
                        addFromLibrary = false
                        print("Library status from take: \(addFromLibrary)")
                        showingImagePicker = true
                    }
                    .buttonStyle(.bordered)
                }

                image?
                    .resizable()
                    .scaledToFit()
    
            }
            .onChange(of: selectedImage) { _ in selectImage() }
            .onAppear(perform: getImage)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: addFromLibrary ? .photoLibrary : .camera, selectedImage: $selectedImage)
            }
        }
        .padding()
    }
    
    func getImage() {
        if climb.routeImage != nil {
            let uiImage = UIImage(data: climb.routeImage!)
            image = Image(uiImage: uiImage!)
        }
    }
    
    func selectImage() {
        guard let selectedImage = selectedImage else {
            return
        }
                
        image = Image(uiImage: selectedImage)
        
        let data = selectedImage.jpegData(compressionQuality: 1.0)
        
        if data != nil {
            climb.routeImage = data
            try? moc.save()
        }
    }
}

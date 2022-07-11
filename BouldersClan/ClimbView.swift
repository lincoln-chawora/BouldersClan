//
//  ClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbView: View {
    var grade: Int
    var isSent: Bool
    var attempts: Int
    var date: Date
    var selectedColour: String
    
    var body: some View {
        Form {
            VStack {
                HStack {
                    Text("V\(grade)")
                        .font(.largeTitle)
                        .foregroundColor(colorToShow(selectedColour))
                    Spacer()
                    Text("\(date.formatted(date: .omitted, time: .shortened))")
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Attemps")
                        Text(attempts == 1 && isSent ? "Flashed" : "\(attempts) attemps")
                            .font(.title2)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Completion")
                        Text(isSent ? "Sent" : "No send")
                            .font(.title2)
                    }
                }
                HStack {
                    VStack(alignment: .center) {
                        Text("Route")
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 300, height: 300)
                    }
                }
            }
        }
    }
}

struct ClimbView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbView(grade: 0, isSent: true, attempts: 1, date: Date.now, selectedColour: "White")
    }
}

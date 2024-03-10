//
//  MissionView.swift
//  Moonshot
//
//  Created by Margarita Mayer on 08/01/24.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.6
                        }
                    
                    Text(mission.formattedLaunchDate)
                    
                    Divider()
                        .padding(.vertical)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Mission highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Divider()
                        
                        Text("Crew")
                            .font(.title2)
                            .bold()
                        
//                        NavigationLink {
                        HStack{
                            ScrollView(.horizontal) {
                                
                                CrewView(mission: mission, astronauts: astronauts)
                            }
                        }
//                        } label: {
//                            Text("Crew")
//                                .font(.title.bold())
//                                .padding(.bottom, 5)
//                        }
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    
                    
                    //                ScrollView(.horizontal, showsIndicators: false) {
                    //                    HStack {
                    //                        ForEach(crew, id: \.role) { crewMember in
                    //                            NavigationLink {
                    //                                AstronautView(astronaut: crewMember.astronaut)
                    //                            } label: {
                    //                                HStack {
                    //                                    Image(crewMember.astronaut.id)
                    //                                        .resizable()
                    //                                        .frame(width: 104, height: 72)
                    //                                        .clipShape(.capsule)
                    //                                        .overlay(
                    //                                            Capsule()
                    //                                                .strokeBorder(.white, lineWidth: 1)
                    //                                        )
                    //
                    //                                    VStack(alignment: .leading) {
                    //                                        Text(crewMember.astronaut.name)
                    //                                            .foregroundStyle(.white)
                    //                                            .font(.headline)
                    //
                    //                                        Text(crewMember.role)
                    //                                            .foregroundStyle(.secondary)
                    //
                    //                                    }
                    //                                }
                    //                                .padding(.horizontal)
                    //                            }
                    //                        }
                    //                    }
                    //                }
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
       
    }
    
    init(mission: Mission, astronauts: [String: Astronaut] ) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
   return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

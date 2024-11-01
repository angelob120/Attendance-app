//
//  CohertModel.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/16/24.
//

import Foundation

struct Cohert: Identifiable {
    var id = UUID()
    var imageName: String
    var name: String
    static let all: [Cohert] = ["Wayne State Connect", "Art Club", "Wayne State Sports", "Wayne State Help", "Wayne State Track", "Wayne State Swim","Wayne State Football"]
            .map { Cohert(imageName: $0, name: $0) }
}


struct Learner:Hashable {
    
    var name:String
    var email: String
    var phoneNumber: String
    
    
    
    // Implement Equatable conformance
    static func == (lhs: Learner, rhs: Learner) -> Bool {
        return lhs.name == rhs.name
        && lhs.email == rhs.email
            && lhs.phoneNumber == rhs.phoneNumber
        
         
    }

    // Implement Hashable conformance
    func hash(into hasher: inout Hasher) {
     
        hasher.combine(name)
        hasher.combine(email)
        hasher.combine(phoneNumber)
 
    }
    
}


class clubManager:ObservableObject {
    
    @Published var coherts:[Cohert] = []
    @Published var leaners:[Learner] = []
//    @Published var createdClub:Club = Club(Image: "", name: "", DOE: Date(), clubID:Int.random(in: 1...1000))
    @Published var createdLearner: Learner = Learner(name: "", email: "", phoneNumber: "")

    
    
//    func addClub() {
//        clubs.append(createdClub)
//        createdClub = Club(Image: "", name: "", DOE: Date(), clubID: 0)
//    }
    
    
    func deleteClub() {
        
    }
    
    func addStudentToClub() {
        
        leaners.append(createdLearner)
        
        createdLearner = Learner(name: "", email: "", phoneNumber: "")
        
    }
    
    
    func deleteStudentFromClub() {}
    

}
                                           
             

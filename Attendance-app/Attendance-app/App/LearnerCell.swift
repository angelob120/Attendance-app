//
//  LearnerCell.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/24/24.
//

//import SwiftUI
//
//protocol StudentCellViewDelegate: AnyObject {
//    func didTapAdvisorButton(for student: User)
//}
//
//struct StudentCell: View {
//    @State private var isLoading: Bool = false
//    var student: User
//    weak var delegate: StudentCellViewDelegate?
//    
//    private var action: Action {
//        if let advisorId = student.advisorId {
//            return advisorId == UserCloudKit.shared.cachedUser!.id.recordName ? .transfer : .none
//        } else {
//            return .advise
//        }
//    }
//
//    enum Action {
//        case advise
//        case transfer
//        case none
//    }
//
//    var body: some View {
//        HStack {
//            studentPhotoView
//            VStack(alignment: .leading) {
//                Text(student.name)
//                    .font(.headline)
//                Text(timeOffStatusText)
//                    .font(.subheadline)
//                    .foregroundColor(timeOffStatusColor)
//            }
//            Spacer()
//            advisorButton
//        }
//        .padding()
//        .background(student.timeOffPercentage ?? 0.00000000001 > 0.0 ? Color.clear : Color.red)
//        .cornerRadius(10)
//        .onAppear {
//            loadPhoto()
//        }
//    }
//
//    private var studentPhotoView: some View {
//        ZStack {
//            Circle()
//                .fill(Color.gray.opacity(0.2))
//                .frame(width: 70, height: 70)
//            if isLoading {
//                ProgressView()
//            } else {
//                if let image = student.photo {
//                    Image(uiImage: image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .clipShape(Circle())
//                }
//            }
//        }
//    }
//
//    private var timeOffStatusText: String {
//        if let formattedPercentage = student.timeOffPercentage?.formattedPercent() {
//            return formattedPercentage
//        } else {
//            return "--"
//        }
//    }
//
//    private var timeOffStatusColor: Color {
//        Attendance.colorFrom(percentage: student.timeOffPercentage)
//    }
//
//    private var advisorButton: some View {
//        Button(action: {
//            delegate?.didTapAdvisorButton(for: student)
//        }) {
//            Text(buttonTitle)
//                .padding()
//                .background(buttonBackgroundColor)
//                .foregroundColor(buttonTextColor)
//                .cornerRadius(17.5)
//        }
//    }
//
//    private var buttonTitle: String {
//        switch action {
//        case .advise:
//            return LocalizedString("Orientar").resolve()
//        case .transfer:
//            return LocalizedString("Transferir").resolve()
//        case .none:
//            return student.advisorName?.split(separator: " ").first.map(String.init) ?? ""
//        }
//    }
//
//    private var buttonTextColor: Color {
//        switch action {
//        case .advise:
//            return .white
//        case .transfer:
//            return Color.tintColor
//        case .none:
//            return .label
//        }
//    }
//
//    private var buttonBackgroundColor: Color {
//        switch action {
//        case .advise:
//            return Color.tintColor
//        case .transfer, .none:
//            return Color.tertiarySystemGroupedBackground
//        }
//    }
//
//    private func loadPhoto() {
//        guard !isLoading else { return }
//        isLoading = true
//        UserPhotoLoader.shared.loadPhoto(for: student) { [weak self] image in
//            DispatchQueue.main.async {
//                self?.student.photo = image
//                self?.isLoading = false
//            }
//        }
//    }
//}


/// This code will be optimized and referenced in the future for the purpose of maintaining some of the coding structure within the application.

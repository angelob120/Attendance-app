//
//  TeacherViewController.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/11/24.
//


//import UIKit
//
//class MentorViewController: UIViewController, ActivityPresentable {
//    
//    // UI components
//    let tableView = UITableView(frame: .zero, style: .plain)
//    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
//    let messageLabel = UILabel()
//    let filterSegmentedControl = UISegmentedControl(items: [LocalizedString("Todos").resolve(), LocalizedString("Orientandos").resolve()])
//    let activityIndicator = UIActivityIndicatorView()
//    let refreshControl = UIRefreshControl()
//    let currentClassroomView = CurrentClassroomView()
//    
//    // Data providers
//    let studentsProvider = PaginatedCloudKitModelProvider<User, CloudKitUserAPI>()
//    let subscriptionService = SubscriptionService()
//    
//    // State variables
//    fileprivate var selectedClassroom: Classroom? {
//        didSet {
//            reloadData() // Reload data when selected classroom changes
//        }
//    }
//    
//    private var isLoadingData = false {
//        didSet {
//            messageLabel.isHidden = true
//            isLoadingData ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
//        }
//    }
//    
//    fileprivate var students = [User]()
//    fileprivate var filteredStudents = [User]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupNavigationBar()
//        setupViews()
//        setupConstraints()
//        
//        // Load current classroom and subscribe to changes
//        if let currentClassroom = Classroom.current {
//            currentClassroomView.setup(with: currentClassroom)
//            selectedClassroom = currentClassroom
//            subscriptionService.subscribeToClassroomSettingsChange(classroom: currentClassroom)
//            if let user = UserCloudKit.shared.cachedUser {
//                subscriptionService.subscribeToWarnings(for: user)
//            }
//        }
//        
//        // Register table view cells
//        tableView.register(StudentCell.self, forCellReuseIdentifier: "student-cell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        
//        // Setup filter action
//        filterSegmentedControl.addTarget(self, action: #selector(changeStudentsFilter), for: .valueChanged)
//        filterSegmentedControl.selectedSegmentIndex = 0
//        
//        // Setup notification observer for classroom changes
//        NotificationCenter.default.addObserver(self, selector: #selector(classroomDidChange(_:)), name: .ClassroomDidChange, object: nil)
//    }
//    
//    // MARK: - Setup Methods
//    
//    private func setupNavigationBar() {
//        navigationItem.title = LocalizedString("Estudantes").resolve()
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        
//        // Toolbar buttons
//        let classroomsButton = UIBarButtonItem(image: UIImage(named: "list"), style: .done, target: self, action: #selector(classrooms(sender:)))
//        let selectedClassroomButton = UIBarButtonItem(customView: currentClassroomView)
//        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let settingsButton = UIBarButtonItem(image: UIImage(named: "gear"), style: .done, target: self, action: #selector(settings(sender:)))
//        
//        toolbarItems = [classroomsButton, space, selectedClassroomButton, space, settingsButton]
//    }
//    
//    private func setupViews() {
//        view.backgroundColor = .systemGroupedBackground
//        
//        // Add subviews
//        view.addSubview(tableView)
//        view.addSubview(blurView)
//        view.addSubview(filterSegmentedControl)
//        view.addSubview(messageLabel)
//        view.addSubview(activityIndicator)
//        
//        // Configure message label
//        messageLabel.textColor = .secondaryLabel
//    }
//    
//    private func setupConstraints() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        filterSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        // TableView constraints
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        
//        // BlurView constraints
//        NSLayoutConstraint.activate([
//            blurView.topAnchor.constraint(equalTo: view.topAnchor),
//            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        
//        // FilterSegmentedControl constraints
//        NSLayoutConstraint.activate([
//            filterSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            filterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            filterSegmentedControl.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -16)
//        ])
//        
//        // MessageLabel constraints
//        NSLayoutConstraint.activate([
//            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        
//        // ActivityIndicator constraints
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    // MARK: - Data Loading and Refreshing
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.contentInset.top = navigationController!.navigationBar.frame.height + 16
//        tableView.contentInset.bottom = 8
//    }
//    
//    @objc private func refresh() {
//        reloadData()
//        refreshControl.endRefreshing()
//    }
//    
//    private func reloadData() {
//        students.removeAll()
//        filteredStudents.removeAll()
//        loadStudents()
//    }
//    
//    private func loadStudents() {
//        guard let classroom = selectedClassroom else { return }
//        
//        isLoadingData = true
//        
//        let sortDescriptions = [NSSortDescriptor(key: "name", ascending: true)]
//        studentsProvider.find(.students(onClassroom: classroom, advisedBy: nil), orderedBy: sortDescriptions) { (students, error) in
//            self.students = students
//            self.filteredStudents = self.filterSegmentedControl.selectedSegmentIndex == 0 ? students : self.filterByAdvisor()
//            self.tableView.reloadData()
//            
//            if self.students.isEmpty {
//                let emptyMessage = self.filterSegmentedControl.selectedSegmentIndex == 0 ? "Nenhum aluno cadastrado" : "Você não possui orientandos nesta turma"
//                self.showMessageLabel(with: LocalizedString(emptyMessage).resolve())
//            }
//            
//            self.isLoadingData = false
//        }
//    }
//    
//    @objc func changeStudentsFilter(_ sender: UISegmentedControl) {
//        filteredStudents = sender.selectedSegmentIndex == 0 ? students : filterByAdvisor()
//        updateNavigationTitleText()
//        tableView.reloadData()
//    }
//    
//    private func filterByAdvisor() -> [User] {
//        let advisorRecordName = UserCloudKit.shared.cachedUser?.record.recordID.recordName
//        return students.filter { $0.advisorId == advisorRecordName }
//    }
//    
//    private func updateNavigationTitleText() {
//        let numberOfStudentsPresent = students.filter { $0.isCurrentlyInTheSpace }.count
//        navigationItem.title = "\(numberOfStudentsPresent) out of \(filteredStudents.count) \(filterSegmentedControl.selectedSegmentIndex == 0 ? "Learners" : "Mentees") Present"
//    }
//    
//    private func showMessageLabel(with message: String) {
//        messageLabel.text = message
//        messageLabel.isHidden = false
//    }
//    
//    // MARK: - Notification Handling
//    
//    @objc private func classroomDidChange(_ notification: Notification) {
//        guard let info = notification.userInfo, let classroom = info["classroom"] as? Classroom else { return }
//        selectedClassroom = classroom
//        currentClassroomView.setup(with: classroom)
//    }
//    
//    // MARK: - Navigation
//    
//    @objc func classrooms(sender: Any?) {
//        let controller = SelectClassroomViewController()
//        present(UINavigationController(rootViewController: controller), animated: true)
//    }
//    
//    @objc func settings(sender: Any?) {
//        let controller = ClassroomSettingsFormViewController()
//        controller.classroom = selectedClassroom
//        present(UINavigationController(rootViewController: controller), animated: true)
//    }
//}
//
//// MARK: - Table View Data Source & Delegate
//
//extension MentorViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredStudents.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "student-cell", for: indexPath) as! StudentCell
//        cell.setup(with: filteredStudents[indexPath.row]) // Setup cell with student data
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let student = filteredStudents[indexPath.row]
//        let controller = UserProfileViewController(user: student)
//        navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension // Use automatic dimension for cell height
//    }
//}
//
// 


/// This code will be used for future reference and may be optimized for the attendance application.

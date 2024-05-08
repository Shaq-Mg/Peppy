//
//  LoginViewModel.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import PhotosUI

class LoginViewModel: ObservableObject {
    @Published var loginStatus = ""
    @Published var loginStatusMessage = ""
    @Published var isLoginMode = false
    @Published var errorMessage = ""
    @Published var showAlert: AppAlert? = nil
    @Published var isUserCurrentlyLoggedOut = true
    
    
    @Published var phone = ""
    @Published var username = ""
    @Published var photoURL = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            persistImageToStorage()
        }
    }
    
    @Published var chatUser: User?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut =
            FirebaseManager.shared.auth.currentUser?.uid == nil
            self.isLoginMode =
            FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func handleAction() {
        if isLoginMode {
            loginUser()
            print("Should log into Firebaae with existing credentials")
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: phone, password: password) {
            result, error in
            if let error = error {
                print("Failed to login user:", error)
                self.showAlert = AppAlert.invalidLogin
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
        }
    }
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: phone, password: password) {
            result, error in
            if let error = error {
                print("Failed to create user:", error)
                self.showAlert = AppAlert.createUser
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                return
            }
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            self.chatUser = .init(data: data)
        }
    }
    private func persistImageToStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData,metadata: nil) { metaData, error in
            if let error = error {
                self.loginStatusMessage = "Failed to push image to Storage: \(error)"
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(error)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                guard let url = url else { return }
                self.storeUserInformation(profileImageUrl: url)
                return
            }
        }
    }
    private func storeUserInformation(profileImageUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {  return }
        let userData = ["phone": self.phone, "uid": uid, "photoImageUrl": profileImageUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print(error)
                self.loginStatusMessage = "\(error)"
                return
            }
            print("Success")
        }
    }
}

import UIKit

class APIService {
    
    // MARK: - Base URL
    let base = "http://wiqaya.duckdns.org:3000"
    
    // MARK: - Errors
    let internetError = ErrorResponse(message: ["Internet error, please try again!"], statusCode: nil)
    let generalError  = ErrorResponse(message: ["Something went wrong please try again!"], statusCode: nil)
    
    // MARK: - Sign Up

    func signUpUser(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        phone: String,
        gender: String,
        dateOfBirth: String,
        role: String,
        completion: @escaping (Result<RegisterResponse, Error>) -> Void
    ) {
        
        guard let url = URL(string: "\(base)/auth/sign-up") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
            "phone": phone,
            "gender": gender,
            "dateOfBirth": dateOfBirth,
            "role": role
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            if let raw = String(data: data, encoding: .utf8) {
                print("📦 Response:", raw)
            }
            
            do {
                let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // MARK: - Sign Up Doctor
    func signUpDoctor(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        phone: String,
        gender: String,
        dateOfBirth: String,
        role: String,
        specialization: String,
        bio: String,
        practicalExperience: String,
        latitude: String,
        longitude: String,
        syndicateCard: UIImage,
        completion: @escaping (Result<RegisterResponse, Error>) -> Void
    ) {
        
        guard let url = URL(string: "\(base)/auth/sign-up") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        func appendField(_ name: String, _ value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        func appendImage(_ name: String, image: UIImage) {
            let filename = "\(UUID().uuidString).jpg"
            let data = image.jpegData(compressionQuality: 0.8)!
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(data)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Text fields
        appendField("firstName", firstName)
        appendField("lastName", lastName)
        appendField("email", email)
        appendField("password", password)
        appendField("phone", phone)
        appendField("gender", gender)
        appendField("dateOfBirth", dateOfBirth) // 1995-03-12
        appendField("role", role) // DOCTOR
        appendField("specialization", specialization)
        appendField("bio", bio)
        appendField("practicalExperience", practicalExperience)
        appendField("latitude", latitude)
        appendField("longitude", longitude)
        
        // Image
        appendImage("syndicateCard", image: syndicateCard)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            if let raw = String(data: data, encoding: .utf8) {
                print("📦 Response:", raw)
            }
            
            do {
                let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }

    // MARK: - Login
    func loginUser(
        email: String,
        password: String,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "\(base)/auth/local-login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(self.generalError))
                return
            }
            
            if let json = String(data: data, encoding: .utf8) {
                print("📩 Login Raw Response:\n\(json)")
            }
            
            do {
                let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Request Password Reset
    func requestPasswordReset(
        email: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard let url = URL(string: "\(base)/auth/request-password-reset") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            if let json = String(data: data, encoding: .utf8) {
                print("📩 Reset Request Response:\n\(json)")
            }
            
            let message = (try? JSONDecoder().decode(MessageResponse.self, from: data))?.message
            completion(.success(message ?? "Reset code sent successfully"))
        }.resume()
    }
    
    // MARK: - Verify Reset Code
    func verifyResetCode(
        email: String,
        code: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard let url = URL(string: "\(base)/auth/verify-password-reset-otp") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "otp": code]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            if let json = String(data: data, encoding: .utf8) {
                print("📩 Verify Code Response:\n\(json)")
            }
            
            let message = (try? JSONDecoder().decode(MessageResponse.self, from: data))?.message
            completion(.success(message ?? "Code verified"))
        }.resume()
    }
    
    // MARK: - Reset Password
    func resetPassword(
        email: String,
        otp: String,
        newPassword: String,
        completion: @escaping (Result<String, ErrorResponse>) -> Void
    ) {
        guard let url = URL(string: "\(base)/auth/reset-password") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "otp": otp,
            "newPassword": newPassword
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                completion(.failure(self.internetError))
                return
            }
            
            guard let data = data else { return }
            
            if let json = String(data: data, encoding: .utf8) {
                print("📩 Reset Password Response:\n\(json)")
            }
            
            if let msg = try? JSONDecoder().decode(MessageResponse.self, from: data) {
                completion(.success(msg.message))
            } else if let err = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                completion(.failure(err))
            } else {
                completion(.failure(self.generalError))
            }
        }.resume()
    }
}

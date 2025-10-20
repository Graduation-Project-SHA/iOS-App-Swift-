import UIKit

class APIService {
    
    // MARK: - Sign Up
    func signUpUser(
        email: String,
        password: String,
        name: String,
        dob: String,
        gender: String,
        address: String,
        role: String,
        completion: @escaping (Result<RegisterResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "https://wekaya.onrender.com/auth/sign-up") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "email": email,
            "password": password,
            "name": name,
            "dob": dob,
            "gender": gender,
            "address": address,
            "role": role
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // ✅ طباعة الرد الكامل من السيرفر
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Raw Response:\n\(jsonString)")
            }
            
            do {
                let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                // ✅ محاولة قراءة رسالة الخطأ من السيرفر
                if let serverError = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = serverError["message"] {
                    let errorMsg = "Server error: \(message)"
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMsg])))
                } else {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    // MARK: - Login
    func loginUser(
        email: String,
        password: String,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    ) {
        guard let url = URL(string: "https://wekaya.onrender.com/auth/local-login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func requestPasswordReset(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://wekaya.onrender.com/auth/request-password-reset") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Raw Response (Request Reset):\n\(jsonString)")
            }
            
            // ممكن السيرفر يرجع مجرد رسالة تأكيد، فنرجعها كـ String
            if let message = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let msg = message["message"] as? String {
                completion(.success(msg))
            } else {
                completion(.success("Password reset request sent successfully."))
            }
        }.resume()
    }
    
    
    // MARK: - Verify Reset Code
    func verifyResetCode(email: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://wekaya.onrender.com/auth/verify-reset-code") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "code": code]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Raw Response (Verify Code):\n\(jsonString)")
            }
            
            if let message = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let msg = message["message"] as? String {
                completion(.success(msg))
            } else {
                completion(.success("Verification successful."))
            }
        }.resume()
    }
    
    
    // MARK: - Reset Password
    func resetPassword(resetToken: String, newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://wekaya.onrender.com/auth/reset-password") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "resetToken": resetToken,
            "password": newPassword
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Raw Response (Reset Password):\n\(jsonString)")
            }
            
            if let message = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let msg = message["message"] as? String {
                completion(.success(msg))
            } else {
                completion(.success("Password reset successfully."))
            }
        }.resume()
    }
}

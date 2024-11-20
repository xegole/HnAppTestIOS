import Foundation

class ApiServices {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw ServiceError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw ServiceError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw ServiceError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw ServiceError.failedToDecodeResponse }
            
            return decodedResponse
        } catch ServiceError.badUrl {
            print("There was an error creating the URL")
        } catch ServiceError.badResponse {
            print("Did not get a valid response")
        } catch ServiceError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch ServiceError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
}

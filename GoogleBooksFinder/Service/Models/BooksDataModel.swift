
import Foundation

// Create Decodable model to decode JSON
// Based on
// https://developers.google.com/books/docs/v1/using#WorkingVolumes
// https://developers.google.com/books/docs/v1/reference/volumes#resource

struct BooksData: Decodable {
  let items: [Items]
}

struct Items: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let authors: [String]?
    let pageCount: Int?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Decodable {
    let small: String
}

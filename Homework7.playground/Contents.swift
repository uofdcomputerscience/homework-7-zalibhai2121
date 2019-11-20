import Foundation

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.
struct Book : Codable{
    let id: Int?
    let title: String
    let author: String
    let published: String
    let imageURLString: String
}
// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.
var Books: [Book] = []
let HarryPotter = Book(id: nil, title: "Harry Potter and The Sorcerers Stone", author: "J.K.Rolling", published: "2001", imageURLString: "https://media.moddb.com/images/downloads/1/112/111205/back2_eng.jpg")
let TheGiver = Book(id: nil, title: "The Giver", author: "Lowis Lowry", published: "1993", imageURLString: "https://images-na.ssl-images-amazon.com/images/I/51fRar1PvAL._SX300_BO1,204,203,200_.jpg" )
let MockingBird = Book(id: nil, title: "To Kill a MockingBird", author: "Harper Lee", published: "2006", imageURLString:  "https://upload.wikimedia.org/wikipedia/commons/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg")
let Narnia = Book(id: nil,title: "The Chronicles of Narnia", author: "C.S. Lewis", published: "2002", imageURLString: "https://cex-thechristianpost.netdna-ssl.com/full/5859/630-0/chronicles-of-narnia.jpg")
let Tree = Book(id: nil, title: "The Giving Tree", author: "Shel Silverstein", published: "1964", imageURLString: "https://images-na.ssl-images-amazon.com/images/I/41ak9Ds2dWL._SX398_BO1,204,203,200_.jpg")

Books.append(HarryPotter)
Books.append(TheGiver)
Books.append(MockingBird)
Books.append(Narnia)
Books.append(Tree)
// MARK: - STEP THREE"

// Now we need to publish this data to the server.

// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books
let urlString = "https://uofd-tldrserver-develop.vapor.cloud/books"
// Create a URL request to publish the information, based upon the URL you
// just created.
let url = URL(string: urlString)!
// Add the body to the URL request you just created, by using JSONEncoder.
for _ in Books {
    var request = URLRequest(url: url)
    request.httpBody = try? JSONEncoder().encode(Books)
// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.
    request.httpMethod = "POST"
// Create a data task for publishing this element, and kick it off with a resume().
    let task = URLSession(configuration: .ephemeral).dataTask(with: request)
    task.resume()
}
// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.

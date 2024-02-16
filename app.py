from flask import Flask, jsonify, request
# from models import db, Author, Book, Publisher, User, UserCreditCards, ShoppingCart, CartItems, BookRatings, BookComments, WishLists, WishListItems
from extensions import db
from config import Config

app = Flask(__name__)

app.config.from_object(Config)
db.init_app(app)

with app.app_context():
    from models import Author, Book, Publisher, User, UserCreditCards, ShoppingCart, CartItems, BookRatings, BookComments, WishLists, WishListItems
    db.create_all()


@app.route('/')
def home():
    return 'Connected to the bookstore Library database!'

# Create a new author
@app.route('/authors', methods=['POST'])
def add_author():
    data = request.json
    author = Author(FirstName=data['FirstName'], LastName=data['LastName'], Biography=data['Biography'])
    db.session.add(author)
    db.session.commit()
    return jsonify({'message': 'Author created successfully'}), 201

# Get all authors
@app.route('/authors', methods=['GET'])
def get_authors():
    authors = Author.query.all()
    return jsonify([author.to_dict() for author in authors]), 200

# Get a single author by ID
@app.route('/authors/<int:author_id>', methods=['GET'])
def get_author(author_id):
    author = Author.query.get_or_404(author_id)
    return jsonify(author.to_dict()), 200

# Update an author
@app.route('/authors/<int:author_id>', methods=['PUT'])
def update_author(author_id):
    data = request.json
    author = Author.query.get_or_404(author_id)
    author.FirstName = data.get('FirstName', author.FirstName)
    author.LastName = data.get('LastName', author.LastName)
    author.Biography = data.get('Biography', author.Biography)
    db.session.commit()
    return jsonify({'message': 'Author updated successfully'}), 200

# Delete an author
@app.route('/authors/<int:author_id>', methods=['DELETE'])
def delete_author(author_id):
    author = Author.query.get_or_404(author_id)
    db.session.delete(author)
    db.session.commit()
    return jsonify({'message': 'Author deleted successfully'}), 200

@app.route('/book', methods=['GET', 'POST'])
def add_book():
    if request.method == 'POST':
        data = request.json
        new_book = Book(
            ISBN=data['ISBN'],
            Name=data['Name'],
            Description=data.get('Description', ''),
            Price=data['Price'],
            AuthorID=data['AuthorID'],
            Genre=data.get('Genre', ''),
            PublisherID=data['PublisherID'],
            YearPublished=data.get('YearPublished', None),
            CopiesSold=data.get('CopiesSold', 0)
        )
        db.session.add(new_book)
        db.session.commit()
        return jsonify(new_book), 201
    elif request.method == 'GET':
        books = Book.query.all()
    return jsonify([book.to_dict() for book in books])

@app.route('/books/<int:book_id>', methods=['GET'])
def get_book(book_id):
    book = Book.query.get_or_404(book_id)
    return jsonify(book.to_dict())

@app.route('/books/<int:book_id>', methods=['PUT'])
def update_book(book_id):
    book = Book.query.get_or_404(book_id)
    data = request.json
    book.ISBN = data.get('ISBN', book.ISBN)
    book.Name = data.get('Name', book.Name)
    book.Description = data.get('Description', book.Description)
    book.Price = data.get('Price', book.Price)
    book.AuthorID = data.get('AuthorID', book.AuthorID)
    book.Genre = data.get('Genre', book.Genre)
    book.PublisherID = data.get('PublisherID', book.PublisherID)
    book.YearPublished = data.get('YearPublished', book.YearPublished)
    book.CopiesSold = data.get('CopiesSold', book.CopiesSold)
    db.session.commit()
    return jsonify(book.to_dict())

@app.route('/books/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    book = Book.query.get_or_404(book_id)
    db.session.delete(book)
    db.session.commit()
    return jsonify({'message': 'Book deleted successfully'}), 200


def to_dict(self):
    return {
        'BookID': self.BookID,
        'ISBN': self.ISBN,
        'Name': self.Name,
        'Description': self.Description,
        'Price': self.Price,
        'AuthorID': self.AuthorID,
        'Genre': self.Genre,
        'PublisherID': self.PublisherID,
        'YearPublished': self.YearPublished,
        'CopiesSold': self.CopiesSold
    }

Book.to_dict = to_dict

@app.route('/publishers', methods=['POST'])
def create_publisher():
    data = request.json
    new_publisher = Publisher(
        Name=data['Name'],
        Address=data.get('Address', ''),
        Phone=data.get('Phone', '')
    )
    db.session.add(new_publisher)
    db.session.commit()
    return jsonify(new_publisher.to_dict()), 201

@app.route('/publishers', methods=['GET'])
def get_publishers():
    publishers = Publisher.query.all()
    return jsonify([publisher.to_dict() for publisher in publishers])

@app.route('/publishers/<int:publisher_id>', methods=['GET'])
def get_publisher(publisher_id):
    publisher = Publisher.query.get_or_404(publisher_id)
    return jsonify(publisher.to_dict())

@app.route('/publishers/<int:publisher_id>', methods=['PUT'])
def update_publisher(publisher_id):
    publisher = Publisher.query.get_or_404(publisher_id)
    data = request.json
    publisher.Name = data.get('Name', publisher.Name)
    publisher.Address = data.get('Address', publisher.Address)
    publisher.Phone = data.get('Phone', publisher.Phone)
    db.session.commit()
    return jsonify(publisher.to_dict())

@app.route('/publishers/<int:publisher_id>', methods=['DELETE'])
def delete_publisher(publisher_id):
    publisher = Publisher.query.get_or_404(publisher_id)
    db.session.delete(publisher)
    db.session.commit()
    return jsonify({'message': 'Publisher deleted successfully'}), 200

def to_dict(self):
    return {
        'PublisherID': self.PublisherID,
        'Name': self.Name,
        'Address': self.Address,
        'Phone': self.Phone
    }

Publisher.to_dict = to_dict



if __name__ == '__main__':
    app.run(debug=True, port=3600)

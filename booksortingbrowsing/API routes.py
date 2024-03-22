from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.sql import func


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:1325@localhost:3306/bookstore'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Define the base for automap
Base = automap_base()

# Use application context for preparing the Base
with app.app_context():
    # Reflect the tables
    Base.prepare(autoload_with=db.engine)

# Define mapped classes
Authors = Base.classes.authors
Books = Base.classes.books  
Publishers = Base.classes.publishers  
BookRatings = Base.classes.bookratings

#Home Route
@app.route('/')
def welcome():
    return "Welcome to the Bookstore API! Access /books to see the list of books."

# Route to get all books
@app.route('/books', methods=['GET'])
def get_books():
    # Query the Books table for all books
    books_query = db.session.query(Books).all()

    # Convert query results to a list of dictionaries
    books_list = [
        {
            'BookID': book.BookID,
            'ISBN': book.ISBN,
            'Name': book.Name,
            'Description': book.Description,
            'Price': str(book.Price),  # Convert decimal to string for JSON serialization
            'Genre': book.Genre,
            'AuthorID': book.AuthorID,
            'PublisherID': book.PublisherID,
            'YearPublished': book.YearPublished,
            'CopiesSold': book.CopiesSold
        } for book in books_query
    ]
    
    # Return the results as JSON
    return jsonify(books_list)

@app.route('/publishers', methods=['GET'])
def get_publishers():
        
        # Query the database for all publishers
        publishers_query = db.session.query(Publishers.PublisherID, Publishers.Name).all()

        # Convert the query results to a list of dictionaries
        publishers_list = [
            {"PublisherID": publisher.PublisherID, "Name": publisher.Name}
            for publisher in publishers_query
        ]
        
        # Return the results as JSON
        return jsonify(publishers_list), 200


# Route to get books by genre
@app.route('/books/genre', methods=['GET'])
def get_books_by_genre():
    # Get the genre from query parameter
    genre = request.args.get('genre')
    
    # Validate if genre parameter is provided
    if not genre:
        return jsonify({"error": "Missing genre parameter"}), 400

    # Query the Books table for books in the given genre
    books_query = db.session.query(Books).filter(Books.Genre == genre).all()
    
    # If no books found for the genre, return an empty list with a not found message
    if not books_query:
        return jsonify({"error": f"No books found for genre '{genre}'"}), 404

    # Convert query results to a list of dictionaries for JSON response
    books_list = [
        {
            'BookID': book.BookID, 
            'ISBN': book.ISBN, 
            'Name': book.Name, 
            'Description': book.Description, 
            'Price': str(book.Price), 
            'Genre': book.Genre, 
            'AuthorID': book.AuthorID, 
            'PublisherID': book.PublisherID, 
            'YearPublished': book.YearPublished, 
            'CopiesSold': book.CopiesSold
        } for book in books_query
    ]
    
    # Return the results as JSON
    return jsonify(books_list)

# Route to get top 10 best-selling books
@app.route('/books/top-sellers', methods=['GET'])
def get_top_sellers():
    # Query the Books table to find the top 10 best-selling books
    top_sellers_query = db.session.query(Books).order_by(Books.CopiesSold.desc()).limit(10).all()

    # Convert query results to a list of dictionaries
    top_sellers_list = [
        {
            'BookID': book.BookID,
            'ISBN': book.ISBN,
            'Name': book.Name,
            'Description': book.Description,
            'Price': str(book.Price),  
            'Genre': book.Genre,
            'AuthorID': book.AuthorID,
            'PublisherID': book.PublisherID,
            'YearPublished': book.YearPublished,
            'CopiesSold': book.CopiesSold
        } for book in top_sellers_query
    ]
    
    # Return the results as JSON
    return jsonify(top_sellers_list)


@app.route('/books/rating', methods=['GET'])
def get_books_by_average_rating():
    # Get the rating from query parameter
    rating = request.args.get('rating', type=float)
    
    # Validate if rating parameter is provided and valid
    if rating is None:
        return jsonify({"error": "Missing or invalid rating parameter"}), 400

    # Query to find books with the average rating or higher
    books_query = db.session.query(Books, func.avg(BookRatings.Rating).label('average_rating'))\
                            .join(BookRatings, Books.BookID == BookRatings.BookID)\
                            .group_by(Books.BookID)\
                            .having(func.avg(BookRatings.Rating) >= rating)\
                            .all()

    # Check if any books are found
    if not books_query:
        return jsonify({"message": f"No books found with an average rating of {rating} or higher"}), 404

    # Convert query results to a list of dictionaries
    books_list = [
        {
            'BookID': book.BookID,
            'ISBN': book.ISBN,
            'Name': book.Name,
            'Description': book.Description,
            'Price': str(book.Price),
            'Genre': book.Genre,
            'AuthorID': book.AuthorID,
            'PublisherID': book.PublisherID,
            'YearPublished': book.YearPublished,
            'CopiesSold': book.CopiesSold,
            'AverageRating': str(average_rating)  
        } for book, average_rating in books_query
    ]
    
    # Return the results as JSON
    return jsonify(books_list)



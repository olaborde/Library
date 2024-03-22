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
    @app.route('/books/discount', methods=['PATCH'])
def discount_books_by_publisher():
    # Attempt to parse the JSON data from the request body
    data = request.get_json()

    # Validate that JSON data is present
    if not data:
        return jsonify({"error": "Invalid or missing JSON body"}), 400

    # Extract discount_percent and publisher from the parsed JSON data
    discount_percent = data.get('discount_percent')
    publisher = data.get('publisher')

    # Further validation for discount_percent and publisher
    if discount_percent is None or publisher is None:
        return jsonify({"error": "Missing discount percent or publisher"}), 400

    try:
        # Ensure discount_percent is a float
        discount_percent = float(discount_percent)
        if discount_percent <= 0 or discount_percent >= 100:
            return jsonify({"error": "Discount percent must be between 0 and 100"}), 400
    except ValueError:
        return jsonify({"error": "Invalid discount percent"}), 400

    # Calculate the discount multiplier
    discount_multiplier = (100 - discount_percent) / 100

    # Use a subquery to select the PublisherID for the given publisher name
    publisher_subquery = db.session.query(Publishers.PublisherID)\
        .filter(Publishers.Name == publisher)\
        .subquery()

    # Update the price of all books under the specified publisher using the subquery
    try:
        affected_rows = db.session.query(Books)\
            .filter(Books.PublisherID.in_(publisher_subquery))\
            .update({"Price": Books.Price * discount_multiplier}, synchronize_session=False)
        db.session.commit()

        if affected_rows == 0:
            return jsonify({"message": f"No books found for publisher '{publisher}' or no prices were updated"}), 404

        return jsonify({"message": f"Updated prices for books published by '{publisher}' with a {discount_percent}% discount"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"error": "Failed to update book prices", "details": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)



from flask import Flask, jsonify
import mysql.connector
from dotenv import load_dotenv
import os

load_dotenv()

#Load database information from .env file
database_username = os.getenv('DATABASE_USERNAME')
database_password = os.getenv('DATABASE_PASSWORD')
database_host = os.getenv('DATABASE_HOST')
database_port = os.getenv('DATABASE_PORT')
database_name = os.getenv('DATABASE_NAME')

# Initialize Flask application
app = Flask(__name__)

# Database configuration
config = {
  'user': database_username,
  'password': database_password,
  'host': database_host,
  'port': database_port,
  'database': database_name,
  'raise_on_warnings': True
}

# Route to get all books
@app.route('/books', methods=['GET'])
def get_books():
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Books") # Execute query to get all books
    books = cursor.fetchall() # Fetch all books from the query result
    cursor.close()
    conn.close()
    return jsonify(books) # Return books as JSON

# Route to get a specific book by ID
@app.route('/books/<int:book_id>', methods=['GET'])
def get_book_by_id(book_id):
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Books WHERE BookID = %s", (book_id,))  # Query to get book by ID
    book = cursor.fetchone() # Fetch single book matching the ID
    cursor.close()
    conn.close()
    if book:
        return jsonify(book)
    else:
        return jsonify({"message": "Book not found"}), 404

# Route to get all isbns
@app.route('/isbn/', methods=['GET'])
def get_all_isbn():
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT ISBN FROM Books") # Query to get all ISBN numbers
    books = cursor.fetchall() # Extract ISBNs from the result rows
    cursor.close()
    conn.close()
    return jsonify(books) # Return ISBN numbers as JSON

# Route to get a book by ISBN
@app.route('/books/isbn/<isbn>', methods=['GET']) #defines the API endpoint or the URL
def get_book_by_isbn(isbn):
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    print(f'ISBN reeived: {isbn}')
    cursor.execute("SELECT * FROM Books WHERE ISBN = %s", (isbn,))
    book = cursor.fetchall()
    cursor.close()
    conn.close()
    if book:
        return jsonify(book)
    else:
        return jsonify({"message": "Book not found"}), 404

# Route to get all authors
@app.route('/authors', methods=['GET'])
def get_all_authors():
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Authors") # Query to get all authors
    books = cursor.fetchall() # Fetch all authors from the query result
    cursor.close()
    conn.close()
    return jsonify(books) # Return authors as JSON

# Route to get all books by a specific author
@app.route('/authors/<int:author_id>/books', methods=['GET'])
def get_books_by_author(author_id):
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT b.*, Concat(a.FirstName, " ", a.LastName) AS fullName FROM Books b
        INNER JOIN Authors a ON b.AuthorID = a.AuthorID
        WHERE a.AuthorID = %s
    """, (author_id,))
    books = cursor.fetchall()
    cursor.close()
    conn.close()
    if books:
        return jsonify(books)
    else:
        return jsonify({"message": "No books found for the given author"}), 404
      
# Route to Create Author
@app.route('/create_author', methods=['POST'])
def create_author():
    data = request.json
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()
    query = """
    INSERT INTO Authors (FirstName, LastName, Biography)
    VALUES (%s, %s, %s)
    """
    cursor.execute(query, (data['FirstName'], data['LastName'], data['Biography']))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Author created successfully"}), 201

#Route To Create Book

# Route to Create Book
@app.route('/create_book', methods=['POST'])
def create_book():
    data = request.json
    conn = mysql.connector.connect(**config)

    cursor = conn.cursor()
    query = """
        INSERT INTO books (ISBN, Name, Description, Price, Genre, AuthorID, PublisherID, YearPublished, CopiesSold)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
    cursor.execute(query, (
            data['ISBN'], data['Name'], data['Description'], data['Price'], data['Genre'],
            data['AuthorID'], data['PublisherID'], data['YearPublished'], data['CopiesSold']
        ))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Book added successfully!"}), 201

# Run the Flask application
if __name__ == '__main__':
    app.run(debug=True) # Start the Flask application in debug mode

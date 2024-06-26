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

# Route To Get All Books
@app.route('/books', methods=['GET'])
def get_books():
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Books") # Execute query to get all books
    books = cursor.fetchall() # Fetch all books from the query result
    cursor.close()
    conn.close()
    return jsonify(books) # Return books as JSON

# Route To Get A Specific Book By ID
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

# Route To Get A Specific Book By ISBN
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

# Route To Get All Books By A Specific Author
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

# Route To Create Author
@app.route('/create_author', methods=['POST'])
def create_author():
    data = request.json
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()

    # Insert Into Authors Table
    query_authors = """
    INSERT INTO Authors (FirstName, LastName, Biography)
    VALUES (%s, %s, %s)
    """
    cursor.execute(query_authors, (data['FirstName'], data['LastName'], data['Biography']))
    conn.commit()

    # Retrieve The Last Inserted ID
    author_id = cursor.lastrowid

    query_author_publisher = """
    INSERT INTO AuthorPublisher (AuthorID, PublisherID)
    VALUES (%s, %s)
    """
    cursor.execute(query_author_publisher, (author_id, data['PublisherID']))
    conn.commit()

    # Clean Up The Cursor And Connection
    cursor.close()
    conn.close()

    return jsonify({"message": "Author and author-publisher link created successfully"}), 201

# Route To Look Up Author By Last Name
@app.route('/authors/<last_name>', methods=['GET'])
def get_author_by_last_name(last_name):
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)
    query = """
    SELECT a.authorID, a.firstname, a.lastname, a.biography, ap.publisherID
    FROM Authors a
    LEFT JOIN authorpublisher ap ON a.authorID = ap.authorID
    WHERE a.lastname = %s
    """
    cursor.execute(query, (last_name,))
    author_details = cursor.fetchall()
    cursor.close()
    conn.close()
    if author_details:
        return jsonify(author_details)
    else:
        return jsonify({"error": "Author not found"}), 404

# Route To Create Book
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

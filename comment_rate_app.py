from flask import Flask, jsonify, request
import mysql.connector
from datetime import datetime

app = Flask(__name__)
config = {
    'user': 'root',
    'password': 'Group5$)+',
    'host': 'localhost',
    'port': '3306',
    'database': 'bookstore',
    'raise_on_warnings': True
}

@app.route('/', methods=['GET'])
def welcome_page():
    return jsonify({"message": "Welcome"}), 201

# Route to create a rating for a book by a user
@app.route('/ratings/create', methods=['POST'])
def create_book_rating():
    # Extract data from the request
    data = request.get_json()

    # Check if all required parameters are present
    if 'book_id' not in data or 'user_id' not in data or 'rating' not in data:
        error = [
            {
                '400 error': 'missing parameters; usage is as follows:',
                'book_id': 'INT',
                'user_id': u'INT',
                'rating': u'INT',
            }
        ]
        return jsonify(error), 400

    book_id = data['book_id']
    user_id = data['user_id']
    rating = data['rating']

    # Database connection and cursor
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)

    try:
        # Prepare the query to insert a new rating
        query = """
            INSERT INTO BookRatings (BookID, UserID, Rating, DateStamp)
            VALUES (%s, %s, %s, %s)
        """
        # Get the current timestamp
        date_stamp = datetime.now()

        # Execute the query
        cursor.execute(query, (book_id, user_id, rating, date_stamp))

        # Commit the changes to the database
        conn.commit()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return jsonify({"message": "Rating created successfully"}), 201

    except Exception as e:
        # Handle exceptions (e.g., database errors)
        return jsonify({"error": str(e)}), 500

# Route to retrieve a list of comments for a particular book
@app.route('/ratings/<int:book_id>', methods=['GET'])
def get_ratings(book_id):
    # Database connection and cursor
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)

    try:
        # Check if BookID is not provided
        if book_id is None:
            raise ValueError("BookID not provided")

        # Query to retrieve comments for the specified book
        query = """
            SELECT RatingID,BookID,UserID,Rating,DateStamp
            FROM BookRatings
            WHERE BookID = %s
        """

        # Execute the query
        cursor.execute(query, (book_id,))

        # Fetch all comments for the book
        ratings = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # Check if comments were found
        if not ratings:
            return jsonify({"message": "Invalid BookID"}), 404

        return jsonify(ratings)

    except Exception as e:
        # Handle exceptions (e.g., database errors)
        return jsonify({"error": str(e)}), 500

# Route to retrieve the average for a specific book
@app.route('/ratings/averagerating/<int:book_id>', methods=['GET'])
def book_average_rating(book_id):
    # Database connection and cursor
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)

    try:
        # Query to retrieve all comments with BookID and comment information
        query = """
            SELECT AVG(rating) AS average_rating
            FROM BookRatings
            WHERE BookID = %s
        """

        cursor.execute(query, (book_id,))
        average_rating = cursor.fetchone()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        if average_rating['average_rating'] is not None:
            return jsonify(average_rating)
        else:
            return jsonify({"message": "No ratings found for the book."}), 404

    except Exception as e:
        # Handle exceptions (e.g., database errors)
        return jsonify({"error": str(e)}), 500

# Route to retrieve all comments with BookID and comment information
@app.route('/comments/all', methods=['GET'])
def get_comments_all():
    # Database connection and cursor
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)

    try:
        # Query to retrieve all comments with BookID and comment information
        query = """
            SELECT BookID, CommentID, UserID, Comments, DateStamp
            FROM BookComments
        """

        cursor.execute(query)
        all_comments = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        return jsonify(all_comments)

    except Exception as e:
        # Handle exceptions (e.g., database errors)
        return jsonify({"error": str(e)}), 500

# Route to retrieve a list of comments for a particular book
@app.route('/comments/<int:book_id>', methods=['GET'])
def get_comments(book_id):
    # Database connection and cursor
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor(dictionary=True)

    try:
        # Check if BookID is not provided
        if book_id is None:
            raise ValueError("BookID not provided")

        # Query to retrieve comments for the specified book
        query = """
            SELECT BookID, CommentID, UserID, Comments, DateStamp
            FROM BookComments
            WHERE BookID = %s
        """

        # Execute the query
        cursor.execute(query, (book_id,))

        # Fetch all comments for the book
        comments = cursor.fetchall()

        # Close the cursor and connection
        cursor.close()
        conn.close()

        # Check if comments were found
        if not comments:
            return jsonify({"message": "Invalid BookID"}), 404

        return jsonify(comments)

    except Exception as e:
        # Handle exceptions (e.g., database errors)
        return jsonify({"error": str(e)}), 500

# Run the Flask application
if __name__ == '__main__':
    app.run(debug=True)
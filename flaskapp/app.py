from flask import Flask, request, jsonify
from flask_mysqldb import MySQL

app = Flask(__name__)

# MySQL configuration
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'bookstore'

mysql = MySQL(app)


# Route to get the subtotal of books in the user's shopping cart
@app.route('/api/shopping-cart/subtotal', methods=['GET'])
def get_subtotal():
    try:
        # Get user ID from the request parameters
        user_id_str = request.args.get('userId')

        # Check if user_id_str is not None
        if user_id_str is not None:
           user_id = int(user_id_str)
        else:
            return jsonify({"error": "User ID is missing"}), 400
    except ValueError:
        return jsonify({"error": "Invalid User ID"}), 400
    except OverflowError:
        return jsonify({"error": "User ID is too large"}), 400

    # Query to calculate the subtotal of books in the user's shopping cart
    query = """
        SELECT
            users.UserID,
            SUM(books.Price * cartitems.Quantity) AS Subtotal
        FROM
            users
            JOIN shoppingcart ON users.UserID = shoppingcart.UserID
            JOIN cartitems ON shoppingcart.CartID = cartitems.CartID
            JOIN books ON cartitems.BookID = books.BookID
        WHERE
            users.UserID = %s
        GROUP BY
            users.UserID
    """

    try:

        # Execute the query
        with mysql.connection.cursor() as cursor:
            cursor.execute(query, (user_id,))
            result = cursor.fetchone()

        if result:
            # Return the response with the calculated subtotal
            return jsonify({"userId": result[0], "subtotal": float(result[1])})
        else:
            return jsonify({"error": "User not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500



# Route to add a book to the user's shopping cart
@app.route('/api/shopping-cart/add-book', methods=['POST'])
def add_book_to_cart():
    try:
        # Get user ID and book ID from the request JSON data
        user_id = request.json.get('userId')
        book_id = request.json.get('bookId')

        # Check if user ID and book ID are provided
        if user_id is None or book_id is None:
            return jsonify({"error": "User ID or Book ID is missing"}), 400

        # Check if a shopping cart exists for the user
        cart_id = get_cart_id(user_id)

        # If a shopping cart doesn't exist, create one
        if cart_id is None:
            cart_id = create_shopping_cart(user_id)

        # Add the book to the shopping cart
        add_book_to_cart_items(cart_id, book_id)

        # Fetch the name of the book from the books table
        book_name = get_book_name(book_id)

        return jsonify({"success": f"Added '{book_name}' to the cart"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

def get_cart_id(user_id):
    """Retrieve the CartID for the given user ID."""
    query = "SELECT CartID FROM shoppingcart WHERE UserID = %s"
    with mysql.connection.cursor() as cursor:
        cursor.execute(query, (user_id,))
        result = cursor.fetchone()
        return result[0] if result else None

def create_shopping_cart(user_id):
    """Create a shopping cart for the given user ID and return the CartID."""
    query = "INSERT INTO shoppingcart (UserID) VALUES (%s)"
    with mysql.connection.cursor() as cursor:
        cursor.execute(query, (user_id,))
        mysql.connection.commit()
        return cursor.lastrowid

def add_book_to_cart_items(cart_id, book_id):
    """Add the given book to the cart items."""
    query = "INSERT INTO cartitems (CartID, BookID, Quantity) VALUES (%s, %s, 1)"
    with mysql.connection.cursor() as cursor:
        cursor.execute(query, (cart_id, book_id))
        mysql.connection.commit()

def get_book_name(book_id):
    """Retrieve the name of the book from the books table."""
    query = "SELECT Name FROM books WHERE BookID = %s"
    with mysql.connection.cursor() as cursor:
        cursor.execute(query, (book_id,))
        result = cursor.fetchone()
        return result[0] if result else None

if __name__ == '__main__':
    app.run(debug=True)

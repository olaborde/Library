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

    #finally:
      #  cursor.close()

if __name__ == '__main__':
    app.run(debug=True)

from flask import Flask, request, jsonify
from flask_mysqldb import MySQL

app = Flask(__name__)

# MySQL configuration
app.config['MYSQL_HOST'] = 'your_mysql_host'
app.config['MYSQL_USER'] = 'your_mysql_user'
app.config['MYSQL_PASSWORD'] = 'your_mysql_password'
app.config['MYSQL_DB'] = 'your_mysql_database'

mysql = MySQL(app)

# Route to get the subtotal of books in the user's shopping cart
@app.route('/api/shopping-cart/subtotal', methods=['GET'])
def get_subtotal():
    try:
        # Get user ID from the request parameters
        user_id = int(request.args.get('userId'))
    except ValueError:
        return jsonify({"error": "Invalid User ID"}), 400

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
        cursor = mysql.connection.cursor()
        cursor.execute(query, (user_id,))
        result = cursor.fetchone()

        if result:
            # Return the response with the calculated subtotal
            return jsonify({"userId": result[0], "subtotal": float(result[1])})
        else:
            return jsonify({"error": "User not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

if __name__ == '__main__':
    app.run(debug=True)

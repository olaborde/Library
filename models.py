from extensions import db
from sqlalchemy.inspection import inspect


class Author(db.Model):
    __tablename__ = 'Authors'
    AuthorID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    FirstName = db.Column(db.String(255), nullable=False)
    LastName = db.Column(db.String(255), nullable=False)
    Biography = db.Column(db.Text)
    books = db.relationship('Book', backref='author_backref', lazy='dynamic')

    def to_dict(self, include_relationships=False):
        data = {c.key: getattr(self, c.key) for c in inspect(self).mapper.column_attrs}
        
        if include_relationships:
            for relationship in inspect(self).mapper.relationships:
                data[relationship.key] = [item.to_dict() for item in getattr(self, relationship.key)]
        return data

class Publisher(db.Model):
    __tablename__ = 'Publishers'
    PublisherID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    Name = db.Column(db.String(255), nullable=False)
    Address = db.Column(db.Text)
    Phone = db.Column(db.String(20))
    books = db.relationship('Book', backref='publisher', lazy=True)

class AuthorPublisher(db.Model):
    __tablename__ = 'AuthorPublisher'
    AuthorID = db.Column(db.BigInteger, db.ForeignKey('Authors.AuthorID'), primary_key=True)
    PublisherID = db.Column(db.BigInteger, db.ForeignKey('Publishers.PublisherID'), primary_key=True)

class Book(db.Model):
    __tablename__ = 'Books'
    BookID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    ISBN = db.Column(db.String(255), unique=True, nullable=False)
    Name = db.Column(db.String(255), nullable=False)
    Description = db.Column(db.Text)
    Price = db.Column(db.Numeric(10, 2))
    author_id = db.Column(db.Integer, db.ForeignKey('authors.id'))
    Genre = db.Column(db.String(255))
    PublisherID = db.Column(db.BigInteger, db.ForeignKey('Publishers.PublisherID'), nullable=False)
    YearPublished = db.Column(db.Integer)
    CopiesSold = db.Column(db.Integer)

class User(db.Model):
    __tablename__ = 'Users'
    UserID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    Username = db.Column(db.String(255), unique=True, nullable=False)
    Password = db.Column(db.String(255), nullable=False)
    Name = db.Column(db.String(255))
    EmailAddress = db.Column(db.String(255))
    HomeAddress = db.Column(db.Text)
    credit_cards = db.relationship('UserCreditCards', backref='user', lazy=True)
    shopping_cart = db.relationship('ShoppingCart', backref='user', uselist=False)
    book_ratings = db.relationship('BookRatings', backref='user', lazy=True)
    book_comments = db.relationship('BookComments', backref='user', lazy=True)
    wish_lists = db.relationship('WishLists', backref='user', lazy=True)

class UserCreditCards(db.Model):
    __tablename__ = 'UserCreditCards'
    CardID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    UserID = db.Column(db.BigInteger, db.ForeignKey('Users.UserID'), nullable=False)
    CardNumber = db.Column(db.String(255))
    CardHolderName = db.Column(db.String(255))
    ExpirationDate = db.Column(db.Date)
    CVV = db.Column(db.String(4))

class ShoppingCart(db.Model):
    __tablename__ = 'ShoppingCart'
    CartID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    UserID = db.Column(db.BigInteger, db.ForeignKey('Users.UserID'), nullable=False)

class CartItems(db.Model):
    __tablename__ = 'CartItems'
    CartItemID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    CartID = db.Column(db.BigInteger, db.ForeignKey('ShoppingCart.CartID'), nullable=False)
    BookID = db.Column(db.BigInteger, db.ForeignKey('Books.BookID'), nullable=False)
    Quantity = db.Column(db.Integer)

class BookRatings(db.Model):
    __tablename__ = 'BookRatings'
    RatingID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    BookID = db.Column(db.BigInteger, db.ForeignKey('Books.BookID'), nullable=False)
    UserID = db.Column(db.BigInteger, db.ForeignKey('Users.UserID'), nullable=False)
    Rating = db.Column(db.Integer)
    DateStamp = db.Column(db.TIMESTAMP)

class BookComments(db.Model):
    __tablename__ = 'BookComments'
    CommentID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    BookID = db.Column(db.BigInteger, db.ForeignKey('Books.BookID'), nullable=False)
    UserID = db.Column(db.BigInteger, db.ForeignKey('Users.UserID'), nullable=False)
    Comment = db.Column(db.Text)
    DateStamp = db.Column(db.TIMESTAMP)

class WishLists(db.Model):
    __tablename__ = 'WishLists'
    WishListID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    UserID = db.Column(db.BigInteger, db.ForeignKey('Users.UserID'), nullable=False)
    Name = db.Column(db.String(255))

class WishListItems(db.Model):
    __tablename__ = 'WishListItems'
    WishListItemID = db.Column(db.BigInteger, primary_key=True, autoincrement=True)
    WishListID = db.Column(db.BigInteger, db.ForeignKey('WishLists.WishListID'), nullable=False)
    BookID = db.Column(db.BigInteger, db.ForeignKey('Books.BookID'), nullable=False)

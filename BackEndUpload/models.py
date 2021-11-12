from db import db

# product class/Model
class Img(db.Model):
 id = db.Column(db.Integer, primary_key=True)
 img = db.Column(db.Text, nullable=False)
 img1 = db.Column(db.Text, nullable=False)
 img2 = db.Column(db.Text, nullable=False)
 img3 = db.Column(db.Text, nullable=False)
 img4 = db.Column(db.Text, nullable=False)
 name = db.Column(db.Text, nullable=False)
 mimetype = db.Column(db.Text, nullable=False)
 #imgId = db.Column(db.Text, nullable=False)
 #def __init__(self, id):
 #self.id = id

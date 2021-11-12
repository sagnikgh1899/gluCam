from flask_sqlalchemy import SQLAlchemy

#init db
db = SQLAlchemy()

#function that initiallise the db and create the table
def db_init(app):
    db.init_app(app)

    #create table if the sb scption already exist
    with app.app_context():
        db.create_all()

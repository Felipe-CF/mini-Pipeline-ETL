import psycopg2
from psycopg2.errors import UniqueViolation

class Database:
    def __init__(self):
        database_connection = psycopg2.connect(
            host='localhost',
            database='pipeline',
            user='desafio',
            password='desafio'
        ) 
    
    def connection(self):
        return self.database_connection.cursor()




if __name__ == '__main__':
    db = psycopg2.connect(
            host='localhost',
            database='pipeline',
            user='desafio',
            password='desafio'
        ) 

    cursor = db.cursor()

    cursor.execute(
        "INSERT INTO categories (category_name) VALUES (%s);",
        ('Freios',))
    
    db.commit()

    cursor.close()

    db.close()


    x=2
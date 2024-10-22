import mysql.connector as mc

# Connection class to handle MySQL operations
class Connection:
    def __init__(self, options):
            self.client = mc.connect(**options)
            self.cursor = self.client.cursor()
            if self.client.is_connected():
                print(f"Connected to the database successfully!")
import mysql.connector as mc

# Connection class to handle MySQL operations
class Connection:
    def __init__(self, options):
            self.client = mc.connect(**options)
            self.cursor = self.client.cursor()
            if self.client.is_connected():
                print(f"Connected to the database successfully!")

    def list_rows(self):
        self.cursor.execute("SELECT * FROM movies")
        results = self.cursor.fetchall()

        print("MovieID\tMovie Name\t\tRating")
        for row in results:
            print(
                "{0}\t{1}\t\t\t{2}".format(
                    row[0],
                    row[1],
                    row[2],
                )
            )

    def create_row(self):
        print("\nEnter new movie details")
        movieName = input("Name of movie: ")
        rating = float(input("Rating (out of 10): "))

        self.cursor.execute(
            "INSERT INTO movies(movie_name, rating) VALUES(%s, %s)",
            (movieName, rating),
        )
        self.client.commit()

        print("\nNew movie added!")

    def delete_row(self):
        movieID = int(input("\nEnter ID of movie to remove: "))
        self.cursor.execute(f"DELETE FROM movies WHERE movie_id = {movieID}")
        self.client.commit()
        print("\nMovie removed successfully!")

    def update_row(self):
        movieID = int(input("\nEnter movie ID to update: "))
        rating = float(input("New rating (out of 10): "))
        
        query = f"UPDATE movies SET rating = {rating} WHERE movie_id = {movieID}"
        self.cursor.execute(query)
        self.client.commit()

        print("\nMovie rating updated successfully!")

    def close(self):
        self.cursor.close()
        self.client.close()



options = {
    "host": "localhost",
    "user": "root",
    "password": "Sarvesh@123",
    "database": "TECO2425A022", 
}

# Main loop for user interaction
conn = Connection(options)

while True:
    print("\n\t\t\tMovie Database\t\t\t")
    print("1. Show all movies")
    print("2. Add new Movie")
    print("3. Update Movie Rating")
    print("4. Delete Movie")
    print("5. Exit")

    ch = int(input("\nEnter option: "))

    if ch == 1:
        conn.list_rows()

    elif ch == 2:
        conn.create_row()

    elif ch == 3:
        conn.update_row()

    elif ch == 4:
        conn.delete_row()

    elif ch == 5:
        conn.close() 
        print("Thank you!")
        break

    else:
        print("Invalid option. Please choose again.")
        

    def list_rows(self):
        self.cursor.execute("SELECT * FROM movies")
        results = self.cursor.fetchall()

        print("MovieID\tMovie Name\t\tRating")
        for row in results:
            print(
                "{0}\t{1}\t\t\t{2}".format(
                    row[0],
                    row[1],
                    row[2],
                )
            )

    def create_row(self):
        print("\nEnter new movie details")
        movieName = input("Name of movie: ")
        rating = float(input("Rating (out of 10): "))

        self.cursor.execute(
            "INSERT INTO movies(movie_name, rating) VALUES(%s, %s)",
            (movieName, rating),
        )
        self.client.commit()

        print("\nNew movie added!")

    def delete_row(self):
        movieID = int(input("\nEnter ID of movie to remove: "))
        self.cursor.execute(f"DELETE FROM movies WHERE movie_id = {movieID}")
        self.client.commit()
        print("\nMovie removed successfully!")

    def update_row(self):
        movieID = int(input("\nEnter movie ID to update: "))
        rating = float(input("New rating (out of 10): "))
        query = f"UPDATE movies SET rating = {rating} WHERE movie_id = {movieID}"
        self.cursor.execute(query)
        self.client.commit()

        print("\nMovie rating updated successfully!")

    def close(self):
        self.cursor.close()
        self.client.close()



options = {
    "host": "localhost",
    "user": "root",
    "password": "Sarvesh@123",
    "database": "TECO2425A022", 
}

# Main loop for user interaction
conn = Connection(options)

while True:
    print("\n\t\t\tMovie Database\t\t\t")
    print("1. Show all movies")
    print("2. Add new Movie")
    print("3. Update Movie Rating")
    print("4. Delete Movie")
    print("5. Exit")

    ch = int(input("\nEnter option: "))

    if ch == 1:
        conn.list_rows()

    elif ch == 2:
        conn.create_row()

    elif ch == 3:
        conn.update_row()

    elif ch == 4:
        conn.delete_row()

    elif ch == 5:
        conn.close()
        print("Thank you!")
        break

    else:
        print("Invalid option. Please choose again.")
        


import sqlite3

conn = sqlite3.connect('music_library.db')
cursor = conn.cursor()

try:
    # Table Creation
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS Artists (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
        )
    """)
    
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS Genres (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE
        )
    """)

    cursor.execute("""
        CREATE TABLE IF NOT EXISTS Albums (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            artist_id INTEGER,
            genre_id INTEGER,
            release_year INTEGER,
            total_tracks INTEGER,
            duration INTEGER,
            FOREIGN KEY(artist_id) REFERENCES Artists(id) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY(genre_id) REFERENCES Genres(id) ON DELETE CASCADE ON UPDATE CASCADE
        )
    """)
    print("Tables created or already exist.")

except sqlite3.Error as e:
    print("Error:", e)

finally:
    conn.close()
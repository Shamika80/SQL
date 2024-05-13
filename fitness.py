import sqlite3

conn = sqlite3.connect('fitness_center.db')
cursor = conn.cursor()

# Create Tables (If They Don't Exist)
cursor.execute('''
    CREATE TABLE IF NOT EXISTS Members (
        id INT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        age INT,
        trainer_id INT,
        FOREIGN KEY (trainer_id) REFERENCES Trainers(id)
    );
''')

cursor.execute('''
    CREATE TABLE IF NOT EXISTS WorkoutSessions (
        session_id INT PRIMARY KEY,
        member_id INT,
        session_date DATE,
        session_time VARCHAR(50),
        activity VARCHAR(255),
        FOREIGN KEY (member_id) REFERENCES Members(id)
    );
''')

# Task 1: Data Insertion (Including John Smith)
try:
    # Insert Members (with John Smith)
    members_data = [
        (1, 'John Doe', 35, 2), 
        (2, 'Jane Doe', 28, 1), 
        (3, 'Alice Johnson', 42, 3),
        (4, 'John Smith', 30, 2)  # Add John Smith
    ]
    cursor.executemany("INSERT INTO Members VALUES (?, ?, ?, ?)", members_data)

    # Insert WorkoutSessions
    workout_sessions_data = [
        (1, 2, '2024-05-13', 'Morning', 'Cardio'),
        (2, 1, '2024-05-13', 'Afternoon', 'Strength Training'),
        (3, 3, '2024-05-12', 'Evening', 'Yoga')
    ]
    cursor.executemany("INSERT INTO WorkoutSessions VALUES (?, ?, ?, ?, ?)", workout_sessions_data)

    conn.commit()
    print("Data inserted successfully.")

except sqlite3.Error as e:
    print("Error inserting data:", e)

# Task 2: Data Update
try:
    member_name = 'Jane Doe'
    new_session_time = 'Evening'
    cursor.execute(
        "UPDATE WorkoutSessions SET session_time = ? WHERE member_id = (SELECT id FROM Members WHERE name = ?)",
        (new_session_time, member_name)
    )
    conn.commit()
    print("Workout session time updated successfully.")

except sqlite3.Error as e:
    print("Error updating workout session:", e)

# Task 3: Data Deletion (John Smith)
try:
    member_name = 'John Smith' 
    cursor.execute("DELETE FROM Members WHERE name = ?", (member_name,))
    conn.commit()
    print("Member record deleted successfully.")

except sqlite3.Error as e:
    print("Error deleting member record:", e)

conn.close()

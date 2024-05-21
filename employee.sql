import sqlite3

conn = sqlite3.connect('employee_database.db')
cursor = conn.cursor()

# DDL: Create Tables (If They Don't Exist)
cursor.execute('''
    CREATE TABLE IF NOT EXISTS Departments (
        department_id INT PRIMARY KEY,
        department_name VARCHAR(100)
    );
''')

cursor.execute('''
    CREATE TABLE IF NOT EXISTS Employees (
        employee_id INT PRIMARY KEY,
        name VARCHAR(100),
        age INT,
        department_id INT,
        FOREIGN KEY (department_id) REFERENCES Departments(department_id)
    );
''')

# DML: Populate Tables (Sample Data)
try:
    departments_data = [
        (1, 'Engineering'),
        (2, 'Sales'),
        (3, 'Marketing'),
        (4, 'Finance')
    ]
    cursor.executemany("INSERT OR IGNORE INTO Departments VALUES (?, ?)", departments_data)  # Use INSERT OR IGNORE to avoid duplicates

    employees_data = [
        (1, 'Alice Johnson', 30, 1),
        (2, 'Bob Smith', 28, 2),
        (3, 'Charlie Brown', 35, 1),
        (4, 'David Lee', 26, 3),
        (5, 'Eva Williams', 29, 4),
        (6, 'Frank Davis', 40, 2)
    ]
    cursor.executemany("INSERT OR IGNORE INTO Employees VALUES (?, ?, ?, ?)", employees_data)  # Use INSERT OR IGNORE to avoid duplicates

    conn.commit()  

except sqlite3.Error as e:
    print("Error populating tables:", e)

# Task 1: Distinct Departments
try:
    cursor.execute("""
        SELECT DISTINCT department_name
        FROM Departments
        WHERE department_id IN (SELECT DISTINCT department_id FROM Employees)
    """)

    department_names = [row[0] for row in cursor.fetchall()]
    print("Distinct Departments:")
    for name in department_names:
        print(name)

except sqlite3.Error as e:
    print("Error fetching distinct departments:", e)

try:
    cursor.execute("""
        SELECT department_name, COUNT(*) AS employee_count
        FROM Employees
        INNER JOIN Departments ON Employees.department_id = Departments.department_id
        GROUP BY department_name
    """)

    employee_counts = cursor.fetchall()
    print("\nEmployee Count per Department:")
    for row in employee_counts:
        print(f"{row[0]}: {row[1]}")

except sqlite3.Error as e:
    print("Error counting employees per department:", e)

try:
    cursor.execute("""
        SELECT name, age, department_id
        FROM Employees
        WHERE age BETWEEN 25 AND 30
    """)

    employees_aged_25_to_30 = cursor.fetchall()
    print("\nEmployees Aged 25-30:")
    for row in employees_aged_25_to_30:
        print(row)

except sqlite3.Error as e:
    print("Error fetching employees aged 25-30:", e)

conn.close()
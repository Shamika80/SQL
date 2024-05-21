Create Artists table with index on ArtistName
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY AUTO_INCREMENT,
    ArtistName VARCHAR(100) NOT NULL UNIQUE
);

CREATE INDEX idx_artistname ON Artists (ArtistName);

Create Genre table with index on GenreName
CREATE TABLE Genre (
    GenreID INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(50) NOT NULL UNIQUE
);

CREATE INDEX idx_genrename ON Genre (GenreName);

Create Albums table with foreign keys and indexes
CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    ArtistID INT NOT NULL,
    GenreID INT NOT NULL,
    ReleaseYear YEAR,
    TotalTracks INT,
    Duration INT,  
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);

CREATE INDEX idx_albumtitle ON Albums (Title);
CREATE INDEX idx_albumreleaseyear ON Albums (ReleaseYear);

-- Insert Artists
INSERT INTO Artists (ArtistName) VALUES 
    ('Taylor Swift'), ('Ed Sheeran'), ('Adele'), ('Beyoncé');

-- Insert Genres
INSERT INTO Genre (GenreName) VALUES 
    ('Pop'), ('Folk'), ('Soul'), ('R&B');

-- Insert Albums
INSERT INTO Albums (Title, ArtistID, GenreID, ReleaseYear, TotalTracks, Duration) VALUES
    ('1989', 1, 1, 2014, 13, 37), -- Taylor Swift, Pop
    ('÷ (Divide)', 2, 1, 2017, 12, 46), -- Ed Sheeran, Pop
    ('25', 3, 3, 2015, 11, 39), -- Adele, Soul
    ('Lemonade', 4, 4, 2016, 12, 45); -- Beyoncé, R&B
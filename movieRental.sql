-- Create table for Movies
CREATE TABLE Movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    director VARCHAR(100) NOT NULL
);

-- Create table for Customers
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15)
);

-- Create table for Rentals
CREATE TABLE Rentals (
    rental_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES Movies(movie_id),
    customer_id INT REFERENCES Customers(customer_id),
    rental_date DATE NOT NULL,
    return_date DATE
);

-- Insert data into movies
INSERT INTO Movies (title, release_year, genre, director)
VALUES 
('Wedding Party', 2016, 'Drama', 'Kemi Adetiba'),
('Inception', 2010, 'Sci-Fi', 'Christopher Nolan'),
('Avatar', 2023, 'Sci-Fi', 'James Cameron'),
('The Dark Knight', 2008, 'Action', 'Christopher Nolan'),
('Gang of Lagos', 2023, 'Crime', 'Jadesola Osiberu');

-- Insert data into customer
INSERT INTO Customers (first_name, last_name, email, phone_number)
VALUES 
('Kunle', 'Akinpelu', 'k.akinpelu@gmail.com', '1234567890'),
('Janet', 'Mark', 'janetmark@yahoo.com', '0987654321'),
('Ahmed', 'Mustafa', 'amustafa@gmail.com', '5678901234'),
('Bob', 'Smith', 'bobsmith@icloud.com', '4567890123'),
('David', 'Otis', 'otisdavid@gmail.com', '6789012345');

-- Insert data into rentals
INSERT INTO Rentals (movie_id, customer_id, rental_date, return_date)
VALUES 
(1, 1, '2024-10-01', '2024-10-08'),
(2, 1, '2024-10-05', '2024-10-12'),
(3, 2, '2024-09-29', '2024-10-06'),
(4, 3, '2024-10-02', '2024-10-09'),
(5, 4, '2024-10-03', NULL),
(1, 5, '2024-10-04', '2024-10-11'),
(2, 5, '2024-10-05', '2024-10-12'),
(3, 4, '2024-10-04', NULL),
(4, 2, '2024-10-06', NULL),
(5, 3, '2024-10-07', '2024-10-14');

-- Query rented movie by email
SELECT Movies.title
FROM Movies
JOIN Rentals ON Movies.movie_id = Rentals.movie_id
JOIN Customers ON Rentals.customer_id = Customers.customer_id
WHERE Customers.email = 'k.akinpelu@gmail.com';

-- Query customer by movie title
SELECT Customers.first_name, Customers.last_name
FROM Customers
JOIN Rentals ON Customers.customer_id = Rentals.customer_id
JOIN Movies ON Rentals.movie_id = Movies.movie_id
WHERE Movies.title = 'Inception';

-- Query movies rental history
SELECT Customers.first_name, Customers.last_name, Rentals.rental_date, Rentals.return_date
FROM Customers
JOIN Rentals ON Customers.customer_id = Rentals.customer_id
JOIN Movies ON Rentals.movie_id = Movies.movie_id
WHERE Movies.title = 'Avatar';

-- Query customer name when a movie by specific director rented
SELECT Customers.first_name, Customers.last_name, Rentals.rental_date, Movies.title
FROM Customers
JOIN Rentals ON Customers.customer_id = Rentals.customer_id
JOIN Movies ON Rentals.movie_id = Movies.movie_id
WHERE Movies.director = 'Jadesola Osiberu';

-- Query all rented out movies
SELECT Movies.title
FROM Movies
JOIN Rentals ON Movies.movie_id = Rentals.movie_id
WHERE Rentals.return_date IS NULL;


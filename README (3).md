

Online Movie Ticketing System — README


This project models an Online Movie Ticketing System (like a simplified BookMyShow).
It includes tables to manage users, movies, theaters, screens, shows, seats, bookings, payments, and reviews. The SQL file with analysis and sample queries is included. 


1. ER diagram — quick summary

The ER diagram shows the main entities (tables) and how they connect:

user — people who register and book tickets.

movies — movie details (title, genre, duration, rating, release_date).

theaters — theater chains / locations (name, city, state).

screens — physical screens inside a theater (screen_number, total_seats).

shows — specific movie showtimes on a screen (movie_id, theater_id, screen_id, show_date, start_time, price_per_ticket, available_seats).

seats — individual booked seats for a booking (seat_number, seat_type).

bookings — booking records made by users (user_id, show_id, total_tickets, booking_date, payment_status).

payments — transactions for bookings (booking_id, user_id, amount, payment_method, transaction_status).

reviews — user reviews for movies (user_id, movie_id, rating, review_text).

Relationships (examples):

A theater has many screens.

A screen hosts many shows.

A show is for one movie and in one theater/screen.

A user can make many bookings.

A booking can have many seats.

A booking is associated with a payment.

A user can write many reviews for movies.

** Problem Statement

People often face difficulties when booking movie tickets offline, such as long queues, limited availability information, and no easy way to compare show timings across theaters. Theater owners also struggle to manage bookings, seat availability, payments, and customer feedback efficiently.

To solve these issues, an Online Movie Ticketing System is needed that:

Allows users to browse movies, showtimes, and theaters easily.

Lets users book specific seats and make secure payments online.

Tracks bookings, payments, and seat availability in real time.

Stores user reviews and ratings for better decision-making.

Helps theater owners manage screens, shows, and revenue efficiently.

The ER model and database in this project provide the complete backend foundation to support these features—covering users, movies, theaters, screens, shows, seats, bookings, payments, and reviews.



2. Table-by-table description (easy language)
user

Holds user details:

user_id, name, email, phone_number, date_of_birth

movies

Holds movie info:

movie_id, title, genre, language, duration, rating, release_date

theaters

Holds theater info:

theater_id, name, location, city, state

screens

Holds screens for theaters:

screen_id, theater_id (links to theater), screen_number, total_seats

shows

Holds showtimes:

show_id, movie_id, theater_id, screen_id, show_date, start_time, price_per_ticket, available_seats

seats

Seats booked in a booking:

seat_id, booking_id, screen_id, seat_number, seat_type (e.g., regular, premium)

bookings

Booking master record:

booking_id, user_id, show_id, booking_date, total_tickets, payment_status

payments

Payment details:

payment_id, booking_id, user_id, payment_method, payment_date, transaction_status

reviews

User movie reviews:

review_id, user_id, movie_id, rating, review_text, review_date

3. How to set up the database (simple steps)

Create database:

CREATE DATABASE book_my_show;
USE book_my_show;


Create tables according to the schema in your SQL file (the file provided contains analysis and queries). 


(If you need, I can generate full CREATE TABLE statements from the diagram.)

Insert seed/sample data into tables (users, theaters, movies, screens, shows, etc.).

Run the example analysis queries from the SQL file to test.

4. Useful example queries (these come from the included SQL analysis)

Count total users:

SELECT COUNT(*) AS total_users FROM user;


Top 5 highest-rated movies:

SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 5;


Movies generating highest revenue:

SELECT m.title, SUM(b.total_tickets * sh.price_per_ticket) AS total_revenue
FROM bookings b
JOIN shows sh ON b.show_id = sh.show_id
JOIN movies m ON sh.movie_id = m.movie_id
GROUP BY m.title
ORDER BY total_revenue DESC;


Bookings with failed or pending payments:

SELECT u.name, b.booking_id, p.transaction_status
FROM bookings b
JOIN payments p ON b.booking_id = p.booking_id
JOIN user u ON b.user_id = u.user_id
WHERE p.transaction_status != 'SUCCESS';



5. Key business questions / KPIs you can answer with this model

Total registered users and growth over time.

Top-grossing movies and theaters.

Average ticket price by city.

Most popular show times and days.

Users with most bookings and reviews.

Failed payments and users with repeated failed transactions.

Seat-booking patterns (which seat types sell faster).

Theater screen capacities and utilization.


6. Suggested improvements (next steps)

Add timestamps: created_at, updated_at in important tables for audit.

Enforce FK constraints: ensure referential integrity between tables.

Normalize data where needed (e.g., separate address table for theaters if many fields).

Add indexes on frequently queried columns (e.g., user_id, show_id, movie_id) for faster analytics.

Add seat layout: store seat coordinates or zone pricing to support seat selection UI.

Add user roles: admin vs customer if you plan admin features.

Support refunds and partial cancellations in payments and bookings.

7. Notes & references

The provided SQL analysis file contains many example queries and the problem statement used for this project. 


ER Diagram image is included in project files: ER Diagram.png.


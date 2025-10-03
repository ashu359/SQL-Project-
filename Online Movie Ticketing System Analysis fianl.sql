#  Online Movie Ticketing System Analysis

/* Problem statement - Managing online movie ticket booking involves challenges such as tracking user activity,
 identifying popular movies, analyzing revenue, managing theater performance,
 and handling payment issues. Without proper analysis, it is difficult to understand customer preferences,
 optimize theater operations, and make business-driven decisions */

use abc;

create database book_my_show;
use book_my_show;

select * from user;
select * from screens;
select * from theaters;
select * from shows;
select * from seats;
select * from reviews;
select * from payments;
select * from movies;
select * from bookings;

# 1.How many users are registered in the system?
SELECT COUNT(*) AS total_users FROM user;

# 2.Which are the top 5 highest-rated movies?
SELECT m.title, AVG(r.rating) AS avg_rating
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 5;

# 3. Which users made the most bookings?
SELECT u.name, COUNT(b.booking_id) AS total_bookings
FROM user u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.name
ORDER BY total_bookings DESC;

# 4. Which movies generated the highest revenue?
SELECT m.title, SUM(b.total_tickets * sh.price_per_ticket) AS total_revenue
FROM bookings b
JOIN shows sh ON b.show_id = sh.show_id
JOIN movies m ON sh.movie_id = m.movie_id
GROUP BY m.title
ORDER BY total_revenue DESC;

# 5. Which theater has the highest revenue?
SELECT t.name, SUM(b.total_tickets * sh.price_per_ticket) AS revenue
FROM bookings b
JOIN shows sh ON b.show_id = sh.show_id
JOIN theaters t ON sh.theater_id = t.theater_id
GROUP BY t.name
ORDER BY revenue DESC;

# 6. What are the most popular show timings?
SELECT sh.start_time, COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN shows sh ON b.show_id = sh.show_id
GROUP BY sh.start_time
ORDER BY total_bookings DESC;

# 7. Which bookings have pending/failed payments?
SELECT u.name, b.booking_id, p.transaction_status
FROM bookings b
JOIN payments p ON b.booking_id = p.booking_id
JOIN user u ON b.user_id = u.user_id
WHERE p.transaction_status != 'SUCCESS';

# 8. Which cities have the most bookings?
SELECT t.city, COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN shows sh ON b.show_id = sh.show_id
JOIN theaters t ON sh.theater_id = t.theater_id
GROUP BY t.city
ORDER BY total_bookings DESC;

# 9.What is the average ticket price per city?
SELECT t.city, AVG(sh.price_per_ticket) AS avg_ticket_price
FROM shows sh
JOIN theaters t ON sh.theater_id = t.theater_id
GROUP BY t.city
ORDER BY avg_ticket_price DESC;

# 10. Which users booked tickets but never left reviews?
SELECT u.name, COUNT(b.booking_id) AS total_bookings
FROM user u
JOIN bookings b ON u.user_id = b.user_id
LEFT JOIN reviews r ON u.user_id = r.user_id
WHERE r.review_id IS NULL
GROUP BY u.name;

# 11.Which theaters are most popular by bookings?
SELECT t.name, COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN shows sh ON b.show_id = sh.show_id
JOIN theaters t ON sh.theater_id = t.theater_id
GROUP BY t.name
ORDER BY total_bookings DESC;

# 12. Which users had multiple failed payments?
SELECT u.name, COUNT(p.payment_id) AS failed_payments
FROM payments p
JOIN user u ON p.user_id = u.user_id
WHERE p.transaction_status = 'FAILED'
GROUP BY u.name
HAVING COUNT(p.payment_id) > 1;

# 13. Who booked the maximum number of seats? 
SELECT u.name, COUNT(s.seat_id) AS seats_booked
FROM seats s
JOIN bookings b ON s.booking_id = b.booking_id
JOIN user u ON b.user_id = u.user_id
GROUP BY u.name
ORDER BY seats_booked DESC
LIMIT 10;

# 14.Which theaters have the largest screens (seat capacity)? 
SELECT t.name, MAX(sc.total_seats) AS largest_screen_capacity
FROM screens sc
JOIN theaters t ON sc.theater_id = t.theater_id
GROUP BY t.name
ORDER BY largest_screen_capacity DESC;

# 15. Which payment methods are most used? 
SELECT p.payment_method, COUNT(p.payment_id) AS total_transactions
FROM payments p
GROUP BY p.payment_method
ORDER BY total_transactions DESC;

# 16. Which users gave the most reviews?
SELECT u.name, COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN user u ON r.user_id = u.user_id
GROUP BY u.name
ORDER BY total_reviews DESC;

# 17. Which theaters operate in multiple states?
SELECT name, COUNT(DISTINCT state) AS states_count
FROM theaters
GROUP BY name
HAVING states_count > 1;

# 18. Find the average rating of movies by genre.
SELECT m.genre, AVG(r.rating) AS avg_genre_rating
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY avg_genre_rating DESC;

















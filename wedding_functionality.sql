
--  WEDDING MANAGEMENT SYSTEM : FUNCTIONAL QUERIES

USE wedding_management;


-- 1️⃣ WEDDING MANAGEMENT

-- View all weddings
SELECT wedding_id, wedding_date, budget, status
FROM Wedding
ORDER BY wedding_date;

-- View all weddings managed by a user
SELECT 
    w.wedding_id,
    w.wedding_date,
    w.status,
    w.budget
FROM Wedding_user wu
JOIN Wedding w ON wu.wedding_id = w.wedding_id
WHERE wu.user_id = 2;

-- Upcoming (planned) weddings
SELECT wedding_id, wedding_date, budget
FROM Wedding
WHERE status = 'planned'
ORDER BY wedding_date;

-- Completed weddings with total payment
SELECT w.wedding_id, w.status, SUM(p.amount) AS total_paid
FROM Wedding w
JOIN Payment p ON w.wedding_id = p.wedding_id
WHERE w.status = 'completed'
GROUP BY w.wedding_id;

-- Update wedding status
UPDATE Wedding
SET status = 'completed'
WHERE wedding_id = 4;

-- Weddings organized by each user
SELECT u.name AS organizer_name, COUNT(wu.wedding_id) AS total_weddings
FROM User u
JOIN Wedding_user wu ON u.user_id = wu.user_id
GROUP BY u.user_id;

-- Wedding details with venue and theme
SELECT w.wedding_id, v.name AS venue_name, t.theme_name, w.status, w.budget
FROM Wedding w
JOIN Wedding_venue wv ON w.wedding_id = wv.wedding_id
JOIN Venue v ON wv.venue_id = v.venue_id
JOIN Wedding_theme wt ON w.wedding_id = wt.wedding_id
JOIN Theme t ON wt.theme_id = t.theme_id
ORDER BY w.wedding_date;

-- 2️⃣ GUEST MANAGEMENT

-- View guest list for each wedding
SELECT w.wedding_id, g.name AS guest_name, g.rsvp_status, g.meal_preference
FROM Guest g
JOIN Wedding_guest wg ON g.guest_id = wg.guest_id
JOIN Wedding w ON wg.wedding_id = w.wedding_id
ORDER BY w.wedding_id;

-- Count total guests per wedding
SELECT w.wedding_id, COUNT(g.guest_id) AS total_guests
FROM Wedding w
JOIN Wedding_guest wg ON w.wedding_id = wg.wedding_id
JOIN Guest g ON wg.guest_id = g.guest_id
GROUP BY w.wedding_id;

-- Guests who declined invitations
SELECT g.name AS guest_name, wg.wedding_id
FROM Guest g
JOIN Wedding_guest wg ON g.guest_id = wg.guest_id
WHERE g.rsvp_status = 'declined';

-- Update guest RSVP
UPDATE Guest
SET rsvp_status = 'confirmed'
WHERE guest_id = 4;

-- 3️⃣ VENDOR MANAGEMENT

-- All vendors with their ratings
SELECT vendor_id, name, service_type, rating, cost_estimate
FROM Vendor
ORDER BY rating DESC;

-- Vendors booked for each wedding
SELECT w.wedding_id, v.name AS vendor_name, v.service_type, wv.service_status
FROM Wedding_vendor wv
JOIN Vendor v ON wv.vendor_id = v.vendor_id
JOIN Wedding w ON wv.wedding_id = w.wedding_id
ORDER BY w.wedding_id;

-- Vendors pending confirmation
SELECT v.name, wv.wedding_id, wv.service_status
FROM Wedding_vendor wv
JOIN Vendor v ON wv.vendor_id = v.vendor_id
WHERE wv.service_status = 'pending';

-- Update vendor service status
UPDATE Wedding_vendor
SET service_status = 'completed'
WHERE wedding_id = 4 AND vendor_id = 7;

-- Top 3 highest rated vendors
SELECT name, service_type, rating
FROM Vendor
ORDER BY rating DESC
LIMIT 3;

-- 4️⃣ TASK MANAGEMENT

-- All tasks with vendor and wedding
SELECT t.task_id, t.task_name, t.assigned_to, t.deadline, t.status, v.name AS vendor_name, w.wedding_id
FROM Task t
JOIN Vendor v ON t.vendor_id = v.vendor_id
JOIN Wedding w ON t.wedding_id = w.wedding_id
ORDER BY t.deadline;

-- Pending tasks
SELECT task_name, assigned_to, deadline
FROM Task
WHERE status = 'pending';

-- Completed tasks per wedding
SELECT wedding_id, COUNT(*) AS completed_tasks
FROM Task
WHERE status = 'completed'
GROUP BY wedding_id;

-- Update task status
UPDATE Task
SET status = 'completed'
WHERE task_id = 5;

-- 5️⃣ PAYMENT MANAGEMENT

-- All payment records
SELECT payment_id, wedding_id, vendor_id, amount, payment_date, payment_mode, status
FROM Payment
ORDER BY payment_date;

-- Total payment per wedding
SELECT w.wedding_id, SUM(p.amount) AS total_payment
FROM Wedding w
JOIN Payment p ON w.wedding_id = p.wedding_id
GROUP BY w.wedding_id
ORDER BY total_payment DESC;

-- Pending payments
SELECT p.payment_id, v.name AS vendor_name, p.amount, p.status
FROM Payment p
JOIN Vendor v ON p.vendor_id = v.vendor_id
WHERE p.status = 'pending';

-- Update payment to completed
UPDATE Payment
SET status = 'completed'
WHERE payment_id = 4;

-- Total spent per vendor
SELECT v.name AS vendor_name, SUM(p.amount) AS total_paid
FROM Payment p
JOIN Vendor v ON p.vendor_id = v.vendor_id
GROUP BY v.vendor_id;

-- 6️⃣ ANALYTICS / DASHBOARD QUERIES

-- Total number of weddings by status
SELECT status, COUNT(*) AS total_weddings
FROM Wedding
GROUP BY status;

-- Most expensive wedding
SELECT wedding_id, budget
FROM Wedding
ORDER BY budget DESC
LIMIT 1;

-- Total guests across all weddings
SELECT COUNT(guest_id) AS total_guests
FROM Wedding_guest;

-- Average budget of completed weddings
SELECT AVG(budget) AS avg_completed_budget
FROM Wedding
WHERE status = 'completed';

-- Total earnings (sum of all payments)
SELECT SUM(amount) AS total_earnings
FROM Payment
WHERE status = 'completed';

-- Planner performance (users managing most weddings)
SELECT u.name AS planner, COUNT(wu.wedding_id) AS weddings_managed
FROM User u
JOIN Wedding_user wu ON u.user_id = wu.user_id
GROUP BY u.user_id
ORDER BY weddings_managed DESC;

-- 7️⃣ COMBINED REPORTS

-- Full wedding overview: wedding + venue + theme + planner
SELECT 
    w.wedding_id,
    w.wedding_date,
    w.status,
    v.name AS venue_name,
    t.theme_name,
    u.name AS organizer
FROM Wedding w
JOIN Wedding_venue wv ON w.wedding_id = wv.wedding_id
JOIN Venue v ON wv.venue_id = v.venue_id
JOIN Wedding_theme wt ON w.wedding_id = wt.wedding_id
JOIN Theme t ON wt.theme_id = t.theme_id
JOIN Wedding_user wu ON w.wedding_id = wu.wedding_id
JOIN User u ON wu.user_id = u.user_id
ORDER BY w.wedding_date;

-- Wedding summary
-- Guests, payments and tasks are aggregated separately first: joining all three
-- directly multiplies the rows and inflates total_payments and completed_tasks.
INSERT INTO Wedding_Summary (wedding_id, total_guests, total_payments, completed_tasks, status_summary)
SELECT
    w.wedding_id,
    IFNULL(g.total_guests, 0),
    IFNULL(p.total_payments, 0),
    IFNULL(t.completed_tasks, 0),
    CONCAT(
        'Guests: ', IFNULL(g.total_guests, 0),
        ', Payments: ₹', IFNULL(p.total_payments, 0),
        ', Completed Tasks: ', IFNULL(t.completed_tasks, 0)
    )
FROM Wedding w
LEFT JOIN (SELECT wedding_id, COUNT(*) AS total_guests
           FROM Wedding_guest
           GROUP BY wedding_id) g ON w.wedding_id = g.wedding_id
LEFT JOIN (SELECT wedding_id, SUM(amount) AS total_payments
           FROM Payment
           GROUP BY wedding_id) p ON w.wedding_id = p.wedding_id
LEFT JOIN (SELECT wedding_id, SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_tasks
           FROM Task
           GROUP BY wedding_id) t ON w.wedding_id = t.wedding_id;

-- Guest distribution by meal preference
SELECT meal_preference, COUNT(*) AS total_guests
FROM Guest
GROUP BY meal_preference;

-- Vendor service utilization (how many weddings they served)
SELECT v.name AS vendor_name, COUNT(wv.wedding_id) AS weddings_served
FROM Wedding_vendor wv
JOIN Vendor v ON wv.vendor_id = v.vendor_id
GROUP BY v.vendor_id
ORDER BY weddings_served DESC;

-- Weddings per venue
SELECT v.name AS venue_name, COUNT(wv.wedding_id) AS total_weddings
FROM Wedding_venue wv
JOIN Venue v ON wv.venue_id = v.venue_id
GROUP BY v.venue_id
ORDER BY total_weddings DESC;

-- Weddings per theme
SELECT t.theme_name, COUNT(wt.wedding_id) AS total_weddings
FROM Wedding_theme wt
JOIN Theme t ON wt.theme_id = t.theme_id
GROUP BY t.theme_id
ORDER BY total_weddings DESC;
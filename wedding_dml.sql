USE wedding_management;

-- Insert Users
INSERT INTO User (name, email, phone, password, address) VALUES
('Saurabh Kumar', 'sauravKumar@example.com', '9876543210', 'pass1', 'Banaras , UP'),
('Harsh Gupta', 'harshgupta@example.com', '9823456789', 'pass2', 'Bhopal, MP'),
('Vijay Singh', 'vijaysingh@example.com', '9812345678', 'pass3', 'Ujjain, MP'),
('Arjun Dhakad', 'arjundhakad@example.com', '97555345555', 'pass4', 'Mandsaur, MP'),
('Rohit kumar', 'rohitkumar@example.com', '97444433444', 'pass5', 'Indore, MP');

-- Insert Venues
INSERT INTO Venue (name, address, capacity, cost_per_day) VALUES
('Emerald Banquet Hall', 'MG Road, Indore', 300, 50000),
('Royal Palace', 'Vijay Nagar, Indore', 500, 90000),
('The Grand Lawn', 'Airport Road, Bhopal', 800, 120000),
('Sunset Gardens', 'Rau, Indore', 400, 65000),
('Golden Orchid', 'LIG Square, Indore', 250, 45000);

-- Insert Themes
INSERT INTO Theme (theme_name, description) VALUES
('Royal Classic', 'Golden and red royal-themed decor with chandeliers'),
('Beach Vibes', 'Turquoise and white beach-themed wedding setup'),
('Floral Dream', 'Pastel floral decorations with modern lights'),
('Modern Minimalist', 'White and green aesthetic with sleek furniture'),
('Bollywood Night', 'Vibrant lighting and music inspired by Indian cinema');

-- Insert Guests
INSERT INTO Guest (name, contact, rsvp_status, meal_preference) VALUES
('Sandeep Bhisnoi', '9938776655', 'confirmed', 'Veg'),
('Aman Choudhary', '8877665544', 'confirmed', 'Vegan'),
('Daksh Dua', '7766554433', 'confirmed', 'Veg'),
('Sahil Kumar', '6654343322', 'declined', 'Veg'),
('Anjali Shaw', '9988998877', 'confirmed', 'Non-Veg'),
('Nikunj Patel', '8877665544', 'confirmed', 'Veg'),
('Aadarsh', '7764354433', 'confirmed', 'Vegan'),
('Dasari Vijay', '6232443322', 'declined', 'Veg'),
('Aryan Seth', '9988898877', 'confirmed', 'Non-Veg'),
('Ayush Topo', '5877665544', 'confirmed', 'Veg'),
('Shubham Rajput', '73223554433', 'confirmed', 'Vegan'),
('Lokesh Bharaskar', '6655443322', 'declined', 'Veg'),
('Satya Rath', '9988978877', 'confirmed', 'Non-Veg'),
('K S Shreeya', '2377665544', 'confirmed', 'Veg');

-- Insert Vendors
INSERT INTO Vendor (name, service_type, phone, email, rating, cost_estimate) VALUES
('Star Caterers', 'Catering', '9900112233', 'starcaterers@example.com', 4.9, 60000),
('LensKing Photography', 'Photography', '9898989898', 'lensking@example.com', 4.5, 40000),
('Blossom Decorators', 'Decoration', '9876123456', 'blossomdecor@example.com', 4.8, 70000),
('Melody DJs', 'Music', '9765432100', 'melodydj@example.com', 4.4, 30000),
('Elite Events', 'Planning', '9897665544', 'eliteevents@example.com', 4.9, 95000),
('Bharat Band', 'Entertainment', '9897665544', 'bharatband@example.com', 4.9, 95000),
('Vishal Ghodi Wala', 'Entertainment', '9897665544', 'vishalghodiwala@example.com', 4.9, 95000),
('Rajesh Ice Cream', 'Food', '9897665544', 'rajeshicecream@example.com', 4.9, 95000);
-- Insert Weddings
INSERT INTO Wedding (wedding_date, budget, status) VALUES
('2025-01-20', 350000, 'ongoing'),
('2025-02-15', 500000, 'completed'),
('2025-03-10', 800000, 'completed'),
('2025-04-25', 450000, 'planned'),
('2025-05-18', 600000, 'planned'),
('2025-06-22', 700000, 'planned'),
('2025-07-27', 800000, 'ongoing'),
('2025-08-31', 900000, 'planned'),
('2025-09-05', 1000000, 'planned'),
('2025-10-10', 1100000, 'completed'),
('2025-11-15', 1200000, 'ongoing'),
('2025-12-20', 1300000, 'planned');

-- Relationship Tables

-- WEDDING_USER (Organized by)
-- Each wedding is managed by one of your users (planner or client)
INSERT INTO Wedding_user (user_id, wedding_id) VALUES
(1, 1),  -- Saurabh manages Wedding 1
(2, 2),  -- Harsh manages Wedding 2
(3, 3),  -- Vijay manages Wedding 3
(4, 4),  -- Arjun manages Wedding 4
(5, 5),  -- Rohit manages Wedding 5
(2, 6),  -- Harsh also manages Wedding 6
(3, 7),  -- Vijay handles another one
(5, 8),  -- Rohit repeats as planner
(1, 9),  -- Saurabh again
(4, 10), -- Arjun returns
(2, 11), -- Harsh again
(5, 12); -- Rohit again


-- WEDDING_VENUE (Held at)
-- Assigning venues with some overlap for realism
INSERT INTO Wedding_venue (venue_id, wedding_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 6),
(2, 7),
(3, 8),
(5, 9),
(4, 10),
(1, 11),
(2, 12);


-- WEDDING_THEME (Follows)
-- Randomly assigning themes to weddings
INSERT INTO Wedding_theme (theme_id, wedding_id) VALUES
(3, 1),
(1, 2),
(4, 3),
(2, 4),
(5, 5),
(1, 6),
(3, 7),
(2, 8),
(4, 9),
(5, 10),
(3, 11),
(1, 12);


-- WEDDING_GUEST (Invites)
-- Multiple guests attending different weddings, shuffled logically
INSERT INTO Wedding_guest (guest_id, wedding_id) VALUES
-- Wedding 1 (Jan 2025)
(1, 1),  -- Sandeep Bhisnoi
(2, 1),  -- Aman Choudhary

-- Wedding 2 (Feb 2025)
(3, 2),  -- Daksh Dua
(4, 2),  -- Sahil Kumar
(5, 2),  -- Anjali Shaw

-- Wedding 3 (Mar 2025)
(6, 3),  -- Nikunj Patel
(7, 3),  -- Aadarsh

-- Wedding 4 (Apr 2025)
(8, 4),  -- Dasari Vijay
(9, 4),  -- Aryan Seth
(10, 4), -- Ayush Topo

-- Wedding 5 (May 2025)
(11, 5), -- Shubham Rajput
(12, 5), -- Lokesh Bharaskar

-- Wedding 6 (Jun 2025)
(13, 6), -- Satya Rath
(14, 6); -- K S Shreeya


-- WEDDING_VENDOR (Supplies)
-- Logical vendor assignments (many-to-many mix)
INSERT INTO Wedding_vendor (wedding_id, vendor_id, service_cost, service_status) VALUES
(1, 1, 60000, 'booked'),   
(1, 2, 40000, 'booked'),   
(2, 3, 70000, 'completed'),
(2, 4, 30000, 'booked'),   
(3, 5, 95000, 'completed'),
(3, 6, 50000, 'booked'), 
(4, 2, 45000, 'booked'),   
(4, 7, 55000, 'booked'),   
(5, 1, 60000, 'booked'),   
(5, 3, 72000, 'pending'),  
(6, 4, 35000, 'booked'),
(6, 5, 90000, 'booked'),
(7, 6, 48000, 'completed'),
(7, 2, 42000, 'completed'),
(8, 1, 62000, 'pending'),
(8, 8, 55000, 'booked'),   
(9, 3, 75000, 'completed'),
(9, 7, 53000, 'booked'),
(10, 5, 98000, 'completed'),
(11, 2, 46000, 'pending'),
(12, 1, 64000, 'booked'),
(12, 6, 47000, 'booked');


-- TASK (Each vendor’s assigned duties)
INSERT INTO Task (wedding_id, vendor_id, task_name, assigned_to, deadline, status, remark) VALUES
(1, 1, 'Catering setup', 'Priya', '2025-01-18', 'completed', 'Setup done'),
(1, 2, 'Photo session', 'Harsh', '2025-01-19', 'completed', 'Album delivered'),
(2, 3, 'Decoration setup', 'Vijay', '2025-02-10', 'completed', 'Final look approved'),
(2, 4, 'DJ soundcheck', 'Arjun', '2025-02-13', 'in_progress', 'Half done'),
(3, 5, 'Full planning', 'Rohit', '2025-03-08', 'completed', 'Executed flawlessly'),
(3, 6, 'Music and Band', 'Karan', '2025-03-09', 'completed', 'Crowd loved it'),
(4, 7, 'Horse arrival', 'Anita', '2025-04-22', 'pending', 'To be confirmed'),
(4, 2, 'Photography contract', 'Saurabh', '2025-04-20', 'in_progress', 'Booking extended'),
(5, 3, 'Decor inspection', 'Priya', '2025-05-10', 'in_progress', 'Theme finalizing'),
(6, 5, 'Event coordination', 'Vijay', '2025-06-15', 'pending', 'Initial calls done'),
(7, 6, 'Entertainment setup', 'Harsh', '2025-07-15', 'completed', 'Excellent show'),
(8, 8, 'Dessert setup', 'Rohit', '2025-08-28', 'in_progress', 'Freezers installed'),
(9, 1, 'Menu finalization', 'Saurabh', '2025-09-02', 'completed', 'Chef confirmed'),
(10, 3, 'Decor maintenance', 'Anita', '2025-10-05', 'completed', 'All props ready'),
(11, 2, 'Photo shoot setup', 'Priya', '2025-11-10', 'in_progress', 'Lights arranged'),
(12, 4, 'Music preview', 'Karan', '2025-12-15', 'pending', 'Samples being tested');


-- PAYMENT (Venue + Vendor Payments)
INSERT INTO Payment (wedding_id, venue_id, vendor_id, amount, payment_date, payment_mode, status) VALUES
(1, 1, 1, 50000, '2025-01-15', 'upi', 'completed'),
(1, 1, 2, 40000, '2025-01-16', 'card', 'completed'),
(2, 2, 3, 70000, '2025-02-12', 'card', 'completed'),
(2, 2, 4, 30000, '2025-02-13', 'cash', 'pending'),
(3, 3, 5, 95000, '2025-03-08', 'upi', 'completed'),
(3, 3, 6, 50000, '2025-03-09', 'cash', 'completed'),
(4, 4, 7, 55000, '2025-04-22', 'bank_transfer', 'pending'),
(4, 4, 2, 42000, '2025-04-23', 'upi', 'completed'),
(5, 5, 3, 72000, '2025-05-15', 'card', 'completed'),
(6, 1, 4, 35000, '2025-06-18', 'upi', 'completed'),
(7, 2, 6, 48000, '2025-07-20', 'cash', 'completed'),
(8, 3, 8, 55000, '2025-08-29', 'upi', 'pending'),
(9, 5, 7, 53000, '2025-09-03', 'bank_transfer', 'completed'),
(10, 4, 5, 98000, '2025-10-08', 'card', 'completed'),
(11, 2, 2, 46000, '2025-11-13', 'upi', 'pending'),
(12, 1, 1, 64000, '2025-12-18', 'upi', 'completed');
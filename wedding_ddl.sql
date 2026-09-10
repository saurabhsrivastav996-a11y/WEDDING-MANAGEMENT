
-- DATABASE CREATION
CREATE DATABASE wedding_management;
USE wedding_management;

-- USER TABLE
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL,
    address TEXT
);

-- VENUE TABLE
CREATE TABLE Venue (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    capacity INT,
    cost_per_day DECIMAL(10,2)
);

-- THEME TABLE
CREATE TABLE Theme (
    theme_id INT AUTO_INCREMENT PRIMARY KEY,
    theme_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- GUEST TABLE
CREATE TABLE Guest (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(15),
    rsvp_status ENUM('invited', 'confirmed', 'declined') DEFAULT 'invited',
    meal_preference VARCHAR(50)
);

-- VENDOR TABLE
CREATE TABLE Vendor (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    service_type VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    rating DECIMAL(2,1),
    cost_estimate DECIMAL(10,2)
);

-- WEDDING TABLE (no foreign keys here)
CREATE TABLE Wedding (
    wedding_id INT AUTO_INCREMENT PRIMARY KEY,
    wedding_date DATE,
    budget DECIMAL(10,2),
    status ENUM('planned', 'ongoing', 'completed', 'cancelled') DEFAULT 'planned'
);

-- WEDDING_SUMMARY TABLE
CREATE TABLE Wedding_Summary (
    summary_id INT AUTO_INCREMENT PRIMARY KEY,
    wedding_id INT UNIQUE,
    total_guests INT,
    total_payments DECIMAL(10,2),
    completed_tasks INT,
    status_summary VARCHAR(255),
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id)
);

-- RELATIONSHIP TABLES

-- Wedding ↔ User (organized by)
CREATE TABLE Wedding_user (
    user_id INT,
    wedding_id INT,
    PRIMARY KEY (wedding_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id)
);

-- Wedding ↔ Venue (held at)
CREATE TABLE Wedding_venue (
    venue_id INT,
    wedding_id INT,
    PRIMARY KEY (wedding_id),
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id),
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id)
);

-- Wedding ↔ Theme (follows)
CREATE TABLE Wedding_theme (
    theme_id INT,
    wedding_id INT,
    PRIMARY KEY (wedding_id),
    FOREIGN KEY (theme_id) REFERENCES Theme(theme_id),
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id)
);

-- Wedding ↔ Guest (invites)
CREATE TABLE Wedding_guest (
    wedding_id INT,
    guest_id INT,
    PRIMARY KEY (guest_id),
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id),
    FOREIGN KEY (guest_id) REFERENCES Guest(guest_id)
);

-- Wedding ↔ Vendor (supplies) — many-to-many
CREATE TABLE Wedding_vendor (
    wedding_id INT,
    vendor_id INT,
    service_cost DECIMAL(10,2),
    service_status ENUM('booked', 'pending', 'completed') DEFAULT 'pending',
    PRIMARY KEY (wedding_id, vendor_id),
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

-- TASK TABLE
CREATE TABLE Task (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    wedding_id INT,
    vendor_id INT,
    task_name VARCHAR(100),
    assigned_to VARCHAR(100),
    deadline DATE,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    remark TEXT,
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

-- PAYMENT TABLE
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    wedding_id INT,
    venue_id INT,
    vendor_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_mode ENUM('cash', 'card', 'upi', 'bank_transfer'),
    status ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
    FOREIGN KEY (wedding_id) REFERENCES Wedding(wedding_id),
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);
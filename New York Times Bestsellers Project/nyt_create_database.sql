DROP VIEW IF EXISTS book_author;
DROP TABLE IF EXISTS lists;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS list_entries;

CREATE TABLE lists (
	list_id INT PRIMARY KEY NOT NULL,
    list_name VARCHAR(100) NOT NULL,
    frequency VARCHAR(10) NOT NULL);

CREATE TABLE publishers (
	publisher_id INT PRIMARY KEY NOT NULL,
    publisher_name VARCHAR(100) NOT NULL);
    
CREATE TABLE authors (
	author_id INT PRIMARY KEY NOT NULL,
    author_name VARCHAR(100) NOT NULL);
    
CREATE TABLE books (
	book_id INT PRIMARY KEY NOT NULL,
    title VARCHAR(100) NOT NULL,
    author_id INT NOT NULL,
    publisher_id INT NOT NULL);
    
CREATE TABLE list_entries (
	list_entry_id INT PRIMARY KEY NOT NULL,
    date_published DATE NOT NULL,
	book_id INT NOT NULL,
    author_id INT NOT NULL,
    publisher_id INT NOT NULL,
    contributor VARCHAR(100), 
    list_id INT NOT NULL, 
    weeks_on_list INT,
    age_group VARCHAR(50));


# book_author view used for easy querying 
DROP VIEW IF EXISTS book_author ;

CREATE VIEW book_author AS 
	(SELECT
		a.author_id,
        b.book_id,
        b.title,
        a.author_name
    FROM authors a
	LEFT JOIN books b ON a.author_id = b.author_id);
 
#Number of list entried
SELECT
	COUNT(list_entry_id) AS 'Number of list entries'
FROM list_entries;

# Number of books with multiple authors
SELECT
	COUNT(book_id) AS 'Books with multiple authors'
FROM book_author
-- LEFT JOIN books b ON a.author_id = b.author_id
WHERE author_name LIKE '% and %' or author_name LIKE '% with %';

SELECT 
	title,
    author_name
FROM book_author
WHERE author_name LIKE '% and %' or author_name LIKE '% with %';

# Books that start with 'The' in the title
SELECT 
	title
FROM books
WHERE LOWER(title) LIKE 'the%';

# Authors with more than 1 'New York Times bestseller'
SELECT
    author_name,
    author_id,
	COUNT(book_id) AS 'Number of books'
FROM book_author
GROUP BY author_id, author_name
HAVING COUNT(book_id) > 1
ORDER BY COUNT(book_id) DESC;

#Danielle Steel's books
SELECT
	title
FROM books
WHERE author_id = 32;

 # Window function
SELECT
	author_name,
    title,
	COUNT(book_id) OVER (PARTITION BY author_id) AS total_books
FROM book_author
ORDER BY total_books DESC;



#Author names where the author was the sole writer
SELECT *
FROM authors
WHERE author_name NOT LIKE '% and %' AND author_name NOT LIKE '% with %';


#Which publishers have the most books
SELECT
	p.publisher_name,
    COUNT(book_id) AS 'Number of books'
FROM books b
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
GROUP BY p.publisher_id, p.publisher_name
ORDER BY COUNT(book_id) DESC;

SELECT
	b.title,
	p.publisher_name
FROM books b
LEFT JOIN publishers p ON b.publisher_id = p.publisher_id
WHERE LOWER(p.publisher_name) LIKE 'little%';


SELECT 
	author_name,
    title
FROM (
SELECT
	author_name,
    title,
	COUNT(book_id) OVER (PARTITION BY author_id) AS total_books
FROM book_author
ORDER BY total_books DESC) AS author_total_books
WHERE total_books > 1;

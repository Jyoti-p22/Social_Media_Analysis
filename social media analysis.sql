use social_media;
show tables;


select * from users;
SELECT * FROM login;
SELECT * from comments;
select * from post;

-- 1) What is the average number of posts per user?
select avg(p.user_id) as 'avg_post', u.user_id 
from post p
inner join users u
on p.post_id = u.user_id
group by u.user_id;

-- 2) location of user
select * from post where user_id limit 10;

-- 3) most followed hashtags
SELECT hashtag_name AS 'Hashtags', COUNT(hashtag_follow.hashtag_id) AS 'Total Follows' 
FROM hashtag_follow, hashtags 
WHERE hashtags.hashtag_id = hashtag_follow.hashtag_id
GROUP BY hashtag_follow.hashtag_id
ORDER BY COUNT(hashtag_follow.hashtag_id) DESC LIMIT 5;

select * from post_tags;

-- 4) most used hashtags
SELECT h.hashtag_name AS 'Trending Hashtags', COUNT(p.post_id) AS 'Times Used'
FROM hashtags h
JOIN post_tags p ON h.hashtag_id = p.hashtag_id
GROUP BY h.hashtag_name
ORDER BY COUNT(p.post_id) DESC;

-- 5) most inactive user
SELECT user_id, username AS 'Most Inactive User'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM post);


-- 6) display location of user from maharastra ,delhi,agra

SELECT user_id,location 
FROM post 
WHERE location IN ('maharashtra');

SELECT count(*) from post;

-- total 100 post done by users in our database
-- location is not mentioned in a proper way 

-- 7) average post per user

SELECT * FROM post;

SELECT round(count(post_id)/count(DISTINCT user_id),1) AS 'avg post per user' 
FROM post;

-- on an average 2 posts are done by each user

-- 8) display users who posted 5 or more than 5 post

SELECT * FROM post;

SELECT user_id,count(user_id) as post_count
FROM post
GROUP BY 1 HAVING post_count>=5
ORDER BY 2 DESC;

-- Total 4 users have posted 5 or more than 5 post

-- 9) display users with 0 comment

SELECT * FROM users;
SELECT * FROM comments;

SELECT user_id,username 
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);

-- just one user has not commented 

-- 10) display users who dont follow anybody
SELECT * FROM follows;

SELECT user_id,username as 'not follower'
FROM users
WHERE user_id NOT IN (SELECT DISTINCT follower_id FROM follows);

-- there is no such user who don't follow anybody

-- 12) display no of comment by each user
use social_media;
select * from comments;

select user_id,count(user_id) as count 
from comments
group by 1 
ORDER BY 2 DESC ;

select user_id,count(user_id) as count from comments
group by user_id ORDER BY count DESC ;

-- 13) dispaly users with maximum post
SELECT user_id,count(user_id) as post_count
FROM post
GROUP BY 1
ORDER BY 2 DESC LIMIT 1;

-- user_id 37 has done maximum post

-- 14) display no of login per user

SELECT * FROM users;
SELECT * FROM login;

SELECT user_id,username,count(username) as 'no of login'
FROM users
natural join login
GROUP BY 1 ORDER BY 3 DESC;


-- 15) longest caption in a post
SELECT * FROM post;

SELECT user_id,caption,LENGTH(caption) as caption_length
FROM post
ORDER BY 3 DESC LIMIT 1;

-- 16) any specific word in comment

SELECT * FROM comments WHERE comment_text regexp 'good|beautiful';

-- 17) followers>40

SELECT * FROM follows;

SELECT followee_id,count(follower_id) as count
FROM follows
GROUP BY followee_id HAVING count>=40
ORDER BY 2 DESC;

-- 18) display most used hashtag
SELECT * FROM hashtags;
SELECT * FROM post_tags;

SELECT hashtag_name AS 'Trending Hashtags', 
    COUNT(post_tags.hashtag_id) AS 'Times Used'
FROM hashtags,post_tags
WHERE hashtags.hashtag_id = post_tags.hashtag_id
GROUP BY post_tags.hashtag_id
ORDER BY COUNT(post_tags.hashtag_id) DESC LIMIT 10;

-- 19) most inactive user ..post concept

SELECT * FROM post;
SELECT * FROM users;

SELECT user_id,username as 'inactive user' from users 
WHERE user_id NOT IN (select user_id from post);


select distinct user_id from post;

-- 20) user who commented on every post(CHECK FOR BOT)

SELECT * FROM users;
SELECT * FROM comments;

SELECT username, Count(*) AS num_comment 
FROM users 
INNER JOIN comments ON users.user_id = comments.user_id 
GROUP  BY comments.user_id
HAVING num_comment = (SELECT count(distinct post_id) FROM comments); 
SELECT count(distinct post_id) FROM comments;


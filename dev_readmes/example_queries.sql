-- UPDATE users SET money = money + 30, 
-- 	info = CONCAT(info, ', manually entering 30 pts for bugreport #5 - 3/2/17'), 
-- 	news = CONCAT(news, "\nThanks for reporting bug #5. We have awarded you 30 points")
--     WHERE id=6142; # give user id=6142 money, and log it in the user's /info/ field
    # make sure to run the same query with SELECT first to check which user you're selecting


 # get user infographics
-- SELECT id, gender,age,device,OS,time_spent,spending,motivation,game_genre,nation,paying_incentive,fav_game,num_games from users WHERE info LIKE "%survey11%";


-- SELECT * from users WHERE email = "test@test.com";
-- UPDATE users SET money = 0 WHERE email = "test@test.com";

-- SELECT id, email, money, info, news from users WHERE email = "test@test.com"; # only get needed fields
-- SELECT * from users WHERE info LIKE "%survey11%"; # get all users whose info include the string "survey11" -- % means wildcard


-- SELECT * from users WHERE email LIKE "%@willowflare.com"; # get all emails that end with @willowflare.com
-- 



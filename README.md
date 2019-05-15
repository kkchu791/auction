# README

Backend App - Auction

Demo: https://robot-auction.herokuapp.com/

Info

```
ruby '2.6.3'
rails  '5.2.3'
```

Directions for running this application:
```
git clone https://github.com/kkchu791/auction.git
bundle install
rake db:migrate
rake db:seed
rails s

```


Questions

1. How do you avoid problems if multiple users bid at exactly the same time, while preserving performance as much as possible?

With a lock on the transaction, we can ensure that only one person can place a bid at a time. If users bid at the same time, the transactions will be handled first in first out.

One question I have is do we have to keep a record of all the bids, or do we only care about the highest bid at the time? If thousands of people bid at once, we can collect all the bids, sort them, and take the highest bid and write that to the DB. This will preserve performance and save space in our database.

2. What needs to be locked and with what granularity?

The transaction of returning points to the previous highest bidder and removing points from the new highest bidder needs to be locked in a transaction block.
This way we can ensure if anything should go wrong, the two objects will be reverted back to its original state. No points will be unexpectedly given or taken away from users.

```
with_lock(true) do
    Return_highest_bidder_points # return previous highest bidders points
    user.subtract_points!(points) # take away from new highest bidders points
end
```

3. What are strategies in detecting and mitigating race conditions?

We will add locks on the transactions so no race conditions can occur in the removal or adding of points. Only one bid will be processed at a time.

If we are getting many bids at a time, we will start a queue first, and process them one by one, first in and first out.

4. How will we notify users if they've been outbid?

We can notify them through texts, emails, and push notifications (depending if we have a mobile app) as soon as they are outbid.

We can also implement a listener to each user's auction item. Anytime a user is outbid, she can be notified through a flash message if they are still browsing through the web app.

5. Any questions would you need answered before you could build this out? Is anything here inadequately specified?

I was wondering how users get their initial points in the beginning? Is it something they can buy more of or generated when they sign up?

Also, who are our customers, and are they just US based or global?

Will this app be available for mobile as well?

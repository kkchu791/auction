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

1. How do you avoid problems if multiple users bid at exactly the same time?

With a lock on the transaction, we can ensure that only one person can place a bid at a time. If users bid at the same time, the transactions will be handled first in first out.

2. What needs to be locked and with what granularity?

The transaction of returning points to the previous highest bidder, removing points from the new highest bidder and validations that the current bidder has enough points to make a bid need to be locked in a transaction block.
This way we can ensure if anything should go wrong, the two objects will be reverted back to its original state. No points will be unexpectedly given or taken away from users.

```
with_lock(true) do
    validate_points(user, points) # validations user has enough points and users bid is high enough
    Return_highest_bidder_points # return previous highest bidders points
    user.subtract_points!(points) # take away from new highest bidders points
end
```

3. What are strategies in detecting and mitigating race conditions?

Locks will ensure one bid will be processed at a time.

4. How will we notify users if they've been outbid?

We can notify them through texts, emails, and push notifications (depending if we have a mobile app) as soon as they are outbid.

5. Any questions would you need answered before you could build this out? Is anything here inadequately specified?

I was wondering how users get their initial points in the beginning? Is it something they can buy more of or generated when they sign up?

Also, who are our customers, and are they just US based or global?

Will this app be available for mobile as well?

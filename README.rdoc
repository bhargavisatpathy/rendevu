== Rendevu - Think, Plan & Hangout

This is Bhargavi Satpathy's individual project for the third module at the Turing School of Software and Design.

Full project specifications are available here: http://tutorials.jumpstartlab.com/projects/individual_project.html

### Pitch

It's an app for group of people to conveniently and quickly choose time and place to meet.

### Problem

When it is more than a handful of people trying to arrange a get together it's not only time-consuming but also hard to decide on a time and place.

### Solution

The app will allow these group of people to rank and collectively pick time and place for a meet up or hang out

### Target Audience

Everyone can with a connected device can use it.

### Integrations

* OAuth provider used - Facebook for login
* API for SMS integration - Twilio 
* API for venue lookup - Foursquare

This project is in production at http://rendevu-here.herokuapp.com/

### Developer Information

To get this to run locally, you need to run the following:

bundle install
git push heroku master
heroku pg:reset
heroku run rake db:migrate



# Car Rental App
This Repo hosts the code for Car Rental App based on Ruby and Rails as a part of OODD course.

### Production App Link
https://hidden-savannah-66808.herokuapp.com/

### Default Super Admin
<dd><b>username:</b> admin@car.com</dd>
<dd><b>passsword:</b> password</dd>

### Default admin
<dd><b>username:</b> admin1@car.com</dd>
<dd><b>passsword:</b> password</dd>

<dd><b>username:</b> admin2@car.com</dd>
<dd><b>passsword:</b> password</dd>

### Default User
<dd><b>username:</b> user1@car.com</dd>
<dd><b>passsword:</b> password</dd>

<dd><b>username:</b> user2@car.com</dd>
<dd><b>passsword:</b> password</dd>

### General Functionality:

* Super Admins can add other Super admins, Admins and Users. Super admin can also edit other super admins, admins or users and delete admins and users but can't delete Super admins. Other than this, SUper admin also has all the functionality of admin.
* Admin can add, edit or delete other admins or users. Admin can also edit or add new bookings on behalf of Users. Can also add, edit and delete cars.
* User can register and edit his details. Admin can search cars based on filters and Book a car. User is allowed to have only 1 booking at a time.

### Site Navigation Guide 

* On the login page, click on “Sign Up”
* Give your name, email address, password, confirm your password and click on Sign Up button
* Once you log in, you will see a set of links depending on whether you are a user, admin or super admin . Functionality for each of these links explained below
* After logging in, each page will have a Home and Logout button on top or you can click on Car Rental App header to reach back to the home screen

###Super Admin and Admin:

Login with admin credentials (Ex: email: 'admin@car.com', password: 'password')

● Edit Profile -> To edit personal details
● Manage SuperAdmins -> See a list of Super admins and add new Super admin
● Manage Admins -> See all admins and options to edit, delete or add new admins
● Manage Users -> See all Users and options to edit, delete or add new users along with links to see booking history of User
● Manage Cars -> To see, edit, add or delete new cars. Also can see the Bookings and status of the car inside this. Admin can also reserve a car for a user. Can select cars based on filters.
● Manage Bookings -> See list of all the Bookings with the options to edit the status of a Booking (Timing), Check out Cancel or Return the car
```

**Validations**

●  SuperAdmin cannot delete himself or other Super admins.
●  Admin cannot delete a Car or a User already having a reservation or car in CheckedOut status.
●  Can not book a car more than 7 days in advance and booking duration should be between 1 hour and 10 hours
●  Can return a car, Checkout a car or cancel booking
```

## Development
To run the app locally, follow these steps:

### Install gems
```
bundle install --without production
```

### Complete Database Migrations
```
rails db:migrate
```

### Add pre-configured users
```
rails db:seed
```

### Run server
```
rails server
```

Your app will run on http://localhost:3000
```

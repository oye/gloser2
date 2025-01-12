# Gloser 2

## Description
Web application written in Ruby on Rails to create assignment to practice tranlation of words and phrases. An assignment can contain any number of translations. A pulic code(url) to the assignment can be shared by the creator for others that want to do the assignment. 

There are three levels for an assignment.
  - Level 1 - Select the correct translation
  - Level 2 - Write the correct translation with the solution scrambled.
  - Level 3 - Write the correct translation.

For level 1 to be available when doing the assignment, 3 wrong translations have to be entered for each translation. These will be used as the wrong option when selecting the correct translation.

Live site: https://gloser.guttvik.no

## Ruby version
- 3.4.1

## Rails version
- 8.0.1

## Database initialization
- Run `rails db:create` to create the database.
- Run `rails db:migrate` to run migrations.

## How to run the test suite
- Run `rails test` to run the test suite.

## Scheduled jobs
- Daily job configured in config/reccuring.yml to delete assignments older than one month.

## License
- This project is licensed under the MIT License.

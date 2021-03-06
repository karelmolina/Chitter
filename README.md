
# Welcome to Chitter

## Configuration

* Please read over the `environment.rb` file and complete Application Name and Author Name sections with the appropriate information. This file houses all our dependencies.

* create your ```.env``` file with two variables DATABASE and TEST_DATABASE with the name of the databases you create.

* setup the databases with the files in db_migration.

## Execute

* you can run with ```rackup``` or ```ruby Chitter.rb```

## User Stories

```
As a Maker
So that I can let people know what I am doing  
I want to post a message (peep) to chitter
```
```
As a maker
So that I can see what others are saying  
I want to see all peeps in reverse chronological order
```

```
As a Maker
So that I can better appreciate the context of a peep
I want to see the time at which it was made
```

```
As a Maker
So that I can post messages on Chitter as me
I want to sign up for Chitter
```

```
As a Maker
So that only I can post messages on Chitter as me
I want to log in to Chitte
```

```
As a Maker
So that I can avoid others posting messages on Chitter as me
I want to log out of Chitter
```

## Testing

All your tests are housed in the `spec` folders.

try it:

`bundle exec rake test`

OR

`bundle exec rake spec`


Refer to the [Active Record Migrations Guide](http://guides.rubyonrails.org/active_record_migrations.html) to help you through the assignment.

Remember to **commit your changes after each change you make to the database!**


### Your First Migration

Your boss tells you the company needs to keep track of the various parts they have on inventory. For each part, they need to know its:

- name
- manufacturer
- cost

You think to yourself, "Easy, peasy."

#### How to approach this problem:

- Take a look inside of the `/db` folder of this assignment. Be sure to note what file(s) currently exist.

- Create a migration for the `parts` table. Each part will have a name, manufacturer and cost:

```bash
$ rails generate migration CreateParts name:string manufacturer:string cost:decimal
```

- Take another look inside `/db` and also look in `/db/migrate`. Note the new file and folder created from the migration generation command.

- Look at the `/db/migrate/<time_stamp>_create_parts_table.rb` migration file.

- Run your migration:

```bash
$ rails db:migrate
```

- Take another look inside `/db`. Note the files that were created from running your migration.

- Look at `/db/schema.rb`. This file is autogenerated and updated whenever you run the `db:migrate` command. You should never update this file directly, but rather create a new migration every time you want to change the structure of your database.

- Look at your actual database:

```
# Login to the db:
$ rails db

# Look at the tables that exist:
sqlite> .tables

# Look at the structure of the parts table you just created:
sqlite> .schema parts

# Exit the database client by pressing ctrl + d
```

- It's important to ensure your migrations are reversible: that is, make sure each migration can be undone. This ensures the integrity of the schema and provides an opportunity to quickly back-out of a breaking change in production. This is done by rolling back and re-running your migrations: if you can do this with no errors, you know your new migration is reversible. Rollback your migration now and note what changed in `schema.rb`:

```bash
$ rails db:rollback
```

- Run the migration one more time:

```bash
$ rails db:migrate
```


### Adding Quantity to Parts

Your boss saunters in smelling like stale french fries and last week's dirty laundry. He growls, "Didn't I already tell you we need to keep track of the quantity of each part?  What's the point of a parts database without knowing how many parts we have?"

#### Your task: Create a migration that adds quantity

This time, instead of generating all the details of the migration on the command line, we'll just generate the file without providing details, and then edit the file manually. It's not uncommon to generate migrations this way.

```bash
$ rails generate migration AddQuantityToParts
```

Edit the file just created and insert the details of the migration:

```ruby
class AddQuantityToParts < ActiveRecord::Migration[5.0]
  def change
    change_table :parts do |t|
      t.integer :quantity
    end
  end
end
```

Now: 

1. Use the `rails db:migrate:status` command to check the current status of your migrations. "up" means a migration has been applied, "down" means it hasn't.

1.  Run the migration.

1. Use the `rails db:migrate:status` command again to check the current status of your migrations.

1.  Look at `schema.rb`.

1.  Use `rails db` to look at your table.

1.  Rollback your migration to ensure rollback is working properly.

1. Use `rails db:migrate:status` to check the current status of your migrations.

1.  Run your migration again.

1. Use `rails db:migrate:status` to check the current status of your migrations.

1.  Look at the content of the `schema_migrations` table in the `db`. Rails uses this specially generated table to keep track of what migrations it has already run:

```sql
SELECT * FROM schema_migrations;
```


### Creepy Party Invitation

Your boss is having a big party and he's decided to use the company's high-powered computer to keep track of all his guests. He's also asked you to keep track of some rather personal information. Your not sure if this is ethically a good thing to do, but you decide to stay mum in hopes for a promotion.

#### Your Task: Create a migration to create a `party_guests` table that keeps track of the guest details:

- first name
- last name
- dietary restrictions
- salary
- number of kids
- vulnerabilities
- illnesses
- medication
- voting preferences

Because this migration involves so many details, use the `rails generate migration <migration name>` command to generate the migration file only, and then populate the details inside of that migration file using your editor.

Go through the cycle of:

1. Running the migration
2. Noting the changes in the `schema.rb`
3. Noting the changes to the database using `rails db`
4. Ensuring you can properly rollback and re-run the migration.



### New Locations Migration

Your boss comes in hungover from his big party last night. He's in a particularly foul mood. The company's expanding locations, and he just found out he didn't get the promotion to Regional Location Director he was hoping for.

#### Your Task

1. Create a migration to create a locations table. Your boss didn't give you any more details about each location, so it's up to you to decide what fields should be added.

1. Go through the cycle of checking in on `schema.rb`, `rails db`, rolling back and re-running the migration.


### Obscuring the Party Guests Table

The company's IT department has noticed that there's an unusual amount of computation required by the database. Your boss comes in more disheveled than usual.

> "You have to hide that party list!"
>
> "What's the magic word?" you ask.
>
> "Do it!" he yells.

You shrug. It's not 'please' but it'll do.

#### Your Task

1. Create a migration that changes the table name of `party_guests` to `widgets`.

2. You know the drill: `schema`, `rails db`, rollback, re-migrate.



### Quantity Should Track Portions of Parts

The next day your boss storms in demanding to know why you're tracking the quantity as an integer? What if half a part is left? You sigh and agree to fix it.

#### Your Task: Change the `quantity` column from an `integer` to `decimal` using `change_column`. 

Most migrations are **reversible**, meaning that you can migrate **up**, that is, advance the structure of your database, and go **down**, that is, restore the previous structure of your database (aka `rollback`). 

However, the `change_column` by itself is an irreversible method. This is because you're changing the `quantity` column to a `decimal` type, and not specifying anywhere that it was previously an `integer` type.

To make your migration reversible, instead of a `change` method, you can use `up` and `down` methods:

So instead of:

```
def change
  # method to change the column type
end
```

You would put:

```
def up
  # method to migration the column type forward
end

def down
  # method to rollback the column type to its previous state
end
```

See the [rails guide](http://edgeguides.rubyonrails.org/active_record_migrations.html#using-the-up-down-methods) for more information. Note that the example in the rails guide is much more complex than what you'll need. You'll just need a `change_column` statement in both the `up` and `down` methods.

When doing this task, you should:

- check in on `schema.rb` to see the current database structure both before and after the migration

- use `rails db` both before and after the migration and look at the schema of the table you're modifying

- be sure you can `migrate`, `rollback`, and `migrate` again

Going forward, for each future migration, ensure you do this 'cycle' so you're aware of what's happening to your database and that your migrations run 'clean' (i.e. rolling back and re-migrating works fine). Also be sure the check the schema by looking at `schema.rb`, using `rails db:migrate:status` and by viewing the tables' schemas inside the `rails db` console.

### Change the Locations Table

Your boss has a scheme to mess up the locations table with the hope the Regional Location Director will be sacked.

#### Your Task: Make it so your `locations` table only tracks two things: `city` and `weather`.


### Delete the Widgets Table

Your boss runs in, wild-eyed and paranoid. "We're in trouble now," he says, "Our department's going to take the blame for all the important location table information that's gone missing. They're going to want to look through our database." He tells you to create a new migration to restore the locations table back to its previous structure. He also tells you to immediately delete the old party invitations table which is currently named widgets.

#### Your Tasks: 

1. Create a new migration that restores the `location` table to how it used to be structured.

1. Delete the `widgets` table using a migration.



### The End

Commit and submit your code.

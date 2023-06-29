# Steps for updating skills_dict

Currently, if an item needs to be manually changed in the skills dictionary, it often needs to be manually reflected in the database too.

- First, update skills_dict.json, changing any keys and values required. E.g "Intellij IDEA" > "Intellij"
- Make sure that the changes are reflected in the repo by pushing up the changes. This will also deploy the new skills_dict.json to the azure blob container.
- If you are only **_altering the values_** inside the arrays for a key, you do not need to do anything in the database, as these values are not present there, only the keys are.
- If you are only **_adding a new key + value_**, this will be reflected in the database automatically.
- If you have **_altered an existing key or removed an existing key_**, you must reflect this change in the database. You can do this with azure data studio, or any other means of querying the database.

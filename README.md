# spregen (alpha)
Sprint Report Generator

#### Configuration
  - Get your API keys from [http://trello.com/app-key](http://trello.com/app-key)  
  - Visit the URL [trello.com/1/authorize], with the following GET parameters:
   - **key**: the API key you got in step 1.
    - **response_type**: "token"
    - **expiration**: "never" if you don't want your token to ever expire. If you leave this blank, your generated token will expire after 30 days.
  The URL will look like this:  
  https://trello.com/1/authorize?key=YOURAPIKEY&response_type=token&expiration=never  
  You should see a page asking you to authorize your Trello application. Click "allow" and you should see a second page with a long alphanumeric string. This is your member token.

#### Lists and Cards configuration
 - The name of trello lists must contain following strings: [TODO], [DOING], [Q.A.], [DONE].
 - Bug cards must contain "[Bug]" in name.
 - To skip a card from report, you must add label "Skip Report" to card.
 - Any link (github PR, etc) must be the first line on card description.

#### Generating Report
```
ruby generate.rb [board-name]
```

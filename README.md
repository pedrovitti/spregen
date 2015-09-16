# Welcome to spregen (alpha)
Spregen generates Sprint Reports using markdown based on your Trello board.

#### Install
  ```bash
gem install spregen
  ```

#### Configuration
  - Get your API keys from [http://trello.com/app-key](http://trello.com/app-key)
  - Visit [https://trello.com/1/authorize?key=YOURAPIKEY&response_type=token&expiration=never](https://trello.com/1/authorize?key=YOURAPIKEY&response_type=token&expiration=never) replacing YOURAPIKEY by the value from previous step. Authorize the application and get your generated Member Token.
  - run ```spregen configure``` and enter your API Key and Member Token.

#### Usage
  ```bash
spregen generate 'My board'
  ```
  This will generate the report file in the current dir. Open your favorite text editor and be happy :D

#### Conventions
 - The name of trello lists must contain following strings: [TODO], [DOING], [Q.A.], [DONE].
 - Bug cards must contain "[Bug]" in name.
 - To skip a card from report, you must add label "Skip Report" to card.
 - Any link (github PR, etc) must be the first line on card description.

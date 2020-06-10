[![hire-badge](https://img.shields.io/badge/Consult%20/%20Hire%20Glory-Click%20to%20Contact-brightgreen)](mailto:consult.glodave99@gmail.com) [![Twitter Follow](https://img.shields.io/twitter/follow/gloweeeyah?label=Follow%20gloweeeyah%20on%20Twitter&style=social)](https://twitter.com/gloweeeyah)

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]

# Inspiration-Bot 

This is a Ruby based Telegram bot that gives inspiring messages on request from the user with notifications and reminders to document their thoughts. It is a church bot that was built to aid church members to remember the word of God. This will remind them daily of their faith and testimonies to keep them going. I hope to make it permanently running for use.

[![Product Name Screen Shot][product-screenshot]](screenshot.gif)

## Features

1. This bot provides an inspiring word to the user on request.

2. The user can choose to write/create their thoughts, view or delete them.

3. It gives scheduled reminders every 12 hours which is twice daily. The three reminders are:

    - An inspiring word
    - A reminder to document a testimony.
    - A reminder of their testimony entry at random.

### To Check it out

1. Visit [The GLA Buddy](https://t.me/TheGlaBot) on Telegram.

2. Send the '/help' message to the bot for a list of functional details. Here is a list of available commands:

    - /start - to enable notifications
    - /stop - to stop notifications
    - /write - to make an entry
    - /view - to view all your entries
    - /delete - to delete an entry
    - /cancel - to cancel writing or deleting
    - /word - to recieve an inspirational word

## Demo

You can see it working [here](https://t.me/TheGlaBot)

## Built With

- Ruby
- Rspec(code testing)
- Rubocop(code linting)

## Getting Started

To get a local copy up and running follow these steps:

### Prerequisites

- Ruby [installed](https://www.ruby-lang.org/en/documentation/installation/) on local machine
- Forking the project
- Cloning the project to your local machine
- `cd` into the project directory
- Install the gems in the Gemfile by using the ```bundle install``` in the root folder terminal
- After installing the gems, get your api key from Telegram's [BotFather](https://core.telegram.org/bots) from the [Telegram API docs](https://core.telegram.org/bots) and create a .env file in your root folder and on the first line place:
```API_KEY= 'YOUR-TELEGRAM-API-KEY'```

### Usage

- Fork/Clone this project to your local machine.
- Unit tests were built in Rspec, test using ```rspec``` in root directory of the project.

## Author

👤 **Glory David** 
    
- LinkedIn: [Glorydavid](https://www.linkedin/glory-david) 
- GitHub: [@glowreeyah](https://github.com/glowreeyah)
- E-mail: glodave99@gmail.com
- Twitter: [@gloweeeyah](https://twitter.com/gloweeeyah)

## Contribution
Contributions, issues and feature requests are welcome! Start by:
    * Forking the project
    * Cloning the project to your local machine
    * `cd` into the project directory
    * Run `git checkout -b your-branch-name`
    * Make your contributions
    * Push your branch up to your forked repository
    * Open a Pull Request with a detailed description to the development branch of the original project for a review

## Show your support

Give a ⭐️ if you like this project!

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* Ruby [Docs](https://ruby-doc.org/core-2.6.5/Enumerable.html)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/glowreeyah/Inspiration-Bot.svg?style=flat-square
[contributors-url]: https://github.com/glowreeyah/Inspiration-Bot/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/glowreeyah/Inspiration-Bot.svg?style=flat-square
[forks-url]: https://github.com/glowreeyah/Inspiration-Bot/network/members
[stars-shield]: https://img.shields.io/github/stars/Inspiration-Bot.svg?style=flat-square
[stars-url]: https://github.com/glowreeyah/Inspiration-Bot/stargazers
[issues-shield]: https://img.shields.io/github/issues/Inspiration-Bot.svg?style=flat-square
[issues-url]: https://github.com/glowreeyah/Inspiration-Bot/issues
[product-screenshot]: screenshot.gif

## 📝 License

The project is licensed under [MIT](LICENSE).

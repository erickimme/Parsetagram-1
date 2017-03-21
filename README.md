# Project 6 - *Parsetagram*

**Parsetagram** is a photo sharing app using Parse as its backend.

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [X] Show the username and creation time for each post
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [X] User Profiles:
   - [X] Allow the logged in user to add a profile photo
   - [X] Display the profile photo with each post
   - [X] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:

- [X] Implemented AutoLayout to each ViewController
- [X] Implemented User Post "Time line"
- [X] Add profile pictures to each post

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Implementing sliding feature when keyboard pops up
2. Better way to implement the parsing of the posts

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![alt text](https://github.com/ryujimano/Parsetagram/blob/master/ParsetagramDemo.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

One challenge that I faced while developing this app was the parsing of each of the posts. I was able to make the refreshing of the home view a little better, but it still refreshes unnecessarily when the view appears.

## License

    Copyright 2017 Ryuji Mano

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

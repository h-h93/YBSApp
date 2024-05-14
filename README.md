# YBSApp
YBS take home test

Welcome to YBSApp! This project is a modern image browsing application built using Swift. The app allows users to search for and display images from Flickr based on user input, providing a seamless and intuitive browsing experience. Below are the key features and architectural choices that make this app unique.

Features

MVC Architecture: The app is structured using the Model-View-Controller (MVC) design pattern, ensuring a clear separation of concerns and maintainable code.

Async/Await: Utilises Swift's async/await syntax for efficient and readable asynchronous code execution, enhancing performance and responsiveness.

Compositional Layouts: The search screen employs compositional layouts to handle a vast array of images, ensuring a dynamic and visually appealing user interface.

Flow Grid Layout: Displays user images in a flow grid layout, providing a structured yet flexible image presentation.

Header View for Image Details: When a user taps on an image, a header view appears showing the profile picture, username, and profile description of the image owner. This view is interactive; clicking on the profile image, username, or description navigates to the user's profile, much like Instagram.

Detailed Image Information: Image details are displayed in a UITableView, allowing users to easily access the information they need.

Search Bar Functionality: Includes a search bar that performs searches on Flickr for images based on user input, supporting both keyword and tag-based searches.

Installation

To get started with YBSApp, clone the repository and open the project in Xcode.

bash
Copy code
git clone https://github.com/h-h93/YBSApp.git
cd YBSApp
open YBSApp.xcodeproj
Usage

Search for Images: Use the search bar to enter keywords or tags. The app will fetch and display relevant images from Flickr.

Browse Images: Explore images displayed using a compositional layout for a visually engaging experience.

View Image Details: Tap on an image to view its details in a header view. This includes the profile picture, username, and profile description of the image owner.

Navigate User Profiles: Click on the profile picture, username, or profile description in the header view to navigate to the user’s profile page.

Detailed View in UITableView: Image details are organised and displayed in a UITableView for easy access.

Contributing

Contributions are welcome! If you have suggestions for improvements or encounter issues, feel free to open an issue or submit a pull request.

Fork the repository.
Create your feature branch (git checkout -b feature/YourFeature).
Commit your changes (git commit -am 'Add some feature').
Push to the branch (git push origin feature/YourFeature).
Create a new Pull Request.
License

This project is licensed under the MIT License. See the LICENSE file for details.

Thank you for using YBSApp! We hope you enjoy browsing and searching for images with ease. If you have any questions or feedback, please don't hesitate to reach out.

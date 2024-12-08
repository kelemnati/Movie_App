class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contetns = [
  UnbordingContent(
    image: 'assets/images/video-player.png',
    title: 'Unleash Entertainment',
    discription:
        'Dive into an extensive library of movies and shows. Explore genres, classics, and trending hits. Entertainment personalized for you.',
  ),
  UnbordingContent(
    image: 'assets/images/video-camera.png',
    title: 'Discover Blockbusters',
    discription:
        'Catch the latest blockbusters and all-time favorites. Stream instantly or plan your next watch. The magic of cinema, now in your pocket.',
  ),
  UnbordingContent(
    image: 'assets/images/movie.png',
    title: 'Cinema Anywhere',
    discription:
        'Enjoy seamless streaming anytime, anywhere. Save your favorites and track new releases. Your next movie night starts here.',
  ),
];

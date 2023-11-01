class User {
  final String userId;
  final String displayName;
  final String profileUrl;
  final String userName;
  final String email;
  final String gender;
  final String age;
  final String job;
  final String introduction;
  final String favoriteMenu;
  final String trainingTimes;
  final String tournamentResults;

//<editor-fold desc="Data Methods">
  const User({
    required this.userId,
    required this.displayName,
    required this.profileUrl,
    required this.userName,
    required this.email,
    required this.gender,
    required this.age,
    required this.job,
    required this.introduction,
    required this.favoriteMenu,
    required this.trainingTimes,
    required this.tournamentResults,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          profileUrl == other.profileUrl &&
          userName == other.userName &&
          email == other.email &&
          gender == other.gender &&
          age == other.age &&
          job == other.job &&
          introduction == other.introduction &&
          favoriteMenu == other.favoriteMenu &&
          trainingTimes == other.trainingTimes &&
          tournamentResults == other.tournamentResults);

  @override
  int get hashCode =>
      userId.hashCode ^
      displayName.hashCode ^
      profileUrl.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      age.hashCode ^
      job.hashCode ^
      introduction.hashCode ^
      favoriteMenu.hashCode ^
      trainingTimes.hashCode ^
      tournamentResults.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' userId: $userId,' +
        ' displayName: $displayName,' +
        ' profileUrl: $profileUrl,' +
        ' userName: $userName,' +
        ' email: $email,' +
        ' gender: $gender,' +
        ' age: $age,' +
        ' job: $job,' +
        ' introduction: $introduction,' +
        ' favoriteMenu: $favoriteMenu,' +
        ' trainingTimes: $trainingTimes,' +
        ' tournamentResults: $tournamentResults,' +
        '}';
  }

  User copyWith({
    String? userId,
    String? displayName,
    String? profileUrl,
    String? userName,
    String? email,
    String? gender,
    String? age,
    String? job,
    String? introduction,
    String? favoriteMenu,
    String? trainingTimes,
    String? tournamentResults,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      profileUrl: profileUrl ?? this.profileUrl,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      job: job ?? this.job,
      introduction: introduction ?? this.introduction,
      favoriteMenu: favoriteMenu ?? this.favoriteMenu,
      trainingTimes: trainingTimes ?? this.trainingTimes,
      tournamentResults: tournamentResults ?? this.tournamentResults,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'displayName': this.displayName,
      'profileUrl': this.profileUrl,
      'userName': this.userName,
      'email': this.email,
      'gender': this.gender,
      'age': this.age,
      'job': this.job,
      'introduction': this.introduction,
      'favoriteMenu': this.favoriteMenu,
      'trainingTimes': this.trainingTimes,
      'tournamentResults': this.tournamentResults,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      profileUrl: map['profileUrl'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      age: map['age'] as String,
      job: map['job'] as String,
      introduction: map['introduction'] as String,
      favoriteMenu: map['favoriteMenu'] as String,
      trainingTimes: map['trainingTimes'] as String,
      tournamentResults: map['tournamentResults'] as String,
    );
  }

//</editor-fold>
}
class Patient {
  final String patientIdentifier;
  final String first_NAME;
  final String last_NAME;
  final String email;
  final String phone_NUMBER;
  final String birth_DATE;
  final String gender;

  Patient({
    required this.patientIdentifier,
    required this.first_NAME,
    required this.last_NAME,
    required this.email,
    required this.phone_NUMBER,
    required this.birth_DATE,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientIdentifier: json['patientIdentifier'] ?? '',
      first_NAME: json['first_NAME'] ?? '',
      last_NAME: json['last_NAME'] ?? '',
      email: json['email'] ?? '',
      phone_NUMBER: json['phone_NUMBER'] ?? '',
      birth_DATE: json['birth_DATE'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}

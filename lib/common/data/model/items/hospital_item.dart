class HospitalItem {
  String? id;
  String? name;
  String address;
  String? type;
  String? phoneNo;
  double latitude;
  double longitude;
  double? distance;

  HospitalItem(
      this.id,
      this.name,
      this.address,
      this.type,
      this.phoneNo,
      this.latitude,
      this.longitude,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'type': this.type,
      'phoneNo': this.phoneNo,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }
}
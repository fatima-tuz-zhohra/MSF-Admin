class BloodDonorItem {

  String? id;
  String? name;
  String? address;
  String? phoneNo;
  String bloodGroup;


  BloodDonorItem(
      this.id,
      this.name,
      this.address,
      this.phoneNo,
     this.bloodGroup,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'phoneNo': this.phoneNo,
      'bloodGroup': this.bloodGroup,
    };
  }
}
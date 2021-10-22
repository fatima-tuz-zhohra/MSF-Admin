class OxygenItem {

   String? id;
   String? name;
   String? address;
   String? phoneNo;
   double latitude;
   double longitude;


  OxygenItem(
      this.id,
      this.name,
      this.address,
      this.phoneNo,
      this.latitude,
      this.longitude,
      );

   Map<String, dynamic> toMap() {
     return {
       'id': this.id,
       'name': this.name,
       'address': this.address,
       'phoneNo': this.phoneNo,
       'latitude': this.latitude,
       'longitude': this.longitude,
     };
   }
}
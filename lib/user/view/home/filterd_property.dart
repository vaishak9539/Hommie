// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user_category/user_view_home.dart';

class FilteredPropertyListScreen extends StatelessWidget {
  final String? type;
  final RangeValues priceRange;

  const FilteredPropertyListScreen({Key? key, this.type, required this.priceRange}) : super(key: key);

  Stream<QuerySnapshot> get itemStream => FirebaseFirestore.instance.collectionGroup("item_List").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtered Properties"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemStream,
        builder: (context, itemSnapshot) {
          if (itemSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemSnapshot.hasError) {
            return Center(child: Text("Error: ${itemSnapshot.error}"));
          }





          

          final propertyDocs = itemSnapshot.data?.docs ?? [];

          if (propertyDocs.isEmpty) {
            return const Center(child: Text("No properties found in the 'items' collection"));
          }

          // Apply filters based on type and price
          final filteredProperties = propertyDocs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;

            // Filter by type
            final matchesType = type == null || data['typ'] == type;

            // Filter by price
            final price = double.tryParse(data['setPrice'].toString()) ?? 0.0;
  final matchesPrice = price >= priceRange.start && price <= priceRange.end;

            return matchesType && matchesPrice;
          }).toList();

          if (filteredProperties.isEmpty) {
            return const Center(child: Text("No properties match the selected filters"));
          }

          return ListView.builder(
            itemCount: filteredProperties.length,
            itemBuilder: (context, index) {
              final itemData = filteredProperties[index].data() as Map<String, dynamic>;
              final property = Property.fromFirestore(itemData);

              return ListTile(
                title: Text(property.name),
                subtitle: Text("${property.fullAddress ?? ""} - ${property.setPrice ?? "N/A"} "),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PropertyDetailScreen(property: property),
                  //   ),
                  // );
                },
              );
            },
          );
        },
      ),
    );
  }
}

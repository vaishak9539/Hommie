import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommie/model/utils/style/color.dart';

// First, create a class to hold filter values
class PropertyFilter {
  String? type;
  RangeValues? priceRange;
  int? minBedrooms;
  int? minBathrooms;
  String? landmark;
  
  PropertyFilter({
    this.type,
    this.priceRange,
    this.minBedrooms,
    this.minBathrooms,
    this.landmark,
  });
  
  bool get isEmpty => 
    type == null && 
    priceRange == null && 
    minBedrooms == null && 
    minBathrooms == null && 
    landmark == null;
    
  void clear() {
    type = null;
    priceRange = null;
    minBedrooms = null;
    minBathrooms = null;
    landmark = null;
  }
}

// Create a filter dialog widget
class PropertyFilterDialog extends StatefulWidget {
  final PropertyFilter currentFilter;
  final Function(PropertyFilter) onApplyFilter;

  const PropertyFilterDialog({
    Key? key,
    required this.currentFilter,
    required this.onApplyFilter,
  }) : super(key: key);

  @override
  State<PropertyFilterDialog> createState() => _PropertyFilterDialogState();
}

class _PropertyFilterDialogState extends State<PropertyFilterDialog> {
  late PropertyFilter filter;
  final double _minPrice = 0;
  final double _maxPrice = 10000; // Adjust based on your price range

  @override
  void initState() {
    super.initState();
    filter = PropertyFilter(
      type: widget.currentFilter.type,
      priceRange: widget.currentFilter.priceRange ?? RangeValues(_minPrice, _maxPrice),
      minBedrooms: widget.currentFilter.minBedrooms,
      minBathrooms: widget.currentFilter.minBathrooms,
      landmark: widget.currentFilter.landmark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: myColor.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filters', 
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                      color: myColor.textcolor,
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: myColor.textcolor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Property Type Filter
              Text('Property Type', 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: myColor.textcolor,
                )
              ),
              DropdownButton<String>(
                value: filter.type,
                isExpanded: true,
                dropdownColor: myColor.background,
                hint: Text('Select Type', style: TextStyle(color: myColor.textcolor)),
                items: ['Home', 'Villa', 'Apartment'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: myColor.textcolor)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    filter.type = newValue;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Price Range Filter
              Text('Price Range (L)', 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: myColor.textcolor,
                )
              ),
              RangeSlider(
                values: filter.priceRange!,
                min: _minPrice,
                max: _maxPrice,
                divisions: 100,
                labels: RangeLabels(
                  filter.priceRange!.start.round().toString(),
                  filter.priceRange!.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    filter.priceRange = values;
                  });
                },
              ),
              
              // Bedrooms Filter
              Text('Minimum Bedrooms', 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: myColor.textcolor,
                )
              ),
              DropdownButton<int>(
                value: filter.minBedrooms,
                isExpanded: true,
                dropdownColor: myColor.background,
                hint: Text('Select Bedrooms', style: TextStyle(color: myColor.textcolor)),
                items: [1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value+ Bedrooms', style: TextStyle(color: myColor.textcolor)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    filter.minBedrooms = newValue;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Bathrooms Filter
              Text('Minimum Bathrooms', 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: myColor.textcolor,
                )
              ),
              DropdownButton<int>(
                value: filter.minBathrooms,
                isExpanded: true,
                dropdownColor: myColor.background,
                hint: Text('Select Bathrooms', style: TextStyle(color: myColor.textcolor)),
                items: [1, 2, 3, 4].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value+ Bathrooms', style: TextStyle(color: myColor.textcolor)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    filter.minBathrooms = newValue;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Landmark Filter
              Text('Landmark', 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: myColor.textcolor,
                )
              ),
              TextField(
                style: TextStyle(color: myColor.textcolor),
                decoration: InputDecoration(
                  hintText: 'Enter landmark',
                  hintStyle: TextStyle(color: myColor.textcolor.withOpacity(0.5)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myColor.textcolor),
                  ),
                ),
                onChanged: (value) {
                  filter.landmark = value.isEmpty ? null : value;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        filter.clear();
                      });
                    },
                    child: Text('Clear All', 
                      style: TextStyle(color: Colors.red)
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onApplyFilter(filter);
                      Navigator.pop(context);
                    },
                    child: Text('Apply Filters'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add this method to your _HomeState class to filter properties
List<DocumentSnapshot> filterProperties(List<DocumentSnapshot> properties, PropertyFilter filter) {
  if (filter.isEmpty) return properties;
  
  return properties.where((doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Type filter
    if (filter.type != null && data['typ'] != filter.type) {
      return false;
    }
    
    // Price filter
    if (filter.priceRange != null) {
      final price = double.tryParse(data['setPrice'].toString()) ?? 0;
      if (price < filter.priceRange!.start || price > filter.priceRange!.end) {
        return false;
      }
    }
    
    // Bedrooms filter
    if (filter.minBedrooms != null) {
      final bedrooms = int.tryParse(data['bedrooms'].toString()) ?? 0;
      if (bedrooms < filter.minBedrooms!) {
        return false;
      }
    }
    
    // Bathrooms filter
    if (filter.minBathrooms != null) {
      final bathrooms = int.tryParse(data['bathrooms'].toString()) ?? 0;
      if (bathrooms < filter.minBathrooms!) {
        return false;
      }
    }
    
    // Landmark filter
    if (filter.landmark != null && filter.landmark!.isNotEmpty) {
      final propertyLandmark = data['landmark']?.toString().toLowerCase() ?? '';
      if (!propertyLandmark.contains(filter.landmark!.toLowerCase())) {
        return false;
      }
    }
    
    return true;
  }).toList();
}
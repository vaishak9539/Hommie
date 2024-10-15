import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String id;
  final String title;
  final String category;
  final String ingredients;
  final String serve;
  final String time;
  final String cookingMethod;
  final String tips;
  final List<String> imageUrls;
  final String? videoUrl;
  final DateTime timestamp;
  final String chefId; // New field

  Recipe({
    this.id = '',
    required this.title,
    required this.category,
    required this.ingredients,
    required this.serve,
    required this.time,
    required this.cookingMethod,
    required this.tips,
    required this.imageUrls,
    this.videoUrl,
    required this.timestamp,
    required this.chefId, // Add this line
  });

  factory Recipe.fromMap(dynamic source) {
    Map<String, dynamic> data;
    String id;

    if (source is DocumentSnapshot) {
      data = source.data() as Map<String, dynamic>;
      id = source.id;
    } else if (source is Map<String, dynamic>) {
      data = source;
      id = data['id'] ?? '';
    } else {
      throw ArgumentError('Invalid source type for Recipe.fromMap');
    }

    return Recipe(
      id: id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      ingredients: data['ingredients'] ?? '',
      serve: data['serve'] ?? '',
      time: data['time'] ?? '',
      cookingMethod: data['cookingMethod'] ?? '',
      tips: data['tips'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      videoUrl: data['videoUrl'],
      timestamp: (data['timestamp'] is Timestamp)
          ? (data['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      chefId: data['chefId'] ?? '', // Add this line
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'ingredients': ingredients,
      'serve': serve,
      'time': time,
      'cookingMethod': cookingMethod,
      'tips': tips,
      'imageUrls': imageUrls,
      'videoUrl': videoUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'chefId': chefId, // Add this line
    };
  }
}

// Recipe newRecipe = Recipe(
//           chefId: userId,
//           title: _titleController.text,
//           category: _categoryController.text,
//           ingredients: _ingredientsController.text,
//           serve: _serveController.text,
//           time: _timeController.text,
//           cookingMethod: _cookingMethodController.text,
//           tips: _tipsController.text,
//           imageUrls: imageUrls,
//           videoUrl: videoUrl,
//           timestamp: DateTime.now(),
//         );
//             DocumentReference mainDocRef = await FirebaseFirestore.instance
//           .collection('recipes')
//           .add(newRecipe.toMap());
//            await mainDocRef.update({'id': mainDocRef.id});

//         DocumentReference docRef= await FirebaseFirestore.instance.collection('recipes').doc(userId).collection('recipes_list').add(newRecipe.toMap());
  
//         // Update the Firestore document to include the id field
//         await docRef.update({'id': docRef.id});
//         // Hide loading indicator
//         Navigator.of(context).pop();

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Recipe added successfully!')),
//         );
//         Navigator.pop(context); // Go back to previous screen
//       } catch (e) {
//         // Hide loading indicator
//         Navigator.of(context).pop();

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error adding recipe: $e')),
//         );
//       }
//     }
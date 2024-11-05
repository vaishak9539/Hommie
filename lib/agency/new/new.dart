//  Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: SizedBox(
//                   height: 50,
//                   width: 320,
//                   child: TypeAheadField(
                 
//            textFieldConfiguration: TextFieldConfiguration(
//       controller: _searchController,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Color(0xff1D1B20),
//         hintText: 'Search recipes...',
//         hintStyle: TextStyle(
//           color: Colors.white54,
//           fontSize: 16,
//         ),
//         prefixIcon: Icon(Icons.search, color: Colors.white),
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//          enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(
//         color: Colors.white54, // Border color when not focused
//         width: 1,
//       ),
//     ),
    
//     // Border when the text field is focused
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: BorderSide(
//         color: Colors.teal, // Border color when focused
//         width: 1,
//       ),
//     ),
//       ),
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 16,
//       ),
//     ),
         
//                     suggestionsCallback: (pattern) async {
//                       return await _getRecipeSuggestions(pattern);
//                     },
//                     itemBuilder: (context, DocumentSnapshot suggestion) {
//                       Map<String, dynamic> data =
//                           suggestion.data() as Map<String, dynamic>;
//                       return ListTile(
                       
//                         tileColor: Colors.black,
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(data['imageUrls'][0]),
//                         ),
//                         title: CustomText1(
//                           text: data['title'] ?? 'No title',
//                           size: 15,
//                         ),
//                         subtitle: CustomText1(
//                           text: data['category'] ?? 'No category',
//                           size: 12,
//                         ),
//                       );
//                     },
//                     onSuggestionSelected: (DocumentSnapshot suggestion) {
//                       Map<String, dynamic> data =
//                           suggestion.data() as Map<String, dynamic>;
//                       Recipe recipe = Recipe.fromMap(data);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RecipeDetailPage_chef(
//                             recipe: recipe,
//                             recipeId: suggestion.id,
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                 ),
//               ),
//             ),
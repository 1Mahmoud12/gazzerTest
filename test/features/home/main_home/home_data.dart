class HomeData {
  /// json responses

  final getGeneralErrorJson = {
    'message': 'An error occurred while fetching data',
  };

  final categoriesSuccessJson = {
    'status': 'success',
    'message': 'Categories fetched successfully',
    'data': [
      {
        'id': 1,
        'name': 'praesentium libero-686f939839caa',
        'type': 'Pharmacy',
        'image': 'https://images.co.image.png',
      },
      {
        'id': 2,
        'name': 'voluptatem eos-686f939839eb4',
        'type': 'Restaurant',
        'image': 'https://images.co.image.png',
      },
    ],
  };
}

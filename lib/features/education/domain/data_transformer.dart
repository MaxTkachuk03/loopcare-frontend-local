Map<String, dynamic> transformToFlatStructure(Map<String, dynamic> rawData) {
  final result = {
    'id': rawData['id'],
    'title': rawData['title'],
    'jumpBoardTitle': rawData['jumpBoardTitle'],
    'jumpBoardDescription': rawData['jumpBoardDescription'],
    'conclusion': rawData['conclusion'],
    'unlockTitle': rawData['unlockTitle'],
    'unlockDescription': rawData['unlockDescription'],
    'topics': <String, dynamic>{},
    'pages': <String, dynamic>{},
    'chunks': <String, dynamic>{},
    'components': <String, dynamic>{},
  };

  for (final topic in (rawData['topics'] as List<dynamic>)) {
    final (topicId, topicData) = _processTopic(topic);
    result['topics'][topicId] = topicData;

    for (final page in (topic['pages'] as List<dynamic>)) {
      final (pageId, pageData) = _processPage(page, topic['id']);
      result['pages'][pageId] = pageData;
      (result['topics'][topicId]['pagesIds'] as List<int>).add(page['id']);

      for (final chunk in (page['chunks'] as List<dynamic>)) {
        final (chunkId, chunkData) = _processChunk(chunk, page['id']);
        result['chunks'][chunkId] = chunkData;
        (result['pages'][pageId]['chunksIds'] as List<int>).add(chunk['id']);

        for (final component in (chunk['components'] as List<dynamic>)) {
          final (componentId, componentData) = _processComponent(component, chunk['id']);
          result['components'][componentId] = componentData;
          (result['chunks'][chunkId]['componentsIds'] as List<int>).add(component['id']);
        }
      }
    }
  }

  return result;
}

(String, Map<String, dynamic>) _processTopic(Map<String, dynamic> topic) {
  final topicId = topic['id'].toString();
  return (
    topicId,
    {
      'id': topic['id'],
      'title': topic['title'],
      'description': topic['description'],
      'pagesIds': <int>[],
    }
  );
}

(String, Map<String, dynamic>) _processPage(Map<String, dynamic> page, int topicId) {
  final pageId = page['id'].toString();
  return (
    pageId,
    {
      'id': page['id'],
      'title': page['title'],
      'order': page['order'],
      'chunksIds': <int>[],
      'topicId': topicId,
    }
  );
}

(String, Map<String, dynamic>) _processChunk(Map<String, dynamic> chunk, int pageId) {
  final chunkId = chunk['id'].toString();
  return (
    chunkId,
    {
      'id': chunk['id'],
      'title': chunk['title'],
      'componentsIds': <int>[],
      'pageId': pageId,
    }
  );
}

(String, Map<String, dynamic>) _processComponent(Map<String, dynamic> component, int chunkId) {
  final componentId = component['id'].toString();
  return (
    componentId,
    {
      ...component,
      'chunkId': chunkId,
    }
  );
}

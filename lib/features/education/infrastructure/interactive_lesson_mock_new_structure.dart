var interactiveLesson = {
  "id": 8,
  "title": "Calorie Density",
  "jumpBoardTitle": "Calorie Density Overview",
  "jumpBoardDescription": "Explore various aspects of calorie density through these topics.",
  "conclusion": 'conclusion text',
  "unlockTitle": 'unlock title text',
  "unlockDescription": 'unlock description text',
  "topics": {
    1: {
      "id": 1,
      "title": "Introduction to Calorie Density",
      "description": "Learn the basics of calorie density and its importance.",
      "pagesIds": [1, 2, 3],
    },
  },
  "pages": {
    1: {
      "id": 1,
      "title": "Page title 1",
      "pageNumber": 1,
      "chunksIds": [1, 2, 3],
      "topicId": 1
    },
    2: {
      "id": 2,
      "title": "Page title 2",
      "pageNumber": 2,
      "chunksIds": [1, 2],
      "topicId": 1
    },
    3: {
      "id": 3,
      "title": "Page title 3",
      "pageNumber": 3,
      "chunksIds": [1, 2],
      "topicId": 1
    }
  },
  "chunks": {
    1: {
      "id": 1,
      "title": "Chunk title 1",
      "componentsIds": [1, 2, 3, 4],
      "pageId": 1
    },
    2: {
      "id": 2,
      "title": "Chunk title 2",
      "componentsIds": [1, 2],
      "pageId": 1
    },
    3: {
      "id": 3,
      "title": "Chunk title 3",
      "componentsIds": [1],
      "pageId": 1
    },
    4: {
      "id": 1,
      "title": "Chunk title",
      "componentsIds": [1, 2],
      "pageId": 2
    },
    5: {
      "id": 2,
      "title": "Chunk title",
      "componentsIds": [1, 2],
      "pageId": 2
    },
    6: {
      "id": 1,
      "title": "Chunk title",
      "componentsIds": [1, 2],
      "pageId": 3
    },
    7: {
      "id": 2,
      "title": "Chunk title",
      "componentsIds": [1, 2],
      "pageId": 3
    }
  },
  "components": {
    1: {
      "id": 1,
      "type": "scale",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question":
            "How motivated are you to change your behavior in order to achieve these goals?",
        "lowestText": "not very motivated",
        "highestText": "very motivated",
        "values": [
          {"id": 1, "label": "1", "value": 1},
          {"id": 2, "label": "2", "value": 2},
          {"id": 3, "label": "3", "value": 3},
          {"id": 4, "label": "4", "value": 4},
          {"id": 5, "label": "5", "value": 5},
          {"id": 6, "label": "6", "value": 6},
          {"id": 7, "label": "7", "value": 7},
          {"id": 8, "label": "8", "value": 8},
          {"id": 9, "label": "9", "value": 9},
          {"id": 10, "label": "10", "value": 10}
        ],
        "feedback": [
          {
            "id": 1,
            "minValue": 1,
            "maxValue": 3,
            "text":
                "It looks like you are not very motivated at the moment. Consider identifying specific factors that might increase your motivation."
          },
          {
            "id": 2,
            "minValue": 4,
            "maxValue": 7,
            "text":
                "You have a moderate level of motivation. Think about setting small, achievable goals to boost your drive."
          },
          {
            "id": 3,
            "minValue": 8,
            "maxValue": 10,
            "text":
                "Fantastic! You are highly motivated and confident. Keep up the great work and continue setting ambitious goals."
          }
        ]
      },
      "chunkId": 1
    },
    2: {
      "id": 2,
      "type": "multipleSelect",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select multiple answers.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": null},
          {"id": 2, "label": "Answer 2", "isCorrect": null},
          {"id": 3, "label": "Answer 3", "isCorrect": null},
          {"id": 4, "label": "Answer 4", "isCorrect": null}
        ],
        "feedbackCorrect": null,
        "feedbackIncorrect": null
      },
      "chunkId": 1
    },
    3: {
      "id": 3,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 1
    },
    4: {
      "id": 4,
      "type": "ordering",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question": "Order the food items from least calories to most calories.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {
            "id": 1,
            "order": 2,
            "src": "/images/plate-1.jpg",
            "title": "Label 1",
            "description": "Description 1"
          },
          {
            "id": 2,
            "order": 1,
            "src": "/images/plate-2.jpg",
            "title": "Label 2",
            "description": "Description 2"
          },
          {
            "id": 3,
            "order": 0,
            "src": "/images/plate-3.jpg",
            "title": "Label 3",
            "description": "Description 3"
          }
        ],
        "feedbackCorrect":
            "Great job! You've correctly ordered the food items from least to most calories.",
        "feedbackIncorrect": "Almost there! The correct order is...",
        "feedbackRevealed": "Answer revealed ...."
      },
      "chunkId": 1
    },
    5: {
      "id": 1,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 2
    },
    6: {
      "id": 2,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 2
    },
    7: {
      "id": 1,
      "type": "singleSelect",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": null},
          {"id": 2, "label": "Answer 2", "isCorrect": null},
          {"id": 3, "label": "Answer 3", "isCorrect": null},
          {"id": 4, "label": "Answer 4", "isCorrect": null}
        ],
        "feedbackCorrect": null,
        "feedbackIncorrect": null,
      },
      "chunkId": 3
    },
    8: {
      "id": 1,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 4
    },
    9: {
      "id": 2,
      "type": "ordering",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {
            "id": 1,
            "order": 2,
            "src": "/images/plate-1.jpg",
            "title": "Label 1",
            "description": "Description 1"
          },
          {
            "id": 2,
            "order": 1,
            "src": "/images/plate-2.jpg",
            "title": "Label 2",
            "description": "Description 2"
          },
          {
            "id": 3,
            "order": 0,
            "src": "/images/plate-3.jpg",
            "title": "Label 3",
            "description": "Description 3"
          }
        ],
        "feedbackCorrect":
            "Great job! You've correctly ordered the food items from least to most calories.",
        "feedbackIncorrect": "Almost there! The correct order is...",
        "feedbackRevealed": "Answer revealed ...."
      },
      "chunkId": 4
    },
    10: {
      "id": 1,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 5
    },
    11: {
      "id": 2,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 5
    },
    12: {
      "id": 1,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 6
    },
    13: {
      "id": 2,
      "type": "ordering",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {
            "id": 1,
            "order": 2,
            "src": "/images/plate-1.jpg",
            "title": "Label 1",
            "description": "Description 1"
          },
          {
            "id": 2,
            "order": 1,
            "src": "/images/plate-2.jpg",
            "title": "Label 2",
            "description": "Description 2"
          },
          {
            "id": 3,
            "order": 0,
            "src": "/images/plate-3.jpg",
            "title": "Label 3",
            "description": "Description 3"
          }
        ],
        "feedbackCorrect":
            "Great job! You've correctly ordered the food items from least to most calories.",
        "feedbackIncorrect": "Almost there! The correct order is...",
        "feedbackRevealed": "Answer revealed ...."
      },
      "chunkId": 6
    },
    14: {
      "id": 1,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 7
    },
    15: {
      "id": 2,
      "type": "singleSelectWithFeedback",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "question": "My question. Select one answer with feedback.",
        "answers": [
          {"id": 1, "label": "Answer 1", "isCorrect": true},
          {"id": 2, "label": "Answer 2", "isCorrect": false},
          {"id": 3, "label": "Answer 3", "isCorrect": false},
          {"id": 4, "label": "Answer 4", "isCorrect": false}
        ],
        "feedbackCorrect": "Correct Feedback for answers 1 and 2.",
        "feedbackIncorrect": "Incorrect Feedback for answers 3 and 4."
      },
      "chunkId": 7
    }
  },
};

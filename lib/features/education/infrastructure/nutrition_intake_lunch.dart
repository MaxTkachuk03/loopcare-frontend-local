var nutritionIntakeLesson = {
  "id": 1,
  "type": "nutrition",
  "title": "Nutrition intake",
  "jumpBoardTitle": "",
  "jumpBoardDescription": "",
  "conclusion": "",
  "unlockTitle": "Food log unlocked",
  "unlockDescription":
      "Use the Food log to record what you ate each day. Complete the food log survey after you are done logging each day.",
  "topics": {
    "1": {
      "id": 1,
      "title": "When and why I ate",
      "description": "#dayDate",
      "pagesIds": [1]
    }
  },
  "pages": {
    "1": {
      "id": 1,
      "title": "When and why I ate",
      "pageNumber": 1,
      "chunksIds": [1],
      "topicId": 1
    },
  },
  "chunks": {
    "1": {
      "id": 1,
      "title": "",
      "componentsIds": [1, 2, 3, 4],
      "pageId": 1
    },
  },
  "components": {
    "1": {
      "id": 1,
      "chunkId": 1,
      "type": "image",
      "needsValidation": false,
      "isValid": true,
      "content": {"src": "assets/images/nutrition_image.png"}
    },
    "2": {
      "id": 2,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {"markdown": "When and why I ate"}
    },
    "3": {
      "id": 3,
      "chunkId": 1,
      "type": "mealTiming",
      "needsValidation": false,
      "isValid": true,
      "meals": [],
      "content": {
        "markdown":
            "Did you eat lunch at around this time? If not, please edit."
      }
    },
    "4": {
      "id": 4,
      "chunkId": 1,
      "type": "singleSelect",
      "needsValidation": false,
      "isValid": false,
      "content": {
        "question": "Which statement generally describes your lunch for today?",
        "answers": [
          {
            "id": 1,
            "label": "Mostly unplanned and spontaneous",
            "isCorrect": null
          },
          {
            "id": 2,
            "label": "Somewhat unplanned and spontaneous",
            "isCorrect": null
          },
          {"id": 3, "label": "Planned, and not spontaneous", "isCorrect": null},
        ],
        "feedbackCorrect": null,
        "feedbackIncorrect": null
      },
      
    },
  }
};
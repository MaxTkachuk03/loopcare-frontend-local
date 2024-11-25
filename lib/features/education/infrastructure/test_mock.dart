var testLesson = {
  "id": 1,
  "type": "nutrition",
  "title": "Commitment",
  "jumpBoardTitle": "",
  "jumpBoardDescription": "",
  "conclusion": "Time to learn about your diet!",
  "unlockTitle": "Personal Commitment unlocked"
      "ACTION REQUIRED ",
  "unlockDescription":
      "For each committed day, log everything you eat. Complete the food log survey after you are done logging each day.",
  "topics": {
    "1": {
      "id": 1,
      "title": "Food log commitment",
      "description": "",
      "pagesIds": [1, 2, 3]
    }
  },
  "pages": {
    "1": {
      "id": 1,
      "title": "Food log commitment",
      "pageNumber": 1,
      "chunksIds": [1, 2],
      "topicId": 1
    },
  },
  "chunks": {
    "1": {
      "id": 1,
      "title": "",
      "componentsIds": [1, 2, 3, 4, 5, 6],
      "pageId": 1
    }
  },
  "components": {
    "1": {
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
    "2": {
      "id": 2,
      "type": "multipleSelect",
      "needsValidation": false,
      "isValid": false,
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
    "3": {
      "id": 3,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {"markdown": "So, lets make a commitment!"}
    },
    "4": {
      "id": 4,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "Commit to logging your diet for a number of days that ensure you will be accurate and thorough. The more days you complete, the better tailored the program will be!"
      }
    },
    "5": {
      "id": 5,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "When you have logged all of your meals for the day, you should complete the 1-2 minute questionnaire, located on your “commitment” widget."
      }
    },
    "6": {
      "id": 6,
      "chunkId": 1,
      "type": "singleSelect",
      "needsValidation": false,
      "isValid": false,
      "content": {
        "question":
            "My question. Select multiple answers.How many days will you commit to logging your food in this module? Remember, you must spend at least 7 days in this module, and you won’t be able to move on until you have logged as many days as you commit to now.",
        "answers": [
          {"id": 1, "label": "4 days", "isCorrect": null},
          {"id": 2, "label": "5 days", "isCorrect": null},
          {"id": 3, "label": "6 days", "isCorrect": null},
          {"id": 4, "label": "7 days", "isCorrect": null}
        ],
        "feedbackCorrect": null,
        "feedbackIncorrect": null
      },
    },
    "7": {
      "id": 7,
      "type": "singleSelect",
      "needsValidation": false,
      "isValid": false,
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
      "chunkId": 1
    },
  }
};

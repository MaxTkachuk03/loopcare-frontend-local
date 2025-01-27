var multipleSelectWithFeedback = {
  "id": 100,
  "language": "en",
  "title": "Food survey",
  "streamType": "nutrition",
  "jumpBoardTitle": "Food survey: Snacks",
  "jumpBoardDescription": "",
  "unlockTitle": "Food survey: Snacks",
  "unlockDescription":
      "Use the food log to record what you ate each day. Complete the food log survey after you are done logging each day.",
  "conclusion": "",
  "riverModuleItem": null,
  "topics": [
    {
      "id": 671,
      "pageIds": [1773],
      "title": "Survey - Snacks",
      "description": ""
    }
  ],
  "pages": [
    {
      "id": 1773,
      "topicId": 671,
      "chunkIds": [4525],
      "order": 1,
      "title": "Survey - Snacks"
    }
  ],
  "chunks": [
    {
      "id": 4525,
      "pageId": 1773,
      "componentIds": [8797, 8798, 5],
      "order": 1,
      "title": "Chunk commitment snacks 10004"
    }
  ],
  "components": [
    {
      "id": 8797,
      "chunkId": 4525,
      "needsValidation": false,
      "isValid": true,
      "packProgress": true,
      "type": "markdown",
      "content": {
        "order": 1,
        "title": null,
        "content": "{\"markdown\":\"## When and why I ate ...\"}",
        "question": null,
        "feedbackCorrect": null,
        "feedbackIncorrect": null,
        "feedbackRevealed": null,
        "highestText": null,
        "lowestText": null,
        "imageURL": null,
        "answers": [],
        "feedbacks": []
      },
      "progress": []
    },
    {
      "id": 8798,
      "chunkId": 4525,
      "needsValidation": false,
      "isValid": true,
      "packProgress": true,
      "type": "singleSelectWithFeedback",
      "content": {
        "order": 2,
        "title": "What do you think?",
        "question": "Protein is just for bodybuilders.",
        "feedbackCorrect":
            "Although protein is necessary for building muscle, it’s also important for feeling full and burning fat! Let’s find out why.",
        "feedbackIncorrect":
            "Although protein is necessary for building muscle, it’s also important for feeling full and burning fat! Let’s find out why.",
        "feedbackRevealed": null,
        "highestText": null,
        "lowestText": null,
        "imageURL": null,
        "answers": [
          {
            "id": 5605,
            "externalId": 1,
            "order": 1,
            "label": "true",
            "description": null,
            "value": null,
            "imageURL": null,
            "isCorrect": false
          },
          {
            "id": 5606,
            "externalId": 2,
            "order": 2,
            "label": "false",
            "description": null,
            "value": null,
            "imageURL": null,
            "isCorrect": true
          }
        ],
        "feedbacks": []
      },
      "progress": [
        // {
        //   "id": "3865",
        //   "lessonId": 40008,
        //   "answeredAt": "2025-01-24",
        //   "componentId": 2,
        //   "optionIds": [1],
        //   "detailedOptionIds": [],
        //   "type": "singleSelectWithFeedback",
        //   "history": []
        // }
      ]
    },
    {
      "id": 5,
      "chunkId": 4525,
      "needsValidation": false,
      "isValid": true,
      "packProgress": true,
      "type": "multipleSelectWithFeedback",
      "content": {
        "order": 2,
        "title": "What do you think?",
        "question": "Protein is just for bodybuilders.",
        "feedbackCorrect":
            "Although protein is necessary for building muscle, it’s also important for feeling full and burning fat! Let’s find out why.",
        "feedbackIncorrect":
            "AAAAAAAAlthough protein is necessary for building muscle, it’s also important for feeling full and burning fat! Let’s find out why",
        "feedbackRevealed": null,
        "highestText": null,
        "lowestText": null,
        "imageURL": null,
        "answers": [
          {
            "id": 1,
            "externalId": 1,
            "order": 1,
            "label": "true",
            "description": null,
            "value": null,
            "imageURL": null,
            "isCorrect": true
          },
          {
            "id": 2,
            "externalId": 2,
            "order": 2,
            "label": "false",
            "description": null,
            "value": null,
            "imageURL": null,
            "isCorrect": false
          },
          {
            "id": 3,
            "externalId": 3,
            "order": 3,
            "label": "true",
            "description": null,
            "value": null,
            "imageURL": null,
            "isCorrect": true
          },
          {
            "id": 4,
            "externalId": 4,
            "order": 4,
            "label": "false",
            "description": null,
            "value": null,
            "imageURL": null,
            "isCorrect": false
          }
        ],
        "feedbacks": []
      },
      "progress": []
    },
  ],
  "completedAt": null
};

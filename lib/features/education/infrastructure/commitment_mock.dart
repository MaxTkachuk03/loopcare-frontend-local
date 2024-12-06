var commitmentLesson = {
  "id": 6,
  "language": "en",
  "type": "nutrition",
  "title": "Commitment",
  "jumpBoardTitle": "",
  "jumpBoardDescription": "",
  "conclusion": "Time to learn about your diet!",
  "unlockTitle": "Personal Commitment unlocked",
  "unlockDescription":
  "For each committed day, log everything you eat. Complete the food log survey after you are done logging each day.",
  "topics": [
    {
      "id": 1,
      "title": "Food log commitment",
      "description": "",
      "pageIds": [1, 2, 3]
    }
  ],
  "pages": [
    {
      "id": 1,
      "title": "Food log commitment",
      "order": 1,
      "chunkIds": [1, 2],
      "topicId": 1
    },
  ],
  "chunks": [
    {
      "id": 1,
      "title": "",
      "componentIds": [1, 2],
      "pageId": 1,
      "order": 1,
    }
  ],
  "components": [
    {
      "id": 1,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "order": 1,
        "title": null,
        "content": "{\"markdown\":\"## The benefits of food logging\"}",
        "instruction": null,
        "feedbackCorrect": null,
        "feedbackIncorrect": null,
        "feedbackRevealed": null,
        "highestText": null,
        "lowestText": null,
        "imageURL": null,
        "options": [],
        "feedbacks": []
      },
      "progress": [],
    },
    {
      "id": 2,
      "chunkId": 1,
      "type": "survey",
      "needsValidation": false,
      "isValid": false,
      "content": {
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
        "order": 1,
        "title": null,
        "instruction": null,
        "feedbackCorrect": null,
        "feedbackIncorrect": null,
        "feedbackRevealed": null,
        "highestText": null,
        "lowestText": null,
        "imageURL": null,
        "options": [],
        "feedbacks": []
      },
      "progress": [],
    },
  ]
};

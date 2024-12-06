var nutritionIntakeLessonSnaks = {
  "id": 2,
  "type": "nutrition",
  "title": "Nutrition intake",
  "jumpBoardTitle": "",
  "jumpBoardDescription": "",
  "conclusion": "",
  "unlockTitle": "Food log unlocked",
  "unlockDescription":
      "Use the Food log to record what you ate each day. Complete the food log survey after you are done logging each day.",
   "topics": [
     {
      "id": 1,
      "title": "When and why I ate",
      "description": "#dayDate",
      "pageIds": [1]
    }
  ],
  "pages": [
    {
      "id": 1,
      "title": "When and why I ate",
      "order": 1,
      "chunkIds": [1, 2],
      "topicId": 1
    },
  ],
  "chunks": [ {
      "id": 1,
      "title": "",
      "componentIds": [1, 2, 3, 4],
      "pageId": 1,
      "order": 1,
    },{
      "id": 2,
      "title": "",
      "componentIds": [5],
      "pageId": 1,
      "order": 2,
    },
  ],
  "components": [{
      "id": 1,
      "chunkId": 1,
      "type": "image",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "order": 1,
        "title": null,
       "content": {"src": "assets/images/nutrition_image.png"},
        "instruction": null,
        "feedbackCorrect": null,
        "feedbackIncorrect": null,
        "feedbackRevealed": null,
        "highestText": null,
        "lowestText": null,
        "imageURL": "https://d1400rdtmcr7oq.cloudfront.net/InteractiveLessons/images/benefits-1.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMTQwMHJkdG1jcjdvcS5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzMzMzMzNzIxfX19XX0_&Key-Pair-Id=K26BFJ25EUDSA3&Signature=Wu2Rz1tt5zCUhMPPEUxRSc8qsbtBhQrx-UwYk5xLW67oVnRZVV2CzcMfFJsWp1ujhy1K6XcC1ASzRJL-YPv2L533q27cT~UWNLQ8xha89ZaiOnw3~-LLuoV24BJ0poLO7gbuY9lCUVT3z8sMgzZWiAbvprJG10Rilj7O3QQ5JcYKxx11XSyAXxD~n5p3ShxK~rTEnm4-5iNQbdFeVa2Hsgna5Xv0hTK1Mg5lf89~B96ZSfKs2b0MtFdGJhGZ-Q9qygRuAE~Jk14zJ6sxbQcNnGONA21Wv0UHra8NSjgc4CHj1hmoSsPfvMaZ59H1iqDSc6ryfWYRNjcdH6KAYuj~tQ__",
        "options": [],
        "feedbacks": []
      },
      "progress": []
      
    },
   {
      "id": 2,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "order": 1,
        "title": null,
 "content": {"markdown": "When and why I ate"},
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
      "id": 3,
      "chunkId": 1,
      "type": "mealTiming",
      "needsValidation": false,
      "isValid": true,
       "content": {
        "order": 1,
        "title": null,
 "content": {"question":
            "Did you eat lunch at around this time? If not, please edit.",
             "meals": [],},
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
      "id": 4,
      "chunkId": 1,
      "type": "singleSelect",
      "needsValidation": false,
      "isValid": false,
     "content": { 
      "content": {
        "question": "Which statement generally describes your lunch for today?",
        "answers": [
          {"id": 1, "label": "Unplanned and spontaneous", "isCorrect": null},
          {"id": 2, "label": "Somewhat planned", "isCorrect": null},
          {"id": 3, "label": "Planned, and not spontaneous", "isCorrect": null},
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
    {
      "id": 5,
      "chunkId": 2,
      "type": "multipleSelect",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "order": 1,
        "title": null,
        "content": {
        "question":
            "Which of the following snacks did you eat due to a craving?",
        "answers": [
          {
            "id": 1,
            "label": "List of Snack 1 based on food log ",
            "isCorrect": null
          },
          {
            "id": 2,
            "label": "List of Snack 2 based on food log ",
            "isCorrect": null
          },
          {
            "id": 3,
            "label": "List of Snack 3 based on food log ",
            "isCorrect": null
          },
          {"id": 4, "label": "None", "isCorrect": null}
        ],
        "feedbackCorrect": null,
        "feedbackIncorrect": null
      },
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
      "progress": []
    },
  ],
};

var interactiveLesson = {
  "id": 8,
  "title": "Calorie Density",
  "jumpBoardTitle": "Calorie Density Overview",
  "jumpBoardDescription": "Explore various aspects of calorie density through these topics.",
  "conclusion": 'conclusion text',
  "unlockTitle": 'unlock title text',
  "unlockDescription": 'unlock description text',
  "topics": [
    {
      "id": 1,
      "title": "Introduction to Calorie Density",
      "description": "Learn the basics of calorie density and its importance.",
      "pages": [
        {
          "id": 1,
          "title": "What is Calorie Density?",
          "pageNumber": 1,
          "chunks": [
            {
              "id": 1,
              "title": "Chunk title",
              "components": [
                {
                  "id": 1,
                  "type": "markdown",
                  "needsValidation": false,
                  "isValid": true,
                  "content": {
                    "markdown": """
# Heading 1 
## Heading 2 
### Heading 3 
#### Heading 4 
##### Heading 5 
###### Heading 6 
paragraph with some text and some **bold text** and some *italic text* and so on.
Ordered list
1. Item 1
2. Item 2
3. Item 3

Unordered list
- Item 1
- Item 2
- Item 3
""",
                  }
                },
                {
                  "id": 2,
                  "type": "scale",
                  "needsValidation": true,
                  "isValid": false,
                  "content": {
                    "question":
                        "How motivated are you to change your behavior in order to achieve these goals?",
                    "lowestText": "not very motivated",
                    "highestText": "very motivated",
                    "values": [
                      {"label": "1", "value": 1},
                      {"label": "2", "value": 2},
                      {"label": "3", "value": 3},
                      {"label": "4", "value": 4},
                      {"label": "5", "value": 5},
                      {"label": "6", "value": 6},
                      {"label": "7", "value": 7},
                      {"label": "8", "value": 8},
                      {"label": "9", "value": 9},
                      {"label": "10", "value": 10}
                    ],
                    "feedback": [
                      {
                        "minValue": 1,
                        "maxValue": 3,
                        "text":
                            "It looks like you are not very motivated at the moment. Consider identifying specific factors that might increase your motivation."
                      },
                      {
                        "minValue": 4,
                        "maxValue": 7,
                        "text":
                            "You have a moderate level of motivation. Think about setting small, achievable goals to boost your drive."
                      },
                      {
                        "minValue": 8,
                        "maxValue": 10,
                        "text":
                            "Fantastic! You are highly motivated and confident. Keep up the great work and continue setting ambitious goals."
                      }
                    ]
                  }
                },
                {
                  "id": 3,
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
                    "feedback": null
                  }
                },
                {
                  "id": 4,
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
                    "feedback": null
                  }
                },
                {
                  "id": 5,
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
                    "feedback": {
                      "correct": "Correct Feedback for answers 1 and 2.",
                      "incorrect": "Incorrect Feedback for answers 3 and 4."
                    }
                  }
                },
                {
                  "id": 6,
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
                        "correctIndex": 2,
                        "src": "/images/plate-1.jpg",
                        "title": "Label 1",
                        "description": "Description 1"
                      },
                      {
                        "id": 2,
                        "correctIndex": 1,
                        "src": "/images/plate-2.jpg",
                        "title": "Label 2",
                        "description": "Description 2"
                      },
                      {
                        "id": 3,
                        "correctIndex": 0,
                        "src": "/images/plate-3.jpg",
                        "title": "Label 3",
                        "description": "Description 3"
                      }
                    ],
                    "feedback": {
                      "correct":
                          "Great job! You've correctly ordered the food items from least to most calories.",
                      "incorrect": "Almost there! The correct order is...",
                      "orderRevealed": "Answer revealed ...."
                    }
                  }
                },
              ]
            },
            {
              "id": 2,
              "title": "Chunk title",
              "components": [
                {
                  "id": 3,
                  "type": "image",
                  "needsValidation": false,
                  "isValid": true,
                  "content": {
                    "src":
                        "https://www.google.com/imgres?q=image&imgurl=https%3A%2F%2Fplus.unsplash.com%2Fpremium_photo-1664474619075-644dd191935f%3Ffm%3Djpg%26q%3D60%26w%3D3000%26ixlib%3Drb-4.0.3%26ixid%3DM3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%253D&imgrefurl=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fimage&docid=ExDvm63D_wCvSM&tbnid=2brKLR3s5kTpPM&vet=12ahUKEwiXg5CUg9GIAxU0BdsEHfj_FfsQM3oECBsQAA..i&w=3000&h=2003&hcb=2&itg=1&ved=2ahUKEwiXg5CUg9GIAxU0BdsEHfj_FfsQM3oECBsQAA",
                  },
                }
              ]
            }
          ]
        }
      ]
    },
  ]
};

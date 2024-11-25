var nutritionLesson = {
  "id": 7,
  "type": "nutrition",
  "title": "The benefits of food logging",
  "jumpBoardTitle": "",
  "jumpBoardDescription": "",
  "conclusion": "",
  "unlockTitle": "Food log unlocked",
  "unlockDescription":
      "Use the Food log to record what you ate each day. Complete the food log survey after you are done logging each day.",
  "topics": {
    "1": {
      "id": 1,
      "title": "The benefits of food logging",
      "description": "",
      "pagesIds": [1, 2, 3, 4]
    }
  },
  "pages": {
    "1": {
      "id": 1,
      "title": "The benefits of food logging",
      "pageNumber": 1,
      "chunksIds": [1, 2, 3, 4, 5, 6],
      "topicId": 1
    },
    "2": {
      "id": 2,
      "title": "The benefits of food logging",
      "pageNumber": 2,
      "chunksIds": [7, 8, 9],
      "topicId": 1
    },
    "3": {
      "id": 3,
      "title": "The benefits of food logging",
      "pageNumber": 3,
      "chunksIds": [10, 11, 12, 13],
      "topicId": 1
    },
    "4": {
      "id": 4,
      "title": "The benefits of food logging",
      "pageNumber": 4,
      "chunksIds": [14],
      "topicId": 1
    }
  },
  "chunks": {
    "1": {
      "id": 1,
      "title": "",
      "componentsIds": [1, 2, 3],
      "pageId": 1
    },
    "2": {
      "id": 2,
      "title": "",
      "componentsIds": [1, 2, 3],
      "pageId": 1
    },
    "3": {
      "id": 3,
      "title": "",
      "componentsIds": [1],
      "pageId": 1
    },
    "4": {
      "id": 4,
      "title": "",
      "componentsIds": [1],
      "pageId": 1
    },
    "5": {
      "id": 5,
      "title": "",
      "componentsIds": [1, 2],
      "pageId": 1
    },
    "6": {
      "id": 6,
      "title": "",
      "componentsIds": [1],
      "pageId": 1
    },
    "7": {
      "id": 7,
      "title": "",
      "componentsIds": [1],
      "pageId": 2
    },
    "8": {
      "id": 8,
      "title": "",
      "componentsIds": [1],
      "pageId": 2
    },
    "9": {
      "id": 9,
      "title": "",
      "componentsIds": [1],
      "pageId": 2
    },
    "10": {
      "id": 10,
      "title": "",
      "componentsIds": [1],
      "pageId": 3
    },
    "11": {
      "id": 11,
      "title": "",
      "componentsIds": [1],
      "pageId": 3
    },
    "12": {
      "id": 12,
      "title": "",
      "componentsIds": [1],
      "pageId": 3
    },
    "13": {
      "id": 13,
      "title": "",
      "componentsIds": [1],
      "pageId": 3
    },
    "14": {
      "id": 14,
      "title": "",
      "componentsIds": [1],
      "pageId": 4
    }
  },
  "components": {
    "1": {
      "id": 1,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "## The benefits of food logging\n\nIn this lesson, you will test your nutritional knowledge. You will learn why food logs are important, and how this program will use the food log to do much more than just count calories."
      }
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
    // "2": {
    //   "id": 2,
    //   "chunkId": 1,
    //   "type": "image",
    //   "needsValidation": false,
    //   "isValid": true,
    //   "content": {"src": "TBD"}
    // },
    "3": {
      "id": 3,
      "chunkId": 1,
      "type": "textArea",
      "needsValidation": true,
      "isValid": false,
      "maxCharsLength": 150,
      "maxTextFieldsAmount": 5,
      "minTextFieldsAmount": 3,
      "content": {
        "question": "The only purpose of a food log is to track calories.",
      }
    },
    "4": {
      "id": 1,
      "chunkId": 2,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "Research shows that people tend to eat healthier when they track their food. In one U.S. weight-loss study of 1,700 participants, those who kept a food log lost twice as much weight as those who didn’t. Often, the calories in different foods can surprise us. Let’s test your skills below."
      }
    },
    "5": {
      "id": 2,
      "chunkId": 2,
      "type": "image",
      "needsValidation": false,
      "isValid": true,
      "content": {"src": "TBD"}
    },
    "6": {
      "id": 3,
      "chunkId": 2,
      "type": "singleSelectWithFeedback",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question":
            "By just looking, what do you think is the calorie difference between the two burger meals?",
        "answers": [
          {"id": 1, "label": "Almost no difference", "isCorrect": false},
          {"id": 2, "label": "100kcal", "isCorrect": false},
          {"id": 3, "label": "200kcal", "isCorrect": false},
          {"id": 4, "label": "300kcal", "isCorrect": true}
        ],
        "feedbackCorrect":
            "Each contains almost the same amount of food, and they’re both delicious. But the LeanOnMe recipe is 300 calories less! Let’s take a closer look at the ingredients.",
        "feedbackIncorrect":
            "Each contains almost the same amount of food, and they’re both delicious. But the LeanOnMe recipe is 300 calories less! Let’s take a closer look at the ingredients.",
        "feedbackRevealed": "Answer revealed ...."
      }
    },
    "7": {
      "id": 1,
      "chunkId": 3,
      "type": "ordering",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question":
            "Here are the ingredients from that typical restaurant burger meal. Place them in order from most calories to least calories.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {"id": 3, "order": 2, "src": "TBD", "title": "1 white bread bun", "description": ""},
          {"id": 4, "order": 3, "src": "TBD", "title": "2 cheese slices", "description": ""},
          {"id": 2, "order": 1, "src": "TBD", "title": "1 cup deep fried fries", "description": ""},
          {
            "id": 5,
            "order": 4,
            "src": "TBD",
            "title": "1/2 cup broccoli with 1/2 tbsp butter",
            "description": ""
          },
          {
            "id": 1,
            "order": 0,
            "src": "TBD",
            "title": "4 oz 80% lean beef patty",
            "description": ""
          }
        ],
        "feedbackCorrect":
            "Isn’t it interesting that you can add all that butter to broccoli, and it’s still the least calories in the whole meal?",
        "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
        "feedbackRevealed": "Answer revealed ...."
      }
    },
    "8": {
      "id": 1,
      "chunkId": 4,
      "type": "ordering",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question":
            "Here are the ingredients from a home made burger meal. Place them in order from most calories to least calories.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {"id": 3, "order": 4, "src": "TBD", "title": "1 high fiber bun", "description": ""},
          {
            "id": 1,
            "order": 1,
            "src": "TBD",
            "title": "4 oz 96% lean beef patty",
            "description": ""
          },
          {"id": 4, "order": 3, "src": "TBD", "title": "1 cheese slice", "description": ""},
          {
            "id": 2,
            "order": 0,
            "src": "TBD",
            "title": "1 cup homemade oven fries",
            "description": ""
          },
          {
            "id": 5,
            "order": 2,
            "src": "TBD",
            "title": "1/2 cup broccoli with 1/2 tbsp butter",
            "description": ""
          }
        ],
        "feedbackCorrect":
            "Do you see how small changes, like going for lower-fat ground beef or high-fiber buns, can have a big effect on the calories in the “same food”.",
        "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
        "feedbackRevealed": "Answer revealed ...."
      }
    },
    "9": {
      "id": 1,
      "chunkId": 5,
      "type": "image",
      "needsValidation": false,
      "isValid": true,
      "content": {"src": "TBD"}
    },
    "10": {
      "id": 2,
      "chunkId": 5,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "Notice how each improvement adds up, making the increased calories from something like vegetables inconsequential!"
      }
    },
    "11": {
      "id": 1,
      "chunkId": 6,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "**When it comes to calories, not all burgers were created equal.That’s also true when it comes to other nutritional values.**\n\n Notice how each improvement adds up, making the increased calories from something like vegetables inconsequential!"
      }
    },
    "12": {
      "id": 1,
      "chunkId": 7,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "## Nutrition for weight loss is about more than just calories\n\nProtein is important because it plays a key role in managing hunger, metabolism, and body composition.  Plus you burn more calories digesting protein than any other nutrient.\n\nLet’s have a look at some typical protein sources and see how they compare."
      }
    },
    "13": {
      "id": 1,
      "chunkId": 8,
      "type": "ordering",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question":
            "Here are 5 typical protein sources you may be choosing from on an average day. Drag the images in order from most protein to least protein. Each portion is 250 calories.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {"id": 2, "order": 1, "src": "TBD", "title": "80% lean beef", "description": "3.57 oz"},
          {"id": 5, "order": 4, "src": "TBD", "title": "chicken breast", "description": "5.34 oz"},
          {"id": 1, "order": 0, "src": "TBD", "title": "Chicken thigh", "description": "4.12 oz"},
          {"id": 3, "order": 2, "src": "TBD", "title": "96% lean beef", "description": "4.56 oz "},
          {"id": 4, "order": 3, "src": "TBD", "title": "plant protein", "description": "7.7 oz"}
        ],
        "feedbackCorrect":
            "Do you see how small changes, like going for lower-fat ground beef or high-fiber buns, can have a big effect on the calories in the “same food”.",
        "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
        "feedbackRevealed": "Answer revealed ...."
      }
    },
    "14": {
      "id": 1,
      "chunkId": 9,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "### It doesn’t matter what kind of protein you prefer, there are almost always leaner versions available!\n\nThat means if you like beef, you don’t have to swear off beef. You can simply experiment with a leaner version of beef!\n\nIf you’re vegetarian, you may think your protein source options are limited ... but you’re wrong! We’ll be providing you with extra material on plant-based protein options in a later level."
      }
    },
    "15": {
      "id": 1,
      "chunkId": 10,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "## Fiber facts\n\nWhat is fiber, anyway? And what’s it for? Fiber’s a bit of a mystery to most people, but LeanOnMe is going to help make you a subject-matter expert!\n\nSimply put, fiber is food your body can’t digest, so it fills you up without adding any calories to your day. But that’s not all! Fiber also helps keep your gut happy and healthy. Throughout our program, you’ll learn how that works, and it’s good for your physical health, and also your mental health."
      }
    },
    "16": {
      "id": 1,
      "chunkId": 11,
      "type": "ordering",
      "needsValidation": true,
      "isValid": false,
      "content": {
        "question":
            "Do your best to arrange the following food items from most fiber, to least fiber.",
        "topLabel": "Most calories",
        "bottomLabel": "Least calories",
        "items": [
          {"id": 4, "order": 3, "src": "TBD", "title": "apples", "description": "3 pieces"},
          {"id": 2, "order": 1, "src": "TBD", "title": "brown rice", "description": "2 cups"},
          {"id": 5, "order": 4, "src": "TBD", "title": "lettuce", "description": "5 cups"},
          {"id": 1, "order": 0, "src": "TBD", "title": "broccoli", "description": "3 cups"},
          {"id": 3, "order": 2, "src": "TBD", "title": "raspberries", "description": "1.5 cups"}
        ],
        "feedbackCorrect": "TBD",
        "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
        "feedbackRevealed": "Answer revealed ...."
      }
    },
    "17": {
      "id": 1,
      "chunkId": 12,
      "type": "image",
      "needsValidation": false,
      "isValid": true,
      "content": {"src": "TBD"}
    },
    "18": {
      "id": 1,
      "chunkId": 13,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "### So would you rather eat 2 cups of brown rice you don’t really like, or 1 cup of white rice you really enjoy, with some broccoli?\n\nSometimes, the things we think are good for us, aren’t the answer. You don’t have to eat food you find unsatisfying to be successful on your weight loss journey!\n\nMany factors in your diet influence how satisfying and nourishing your meals can be. And we will help you find the way that works for you.\n\nEach level in nutrition will teach you about a particular factor, and then help you **apply them to your own diet using the food log.**"
      }
    },
    "19": {
      "id": 1,
      "chunkId": 14,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "## Nutrition for weight loss is about more than just calories\n\nNot everyone's diet has the same weak spots. Different people need to work on different aspects of nutrition to lose weight successfully.\n\n**It probably feels counter-intuitive since you just downloaded the app and you want to get started! But for the next 4 to 7 days, we need you to keep eating what you “normally” eat.** \n\nLog all the food you eat and answer a few questions at the end of each day, and right after, we will give you a personalized nutrition plan.\n\nStart logging all your food in the **Food Log**, and complete the **Mutual Commitment** to start your intake."
      }
    }
  }
};

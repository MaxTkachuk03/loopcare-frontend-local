// var interactiveLesson = {
//   "id": 8,
//   "type": "nutrition",
//   "title": "The benefits of food logging",
//   "jumpBoardTitle": "",
//   "jumpBoardDescription": "",
//   "conclusion": "",
//   "unlockTitle": "Food log unlocked",
//   "unlockDescription":
//       "Use the Food log to record what you ate each day. Complete the food log survey after you are done logging each day.",
//   "topics": {
//     "1": {
//       "id": 1,
//       "title": "The benefits of food logging",
//       "description": "",
//       "pagesIds": [1, 2, 3, 4]
//     }
//   },
//   "pages": {
//     "1": {
//       "id": 1,
//       "title": "The benefits of food logging",
//       "pageNumber": 1,
//       "chunksIds": [1, 2, 3, 4, 5, 6],
//       "topicId": 1
//     },
//     "2": {
//       "id": 2,
//       "title": "The benefits of food logging",
//       "pageNumber": 2,
//       "chunksIds": [7, 8, 9],
//       "topicId": 1
//     },
//     "3": {
//       "id": 3,
//       "title": "The benefits of food logging",
//       "pageNumber": 3,
//       "chunksIds": [10, 11, 12, 13],
//       "topicId": 1
//     },
//     "4": {
//       "id": 4,
//       "title": "The benefits of food logging",
//       "pageNumber": 4,
//       "chunksIds": [14],
//       "topicId": 1
//     }
//   },
//   "chunks": {
//     "1": {
//       "id": 1,
//       "title": "",
//       "componentsIds": [1, 2, 3],
//       "pageId": 1
//     },
//     "2": {
//       "id": 2,
//       "title": "",
//       "componentsIds": [1, 2, 3],
//       "pageId": 1
//     },
//     "3": {
//       "id": 3,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 1
//     },
//     "4": {
//       "id": 4,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 1
//     },
//     "5": {
//       "id": 5,
//       "title": "",
//       "componentsIds": [1, 2],
//       "pageId": 1
//     },
//     "6": {
//       "id": 6,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 1
//     },
//     "7": {
//       "id": 7,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 2
//     },
//     "8": {
//       "id": 8,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 2
//     },
//     "9": {
//       "id": 9,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 2
//     },
//     "10": {
//       "id": 10,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 3
//     },
//     "11": {
//       "id": 11,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 3
//     },
//     "12": {
//       "id": 12,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 3
//     },
//     "13": {
//       "id": 13,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 3
//     },
//     "14": {
//       "id": 14,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 4
//     }
//   },
//   "components": {
//     "1": {
//       "id": 1,
//       "chunkId": 1,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## The benefits of food logging\n\nIn this lesson, you will test your nutritional knowledge. You will learn why food logs are important, and how this program will use the food log to do much more than just count calories."
//       }
//     },
//     "2": {
//       "id": 2,
//       "type": "multipleSelect",
//       "needsValidation": false,
//       "isValid": false,
//       "content": {
//         "question": "My question. Select multiple answers.",
//         "answers": [
//           {"id": 1, "label": "Answer 1", "isCorrect": null},
//           {"id": 2, "label": "Answer 2", "isCorrect": null},
//           {"id": 3, "label": "Answer 3", "isCorrect": null},
//           {"id": 4, "label": "Answer 4", "isCorrect": null}
//         ],
//         "feedbackCorrect": null,
//         "feedbackIncorrect": null
//       },
//       "chunkId": 1
//     },
//     // "2": {
//     //   "id": 2,
//     //   "chunkId": 1,
//     //   "type": "image",
//     //   "needsValidation": false,
//     //   "isValid": true,
//     //   "content": {"src": "TBD"}
//     // },
//     "3": {
//       "id": 3,
//       "chunkId": 1,
//       "type": "textArea",
//       "needsValidation": true,
//       "isValid": false,
//       "maxCharsLength": 150,
//       "maxTextFieldsAmount": 5,
//       "minTextFieldsAmount": 3,
//       "content": {
//         "question": "The only purpose of a food log is to track calories.",
//       }
//     },
//     "4": {
//       "id": 1,
//       "chunkId": 2,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "Research shows that people tend to eat healthier when they track their food. In one U.S. weight-loss study of 1,700 participants, those who kept a food log lost twice as much weight as those who didn’t. Often, the calories in different foods can surprise us. Let’s test your skills below."
//       }
//     },
//     "5": {
//       "id": 2,
//       "chunkId": 2,
//       "type": "image",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {"src": "TBD"}
//     },
//     "6": {
//       "id": 3,
//       "chunkId": 2,
//       "type": "singleSelectWithFeedback",
//       "needsValidation": true,
//       "isValid": false,
//       "content": {
//         "question":
//             "By just looking, what do you think is the calorie difference between the two burger meals?",
//         "answers": [
//           {"id": 1, "label": "Almost no difference", "isCorrect": false},
//           {"id": 2, "label": "100kcal", "isCorrect": false},
//           {"id": 3, "label": "200kcal", "isCorrect": false},
//           {"id": 4, "label": "300kcal", "isCorrect": true}
//         ],
//         "feedbackCorrect":
//             "Each contains almost the same amount of food, and they’re both delicious. But the LeanOnMe recipe is 300 calories less! Let’s take a closer look at the ingredients.",
//         "feedbackIncorrect":
//             "Each contains almost the same amount of food, and they’re both delicious. But the LeanOnMe recipe is 300 calories less! Let’s take a closer look at the ingredients.",
//         "feedbackRevealed": "Answer revealed ...."
//       }
//     },
//     "7": {
//       "id": 1,
//       "chunkId": 3,
//       "type": "ordering",
//       "needsValidation": true,
//       "isValid": false,
//       "content": {
//         "question":
//             "Here are the ingredients from that typical restaurant burger meal. Place them in order from most calories to least calories.",
//         "topLabel": "Most calories",
//         "bottomLabel": "Least calories",
//         "items": [
//           {
//             "id": 3,
//             "order": 2,
//             "src": "TBD",
//             "title": "1 white bread bun",
//             "description": ""
//           },
//           {
//             "id": 4,
//             "order": 3,
//             "src": "TBD",
//             "title": "2 cheese slices",
//             "description": ""
//           },
//           {
//             "id": 2,
//             "order": 1,
//             "src": "TBD",
//             "title": "1 cup deep fried fries",
//             "description": ""
//           },
//           {
//             "id": 5,
//             "order": 4,
//             "src": "TBD",
//             "title": "1/2 cup broccoli with 1/2 tbsp butter",
//             "description": ""
//           },
//           {
//             "id": 1,
//             "order": 0,
//             "src": "TBD",
//             "title": "4 oz 80% lean beef patty",
//             "description": ""
//           }
//         ],
//         "feedbackCorrect":
//             "Isn’t it interesting that you can add all that butter to broccoli, and it’s still the least calories in the whole meal?",
//         "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
//         "feedbackRevealed": "Answer revealed ...."
//       }
//     },
//     "8": {
//       "id": 1,
//       "chunkId": 4,
//       "type": "ordering",
//       "needsValidation": true,
//       "isValid": false,
//       "content": {
//         "question":
//             "Here are the ingredients from a home made burger meal. Place them in order from most calories to least calories.",
//         "topLabel": "Most calories",
//         "bottomLabel": "Least calories",
//         "items": [
//           {
//             "id": 3,
//             "order": 4,
//             "src": "TBD",
//             "title": "1 high fiber bun",
//             "description": ""
//           },
//           {
//             "id": 1,
//             "order": 1,
//             "src": "TBD",
//             "title": "4 oz 96% lean beef patty",
//             "description": ""
//           },
//           {
//             "id": 4,
//             "order": 3,
//             "src": "TBD",
//             "title": "1 cheese slice",
//             "description": ""
//           },
//           {
//             "id": 2,
//             "order": 0,
//             "src": "TBD",
//             "title": "1 cup homemade oven fries",
//             "description": ""
//           },
//           {
//             "id": 5,
//             "order": 2,
//             "src": "TBD",
//             "title": "1/2 cup broccoli with 1/2 tbsp butter",
//             "description": ""
//           }
//         ],
//         "feedbackCorrect":
//             "Do you see how small changes, like going for lower-fat ground beef or high-fiber buns, can have a big effect on the calories in the “same food”.",
//         "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
//         "feedbackRevealed": "Answer revealed ...."
//       }
//     },
//     "9": {
//       "id": 1,
//       "chunkId": 5,
//       "type": "image",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {"src": "TBD"}
//     },
//     "10": {
//       "id": 2,
//       "chunkId": 5,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "Notice how each improvement adds up, making the increased calories from something like vegetables inconsequential!"
//       }
//     },
//     "11": {
//       "id": 1,
//       "chunkId": 6,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "**When it comes to calories, not all burgers were created equal.That’s also true when it comes to other nutritional values.**\n\n Notice how each improvement adds up, making the increased calories from something like vegetables inconsequential!"
//       }
//     },
//     "12": {
//       "id": 1,
//       "chunkId": 7,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## Nutrition for weight loss is about more than just calories\n\nProtein is important because it plays a key role in managing hunger, metabolism, and body composition.  Plus you burn more calories digesting protein than any other nutrient.\n\nLet’s have a look at some typical protein sources and see how they compare."
//       }
//     },
//     "13": {
//       "id": 1,
//       "chunkId": 8,
//       "type": "ordering",
//       "needsValidation": true,
//       "isValid": false,
//       "content": {
//         "question":
//             "Here are 5 typical protein sources you may be choosing from on an average day. Drag the images in order from most protein to least protein. Each portion is 250 calories.",
//         "topLabel": "Most calories",
//         "bottomLabel": "Least calories",
//         "items": [
//           {
//             "id": 2,
//             "order": 1,
//             "src": "TBD",
//             "title": "80% lean beef",
//             "description": "3.57 oz"
//           },
//           {
//             "id": 5,
//             "order": 4,
//             "src": "TBD",
//             "title": "chicken breast",
//             "description": "5.34 oz"
//           },
//           {
//             "id": 1,
//             "order": 0,
//             "src": "TBD",
//             "title": "Chicken thigh",
//             "description": "4.12 oz"
//           },
//           {
//             "id": 3,
//             "order": 2,
//             "src": "TBD",
//             "title": "96% lean beef",
//             "description": "4.56 oz "
//           },
//           {
//             "id": 4,
//             "order": 3,
//             "src": "TBD",
//             "title": "plant protein",
//             "description": "7.7 oz"
//           }
//         ],
//         "feedbackCorrect":
//             "Do you see how small changes, like going for lower-fat ground beef or high-fiber buns, can have a big effect on the calories in the “same food”.",
//         "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
//         "feedbackRevealed": "Answer revealed ...."
//       }
//     },
//     "14": {
//       "id": 1,
//       "chunkId": 9,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "### It doesn’t matter what kind of protein you prefer, there are almost always leaner versions available!\n\nThat means if you like beef, you don’t have to swear off beef. You can simply experiment with a leaner version of beef!\n\nIf you’re vegetarian, you may think your protein source options are limited ... but you’re wrong! We’ll be providing you with extra material on plant-based protein options in a later level."
//       }
//     },
//     "15": {
//       "id": 1,
//       "chunkId": 10,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## Fiber facts\n\nWhat is fiber, anyway? And what’s it for? Fiber’s a bit of a mystery to most people, but LeanOnMe is going to help make you a subject-matter expert!\n\nSimply put, fiber is food your body can’t digest, so it fills you up without adding any calories to your day. But that’s not all! Fiber also helps keep your gut happy and healthy. Throughout our program, you’ll learn how that works, and it’s good for your physical health, and also your mental health."
//       }
//     },
//     "16": {
//       "id": 1,
//       "chunkId": 11,
//       "type": "ordering",
//       "needsValidation": true,
//       "isValid": false,
//       "content": {
//         "question":
//             "Do your best to arrange the following food items from most fiber, to least fiber.",
//         "topLabel": "Most calories",
//         "bottomLabel": "Least calories",
//         "items": [
//           {
//             "id": 4,
//             "order": 3,
//             "src": "TBD",
//             "title": "apples",
//             "description": "3 pieces"
//           },
//           {
//             "id": 2,
//             "order": 1,
//             "src": "TBD",
//             "title": "brown rice",
//             "description": "2 cups"
//           },
//           {
//             "id": 5,
//             "order": 4,
//             "src": "TBD",
//             "title": "lettuce",
//             "description": "5 cups"
//           },
//           {
//             "id": 1,
//             "order": 0,
//             "src": "TBD",
//             "title": "broccoli",
//             "description": "3 cups"
//           },
//           {
//             "id": 3,
//             "order": 2,
//             "src": "TBD",
//             "title": "raspberries",
//             "description": "1.5 cups"
//           }
//         ],
//         "feedbackCorrect": "TBD",
//         "feedbackIncorrect": "Try again, or tap “continue” to see the answer.",
//         "feedbackRevealed": "Answer revealed ...."
//       }
//     },
//     "17": {
//       "id": 1,
//       "chunkId": 12,
//       "type": "image",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {"src": "TBD"}
//     },
//     "18": {
//       "id": 1,
//       "chunkId": 13,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "### So would you rather eat 2 cups of brown rice you don’t really like, or 1 cup of white rice you really enjoy, with some broccoli?\n\nSometimes, the things we think are good for us, aren’t the answer. You don’t have to eat food you find unsatisfying to be successful on your weight loss journey!\n\nMany factors in your diet influence how satisfying and nourishing your meals can be. And we will help you find the way that works for you.\n\nEach level in nutrition will teach you about a particular factor, and then help you **apply them to your own diet using the food log.**"
//       }
//     },
//     "19": {
//       "id": 1,
//       "chunkId": 14,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## Nutrition for weight loss is about more than just calories\n\nNot everyone's diet has the same weak spots. Different people need to work on different aspects of nutrition to lose weight successfully.\n\n**It probably feels counter-intuitive since you just downloaded the app and you want to get started! But for the next 4 to 7 days, we need you to keep eating what you “normally” eat.** \n\nLog all the food you eat and answer a few questions at the end of each day, and right after, we will give you a personalized nutrition plan.\n\nStart logging all your food in the **Food Log**, and complete the **Mutual Commitment** to start your intake."
//       }
//     }
//   }
// };

// var interactiveLesson = {
//   "id": 6,
//   "type": "psychology",
//   "title": "What's your why",
//   "jumpBoardTitle": "",
//   "jumpBoardDescription": "",
//   "conclusion":
//       "Well done, you've taken another step to a healthier lifestyle!",
//   "unlockTitle": "Reflections unlocked"
//       "The Reflections provide a space for you to note down your thoughts to the Mind topics and tasks. Take some time and reflect on your why you want to change your current lifestyle and note it down in the Reflection.",
//   "unlockDescription":
//       "Use the Food log to record what you ate each day. Complete the food log survey after you are done logging each day.",
//   "topics": {
//     "1": {
//       "id": 1,
//       "title": "What's your why",
//       "description": "",
//       "pagesIds": [1, 2, 3]
//     }
//   },
//   "pages": {
//     "1": {
//       "id": 1,
//       "title": "What's your why",
//       "pageNumber": 1,
//       "chunksIds": [1, 2],
//       "topicId": 1
//     },
//     "2": {
//       "id": 2,
//       "title": "What's your why",
//       "pageNumber": 2,
//       "chunksIds": [3, 4],
//       "topicId": 1
//     },
//     "3": {
//       "id": 3,
//       "title": "What's your why",
//       "pageNumber": 3,
//       "chunksIds": [5, 6],
//       "topicId": 1
//     }
//   },
//   "chunks": {
//     "1": {
//       "id": 1,
//       "title": "",
//       "componentsIds": [1],
//       "pageId": 1
//     },
//     "2": {
//       "id": 2,
//       "title": "",
//       "componentsIds": [2],
//       "pageId": 1
//     },
//     "3": {
//       "id": 3,
//       "title": "",
//       "componentsIds": [3, 4],
//       "pageId": 2
//     },
//     "4": {
//       "id": 4,
//       "title": "",
//       "componentsIds": [5, 6],
//       "pageId": 2
//     },
//     "5": {
//       "id": 5,
//       "title": "",
//       "componentsIds": [7, 8],
//       "pageId": 3
//     },
//     "6": {
//       "id": 6,
//       "title": "",
//       "componentsIds": [9, 10],
//       "pageId": 3
//     }
//   },
//   "components": {
//     "1": {
//       "id": 1,
//       "chunkId": 1,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "##**The first step of any change is awareness. But what does this mean?**\n\nIt can mean, for example, first becoming aware of what you eat throughout the day, how you eat, where you eat, or how often you exercise.\n\nHere, it is also good to consider the advantages as well as the disadvantages of changing your current behavior. Only then can you see which behavior is helpful for you and which isn't. This can also show you whether you would want to change this behavior in the first place or want things to remain the same."
//       }
//     },
//     "2": {
//       "id": 2,
//       "chunkId": 2,
//       "type": "multipleSelect",
//       "needsValidation": false,
//       "isValid": false,
//       "content": {
//         "question": "My question. Select multiple answers.",
//         "answers": [
//           {"id": 1, "label": "Answer 1", "isCorrect": null},
//           {"id": 2, "label": "Answer 2", "isCorrect": null},
//           {"id": 3, "label": "Answer 3", "isCorrect": null},
//           {"id": 4, "label": "Answer 4", "isCorrect": null}
//         ],
//         "feedbackCorrect": null,
//         "feedbackIncorrect": null
//       },
//     },
//     // "2": {
//     //   "id": 2,
//     //   "chunkId": 2,
//     //   "type": "markdown",
//     //   "needsValidation": false,
//     //   "isValid": true,
//     //   "content": {
//     //     "markdown":
//     //         "##**So here is the first important question you have to ask yourself: How high is your motivation to change your habits and your behavior?**\n\nTo answer this you have to look at both sides - take a look at the advantages as well as the disadvantages of changing your behavior with regard to your eating and exercise habits. After that, consider the pros and cons of just keeping things as they are and not changing anything about your lifestyle.\n\nEven here always look at both sides and that means considering the advantages of not changing your current lifestyle as well as the disadvantages.\n\nDon’t forget to think about the long-term and short-term!There is no time like the present! Ready?"
//     //   }
//     // },
//     "3": {
//       "id": 3,
//       "chunkId": 3,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## First take a look at the advantages of changing your behavior with regard to your eating and exercise habits. These could be things like you'll feel generally fitter or you'll lose weight. Make sure to distinguish between short-term and long-term advantages."
//       }
//     },
//     "4": {
//       "id": 4,
//       "chunkId": 3,
//       "type": "textArea",
//       "needsValidation": true,
//       "isValid": false,
//       "maxCharsLength": 400,
//       "maxTextFieldsAmount": 4,
//       "minTextFieldsAmount": 3,
//       "content": {
//         "question": "What are the benefits of changing your behavior?",
//       }
//     },
//     "5": {
//       "id": 5,
//       "chunkId": 4,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## Now consider the disadvantages: for example that you may have to invest a lot of time and energy, or you'll have to be extremely disciplined.\n\nAgain remember to take long-term and short-term effects into account."
//       }
//     },
//     "6": {
//       "id": 6,
//       "chunkId": 4,
//       "type": "textArea",
//       "needsValidation": true,
//       "isValid": false,
//       "maxCharsLength": 400,
//       "maxTextFieldsAmount": 1,
//       "minTextFieldsAmount": 1,
//       "content": {
//         "question": "What are the disadvantages of changing your behavior?",
//       }
//     },
//     "7": {
//       "id": 7,
//       "chunkId": 5,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## Now think about your current lifestyle and the advantages of not changing would be, like having a good excuse not to be active or not having to plan your meals.\n\nKeep the long-term and short-term effects in mind!"
//       }
//     },
//     "8": {
//       "id": 8,
//       "chunkId": 5,
//       "type": "textArea",
//       "needsValidation": true,
//       "isValid": false,
//       "maxCharsLength": 400,
//       "maxTextFieldsAmount": 1,
//       "minTextFieldsAmount": 1,
//       "content": {
//         "question":
//             "What the advantages of not changing your behavior and continuing as before?",
//       }
//     },
//     "9": {
//       "id": 9,
//       "chunkId": 6,
//       "type": "markdown",
//       "needsValidation": false,
//       "isValid": true,
//       "content": {
//         "markdown":
//             "## Lastly, think about the disadvantages of not changing anything about your current eating and exercise habits.\n\nDisadvantages could be that you feel uncomfortable and sluggish or even feel guilty when eating. Don’t forget to consider the long-term and the short-term!"
//       }
//     },
//     "10": {
//       "id": 10,
//       "chunkId": 6,
//       "type": "textArea",
//       "needsValidation": true,
//       "isValid": false,
//       "maxCharsLength": 400,
//       "maxTextFieldsAmount": 1,
//       "minTextFieldsAmount": 1,
//       "content": {
//         "question": "What are the disadvantages of continuing as before?",
//       }
//     }
//   }
// };

var interactiveLesson = {
  "id": 6,
  "type": "nutrition",
  "title": "Commitment",
  "jumpBoardTitle": "",
  "jumpBoardDescription": "",
  "conclusion": "Time to learn about your diet!",
  "unlockTitle": "Personal Commitment unlocked"
      "ACTION REQUIRED For each committed day, log everything you eat. Complete the food log survey after you are done logging each day.",
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
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {"markdown": "Food log commitment"}
    },
    "2": {
      "id": 2,
      "chunkId": 1,
      "type": "markdown",
      "needsValidation": false,
      "isValid": true,
      "content": {
        "markdown":
            "Accurate and thorough information is most important. Partial days will misrepresent your overall diet, and will cause the program to misinterpret your diets quality."
      }
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
      "type": "multipleSelect",
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
  }
};

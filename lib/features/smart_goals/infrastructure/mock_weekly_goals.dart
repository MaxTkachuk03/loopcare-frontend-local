var weeklyGoals = {
  "id": 1,
  // new session
  // "startedAt": "2024-03-25",
  // "finishedAt": "2024-04-01",
  // "isActive": false,

  // active session
  "startedAt": "2024-04-04",
  "finishedAt": "2024-04-12",
  "isActive": true,

  // inactive session delay
  // "startedAt": "2024-04-01",
  // "finishedAt": "2024-04-08",
  // "isActive": false,

  "goals": [
    {
      "id": 1,
      "smartGoal": {
        "id": 1,
        "category": {"id": 1, "externalId": "1", "name": "Sleep", "image": "/images/icon.png"},
        "title": "Sleep in a room that is between 66-72°.",
        "funFact":
            "Sleeping in a cooler room is important to maintain good sleep. This is likely because your internal clock drops your core body temperature as you sleep. This means a cool room is helpful to keep you comfortable in your sleep, which improves your sleep quality.",
        "requiredCompletions": 7,
        "requiredDays": 7
      },
      "difficulty": 2,
      "isTryAgain": true,
      "progressLogs": [
        {"date": "2024-04-04", "times": 1},
        {"date": "2024-04-05", "times": 7}
      ]
    },
    {
      "id": 2,
      "smartGoal": {
        "id": 2,
        "category": {"id": 1, "externalId": "1", "name": "Sleep", "image": "/images/icon.png"},
        "title": "Sleep in a room that is between 66-72°.",
        "funFact":
            "Sleeping in a cooler room is important to maintain good sleep. This is likely because your internal clock drops your core body temperature as you sleep. This means a cool room is helpful to keep you comfortable in your sleep, which improves your sleep quality.",
        "requiredCompletions": 7,
        "requiredDays": 7
      },
      "difficulty": 2,
      "isTryAgain": true,
      "progressLogs": [
        {"date": "2024-04-05", "times": 8}
      ]
    }
  ],
};

var plans = [
  {
    "translationRegion": "us",
    "productId": "monthly",
    "price": 0.99,
    "subscriptionPlan": {
      "id": 1,
      "title": "1 month for",
      "description": "Normal 95€/month (save 30€!)"
    },
    "subscriptionTranslation": {
      "customBillingPeriodText": "month",
      "offerDescription": "Buy now for \$0.50 / month",
      "badge":
          "https://d2h5j7hy56ita7.cloudfront.net/subscriptions/images/us/badge.svg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMmg1ajdoeTU2aXRhNy5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzI0MzM3MjA0fX19XX0_&Key-Pair-Id=K36SJB3H7IKUDL&Signature=X0zrbNsyCj95jNmx7~QduXQvxZL~Pr35vxYr0nTIaXGeq4NLBrJJYIO6WVG-xIBsCH21H0MXTdFpATTbZnFmQ1VSfCy2EhIEVZEV-XfsbndiubT9SjuRRa-zaRXodXCKqfjb314dys11oHfqMsgGqbD2px9pBXIJ3kG0SoIonRSGfLEazhYG6fIpdaFGsZgFoJP1FrEDnmiCutOp02BrCIPAROK76JQaJQwdwtEtYLB04XfRFbD1VKeMECLK2QvgBBZCCo5H773dSEy88jjcfv6hixSDj6E7Z2GjMmcGbMQe84jBfh9kWBXPS3eiSUBLNpVvMy59F9IYIavK26hc~Q__",
      "carouselImages": [
        "https://d2h5j7hy56ita7.cloudfront.net/subscriptions/carouselImages/us/badge-1.svg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMmg1ajdoeTU2aXRhNy5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzI0MzM3MjA0fX19XX0_&Key-Pair-Id=K36SJB3H7IKUDL&Signature=X0zrbNsyCj95jNmx7~QduXQvxZL~Pr35vxYr0nTIaXGeq4NLBrJJYIO6WVG-xIBsCH21H0MXTdFpATTbZnFmQ1VSfCy2EhIEVZEV-XfsbndiubT9SjuRRa-zaRXodXCKqfjb314dys11oHfqMsgGqbD2px9pBXIJ3kG0SoIonRSGfLEazhYG6fIpdaFGsZgFoJP1FrEDnmiCutOp02BrCIPAROK76JQaJQwdwtEtYLB04XfRFbD1VKeMECLK2QvgBBZCCo5H773dSEy88jjcfv6hixSDj6E7Z2GjMmcGbMQe84jBfh9kWBXPS3eiSUBLNpVvMy59F9IYIavK26hc~Q__",
        "https://d2h5j7hy56ita7.cloudfront.net/subscriptions/carouselImages/us/badge-2.svg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMmg1ajdoeTU2aXRhNy5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzI0MzM3MjA0fX19XX0_&Key-Pair-Id=K36SJB3H7IKUDL&Signature=X0zrbNsyCj95jNmx7~QduXQvxZL~Pr35vxYr0nTIaXGeq4NLBrJJYIO6WVG-xIBsCH21H0MXTdFpATTbZnFmQ1VSfCy2EhIEVZEV-XfsbndiubT9SjuRRa-zaRXodXCKqfjb314dys11oHfqMsgGqbD2px9pBXIJ3kG0SoIonRSGfLEazhYG6fIpdaFGsZgFoJP1FrEDnmiCutOp02BrCIPAROK76JQaJQwdwtEtYLB04XfRFbD1VKeMECLK2QvgBBZCCo5H773dSEy88jjcfv6hixSDj6E7Z2GjMmcGbMQe84jBfh9kWBXPS3eiSUBLNpVvMy59F9IYIavK26hc~Q__",
        "https://d2h5j7hy56ita7.cloudfront.net/subscriptions/carouselImages/us/carouselImage-1.svg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMmg1ajdoeTU2aXRhNy5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzI0MzM3MjA0fX19XX0_&Key-Pair-Id=K36SJB3H7IKUDL&Signature=X0zrbNsyCj95jNmx7~QduXQvxZL~Pr35vxYr0nTIaXGeq4NLBrJJYIO6WVG-xIBsCH21H0MXTdFpATTbZnFmQ1VSfCy2EhIEVZEV-XfsbndiubT9SjuRRa-zaRXodXCKqfjb314dys11oHfqMsgGqbD2px9pBXIJ3kG0SoIonRSGfLEazhYG6fIpdaFGsZgFoJP1FrEDnmiCutOp02BrCIPAROK76JQaJQwdwtEtYLB04XfRFbD1VKeMECLK2QvgBBZCCo5H773dSEy88jjcfv6hixSDj6E7Z2GjMmcGbMQe84jBfh9kWBXPS3eiSUBLNpVvMy59F9IYIavK26hc~Q__",
        "https://d2h5j7hy56ita7.cloudfront.net/subscriptions/carouselImages/us/carouselImage-2.svg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMmg1ajdoeTU2aXRhNy5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzI0MzM3MjA0fX19XX0_&Key-Pair-Id=K36SJB3H7IKUDL&Signature=X0zrbNsyCj95jNmx7~QduXQvxZL~Pr35vxYr0nTIaXGeq4NLBrJJYIO6WVG-xIBsCH21H0MXTdFpATTbZnFmQ1VSfCy2EhIEVZEV-XfsbndiubT9SjuRRa-zaRXodXCKqfjb314dys11oHfqMsgGqbD2px9pBXIJ3kG0SoIonRSGfLEazhYG6fIpdaFGsZgFoJP1FrEDnmiCutOp02BrCIPAROK76JQaJQwdwtEtYLB04XfRFbD1VKeMECLK2QvgBBZCCo5H773dSEy88jjcfv6hixSDj6E7Z2GjMmcGbMQe84jBfh9kWBXPS3eiSUBLNpVvMy59F9IYIavK26hc~Q__",
        "https://d2h5j7hy56ita7.cloudfront.net/subscriptions/carouselImages/us/carouselImage-3.svg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9kMmg1ajdoeTU2aXRhNy5jbG91ZGZyb250Lm5ldC8qIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzI0MzM3MjA0fX19XX0_&Key-Pair-Id=K36SJB3H7IKUDL&Signature=X0zrbNsyCj95jNmx7~QduXQvxZL~Pr35vxYr0nTIaXGeq4NLBrJJYIO6WVG-xIBsCH21H0MXTdFpATTbZnFmQ1VSfCy2EhIEVZEV-XfsbndiubT9SjuRRa-zaRXodXCKqfjb314dys11oHfqMsgGqbD2px9pBXIJ3kG0SoIonRSGfLEazhYG6fIpdaFGsZgFoJP1FrEDnmiCutOp02BrCIPAROK76JQaJQwdwtEtYLB04XfRFbD1VKeMECLK2QvgBBZCCo5H773dSEy88jjcfv6hixSDj6E7Z2GjMmcGbMQe84jBfh9kWBXPS3eiSUBLNpVvMy59F9IYIavK26hc~Q__"
      ]
    }
  },
];

from __future__ import print_function

from alexa_concierge.concierge_events import on_launch, on_session_ended
from alexa_concierge.concierge_events import on_session_started, on_intent
import os


def lambda_handler(event, context):
    application_id = os.environ["application_id"]  # you need to set Environment variable application_id in Lambda

    print("event.session.application.applicationId=" +
          event['session']['application']['applicationId'])

    if event['session']['application']['applicationId'] != application_id:
        raise ValueError("Invalid Application ID")

    if event['session']['new']:
        on_session_started({'requestId': event['request']['requestId']}, event['session'])

    request_type = event['request']['type']
    if request_type == "LaunchRequest":
        return on_launch(event['request'], event['session'])
    elif request_type == "IntentRequest":
        return on_intent(event['request'], event['session'])
    elif request_type == "SessionEndedRequest":
        return on_session_ended(event['request'], event['session'])

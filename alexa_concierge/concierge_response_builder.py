def build_response(session_attributes, speechlet_response):
    return {
        'version': '1.0',
        'sessionAttributes': session_attributes,
        'response': speechlet_response
    }


def build_speechlet_response(title, output, reprompt_text, should_end_session):
    if title:
        card = {
                'type': 'Simple',
                'content': "SessionSpeechlet - " + output,
                'title': "SessionSpeechlet - " + title
        }
    else:
        card = None
    return {
        'outputSpeech': {
            'ssml': output,
            'type': 'SSML'
        },
        'card': card,
        'reprompt': {
            'outputSpeech': {
                'type': 'PlainText',
                'text': reprompt_text
            }
        },
        'shouldEndSession': should_end_session
    }
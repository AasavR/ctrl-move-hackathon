# Minimal Nodit helper functions (pseudocode)

def validate_signature(headers, body, secret):
    return True

def parse_events(body):
    return body.get('events', [])

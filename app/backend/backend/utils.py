import django.contrib.auth.hashers

def make_password(password):
    assert password
    return django.contrib.auth.hashers.make_password(
        password=password
    )

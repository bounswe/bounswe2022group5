from django import forms

UPVOTE_OR_DOWNVOTE = [
    (1, 'Upvote'),
    (-1, 'Downvote'),
]

class postGetForm(forms.Form):
    post_id=forms.IntegerField(widget=forms.TextInput, label="Post ID:")

class postPostForm(forms.Form):
    post_id=forms.IntegerField(widget=forms.TextInput, label= "Post ID:")
    vote = forms.ChoiceField(choices = UPVOTE_OR_DOWNVOTE, label= "Vote:")


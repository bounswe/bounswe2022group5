from django import forms

UPVOTE_OR_DOWNVOTE = [
    (1, 'Upvote'),
    (-1, 'Downvote'),
]

class commentGetForm(forms.Form):
    comment_id=forms.IntegerField(widget=forms.TextInput, label="Comment ID:")

class commentPostForm(forms.Form):
    comment_id=forms.IntegerField(widget=forms.TextInput, label= "Comment ID:")
    vote = forms.ChoiceField(choices = UPVOTE_OR_DOWNVOTE, label= "Vote:")
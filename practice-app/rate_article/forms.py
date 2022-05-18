from django import forms

UPVOTE_OR_DOWNVOTE = [
    (1, 'Upvote'),
    (-1, 'Downvote'),
]

class articleGetForm(forms.Form):
    article_id=forms.IntegerField(widget=forms.TextInput, label="Article ID:")

class articlePostForm(forms.Form):
    article_id=forms.IntegerField(widget=forms.TextInput, label= "Article ID:")
    vote = forms.ChoiceField(choices = UPVOTE_OR_DOWNVOTE, label= "Vote:")


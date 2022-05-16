from django import forms
class articleGetForm(forms.Form):
    article_id=forms.IntegerField(widget=forms.TextInput)

class articlePostForm(forms.Form):
    article_id=forms.IntegerField(widget=forms.TextInput)
    title = forms.CharField(widget=forms.TextInput)
    body=forms.CharField(widget=forms.Textarea)
    category = forms.CharField(widget=forms.TextInput)
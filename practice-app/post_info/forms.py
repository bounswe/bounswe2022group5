from django import forms
class postGetForm(forms.Form):
    post_id=forms.IntegerField(widget=forms.TextInput)

class postPostForm(forms.Form):
    post_id=forms.IntegerField(widget=forms.TextInput)
    title = forms.CharField(widget=forms.TextInput)
    body=forms.CharField(widget=forms.Textarea)
    category = forms.CharField(widget=forms.TextInput)
    country = forms.CharField(widget=forms.TextInput)


from django import forms

class commentGetForm(forms.Form):
    post_id=forms.IntegerField()

class commentPostForm(forms.Form):
    post_id=forms.IntegerField()
    body=forms.CharField(widget=forms.Textarea)
    city_name=forms.CharField(widget=forms.TextInput)

from django import forms
class commentGetForm(forms.Form):
    post_id=forms.IntegerField(widget=forms.TextInput)

class commentPostForm(forms.Form):
    post_id=forms.IntegerField(widget=forms.TextInput)
    body=forms.CharField(widget=forms.Textarea)
    city_name=forms.CharField(widget=forms.TextInput)
